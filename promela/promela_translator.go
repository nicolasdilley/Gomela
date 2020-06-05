package promela

import (
	"fmt"
	"go/ast"
	"go/token"
	"go/types"
	"path/filepath"
	"strconv"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
	"github.com/nicolasdilley/gomela/promela/promela_types"
	"golang.org/x/tools/go/packages"
)

var (
	CHAN_NAME = "_ch"
)

type Model struct {
	Project_name    string // the full name of  project (eg. "nicolasdilley/Gomela")
	Package         string // the name of the package
	Name            string // the name of the file that will be generated. (Composed of "pack_functionName_numOfParam")
	Commit          string // the commit of the project
	Fileset         *token.FileSet
	Proctypes       []*promela_ast.Proctype  // the processes representing the users and the recursive function of the model
	Inlines         []*promela_ast.Inline    // the inlines function that represent the commpar args that are function calls
	Fun             *ast.FuncDecl            // the function being modelled
	Chans           map[ast.Expr]*ChanStruct // the promela chan used in the module mapped to their go expr
	Init            *promela_ast.InitDef
	LTL_Properties  []promela_ast.LTL_property
	Global_vars     []promela_ast.Stmt       // the global variable used in the ltl properties
	Defines         []promela_ast.DefineStmt // the communications paramer
	process_counter int                      // to give unique name to Promela processes
	func_counter    int                      // to give unique name to inline func call
	For_counter     *ForCounter              // Used to translate the for loop to break out properly out of them
	Counter         int                      // used to differentiate call expr channels
	Counters        []Counter                // The information that needs to be logged by the logger
	Default_lb      int
	Default_ub      int
}

type ProjectInfo struct {
	Project_name string // the name of the project
	Fileset      *token.FileSet
	AstMap       map[string]*packages.Package // the map used to find the type of the channels
	Chan_closing bool
}

type Chan_info struct {
	Name ast.Expr
	Size promela_ast.Ident
}

type Bound struct {
	Name ast.Expr
	Var  promela_ast.Ident
	Val  int
}

type Counter struct {
	Proj_name string
	Fun       string
	Name      string
	Info      string
	Line      int
	Filename  string
	Commit    string
}

// Take a go function and translate it to a Promela module
func (m *Model) GoToPromela(f *token.FileSet, ast_map map[string]*packages.Package) {
	project := &ProjectInfo{
		Fileset:      f,
		AstMap:       ast_map,
		Chan_closing: false,
	}

	m.Fileset = f // little hack
	m.Name = m.Package + "_" + m.Fun.Name.String()
	commPars := m.AnalyseCommParam(f, m.Package, m.Fun, ast_map)

	//. Create a global var for each
	for _, commPar := range commPars {

		commPar_decl := promela_ast.DefineStmt{Name: promela_ast.Ident{Name: commPar.Name.Name}, Rhs: &promela_ast.Ident{Name: "??"}, Define: f.Position(commPar.Name.Pos())}
		if !commPar.Mandatory {
			// Not given
			commPar_decl.Rhs = &promela_ast.Ident{Name: "-1"}
		}
		m.Defines = append(m.Defines, commPar_decl)

		m.Counters = append(m.Counters, Counter{
			Proj_name: m.Project_name,
			Fun:       m.Fun.Name.String(),
			Name:      "Comm param",
			Info:      "Name :" + commPar.Name.Name + " Mandatory : " + strconv.FormatBool(commPar.Mandatory),
			Line:      commPar_decl.Define.Line,
			Commit:    m.Commit,
			Filename:  commPar_decl.Define.Filename,
		})
	}
	m.Init = &promela_ast.InitDef{Def: f.Position(m.Fun.Pos()), Body: m.TranslateBlockStmt(project, m.Fun.Body)}

	init_block := &promela_ast.BlockStmt{List: []promela_ast.Stmt{
		&promela_ast.DeclStmt{Name: promela_ast.Ident{Name: "i"}, Types: promela_types.Int},
		&promela_ast.DeclStmt{Name: promela_ast.Ident{Name: "state"}, Types: promela_types.Bool, Rhs: &promela_ast.Ident{Name: "false"}}}}

	m.Init = &promela_ast.InitDef{Body: &promela_ast.BlockStmt{List: append(init_block.List, m.Init.Body.List...)}}

	Print(project, m)

}

// take a go block stmt and returns its promela counterpart
func (m *Model) TranslateBlockStmt(p *ProjectInfo, b *ast.BlockStmt) *promela_ast.BlockStmt {
	block_stmt := &promela_ast.BlockStmt{Block: p.Fileset.Position(b.Pos()), List: []promela_ast.Stmt{}}
	defer_stmts := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	for _, stmt := range b.List {
		switch stmt := stmt.(type) {
		case *ast.AssignStmt:

			for i := len(stmt.Rhs) - 1; i >= 0; i-- {
				switch call := stmt.Rhs[i].(type) {
				case *ast.CallExpr:
					switch ident := call.Fun.(type) {
					case *ast.Ident:
						if ident.Name == "make" && len(call.Args) > 0 { // possibly a new chan

							switch call.Args[0].(type) {
							case *ast.ChanType:
								if !m.For_counter.In_for {
									// a new channel is found lets change its name, rename it in function and add to struct
									chan_name := ast.Ident{Name: CHAN_NAME + strconv.Itoa(len(m.Chans))}

									b.List = RenameBlockStmt(b, []ast.Expr{stmt.Lhs[i]}, &chan_name).List
									channel := &ChanStruct{Name: promela_ast.Ident{Name: chan_name.Name, Ident: p.Fileset.Position(ident.Pos())}, Chan: p.Fileset.Position(stmt.Pos())}
									chan_def := &promela_ast.DeclStmt{Name: promela_ast.Ident{Name: chan_name.Name}, Types: promela_types.Chandef}
									if len(call.Args) > 1 {
										channel.Buffered = true
										channel.Size = m.lookUp(p, call.Args[1])

									} else {
										channel.Size = promela_ast.Ident{Name: "0"}
									}
									alias_chan := &promela_ast.Chandef{Name: promela_ast.Ident{Name: chan_name.Name + "_in"}, Types: []promela_types.Types{promela_types.Int}, Size: channel.Size}
									set_chan := &promela_ast.AssignStmt{Lhs: &promela_ast.Ident{Name: chan_name.Name + ".in"}, Rhs: &promela_ast.Ident{Name: chan_name.Name + "_in"}}
									call_monitor := &promela_ast.RunStmt{X: promela_ast.CallExpr{Fun: promela_ast.Ident{Name: "chanMonitor"}, Args: []promela_ast.Expr{&promela_ast.Ident{Name: chan_name.Name}}}}

									m.Chans[stmt.Lhs[i]] = channel

									block_stmt.List = append([]promela_ast.Stmt{chan_def, alias_chan}, block_stmt.List...)
									block_stmt.List = append(block_stmt.List, set_chan, call_monitor)
								} else {
									m.Counters = append(m.Counters, Counter{
										Proj_name: m.Project_name,
										Fun:       m.Fun.Name.String(),
										Name:      "Chan in for",
										Line:      p.Fileset.Position(ident.Pos()).Line,
										Commit:    m.Commit,
										Filename:  p.Fileset.Position(ident.Pos()).Filename,
									})
									// panic("Channel created inside a for loop")
								}
							}
						}
					}
				}
			}
			addBlock(block_stmt, m.translateAssignStmt(p, stmt))
		case *ast.DeclStmt:

			switch decl := stmt.Decl.(type) {
			case *ast.GenDecl:
				for _, spec := range decl.Specs {
					switch val := spec.(type) {
					case *ast.ValueSpec:
						for i, rhs := range val.Values {
							switch call := rhs.(type) {
							case *ast.CallExpr:
								switch ident := call.Fun.(type) {
								case *ast.Ident:
									if ident.Name == "make" && len(call.Args) > 0 { // possibly a new chan
										switch call.Args[0].(type) {
										case *ast.ChanType:
											if !m.For_counter.In_for {
												chan_name := ast.Ident{Name: CHAN_NAME + strconv.Itoa(len(m.Chans))}
												// a new channel is found lets change its name, rename it in function and add to struct
												b.List = RenameBlockStmt(b, []ast.Expr{val.Names[i]}, &chan_name).List
												channel := &ChanStruct{Name: promela_ast.Ident{Name: chan_name.Name, Ident: p.Fileset.Position(ident.Pos())}, Chan: p.Fileset.Position(stmt.Pos())}
												chan_def := &promela_ast.DeclStmt{Name: promela_ast.Ident{Name: chan_name.Name}, Types: promela_types.Chandef}

												if len(call.Args) > 1 {
													channel.Buffered = true
													channel.Size = m.lookUp(p, call.Args[1])
												} else {
													channel.Size = promela_ast.Ident{Name: "0"}
												}
												alias_chan := &promela_ast.Chandef{Name: promela_ast.Ident{Name: chan_name.Name + "_in"}, Types: []promela_types.Types{promela_types.Int}, Size: channel.Size}
												set_chan := &promela_ast.AssignStmt{Lhs: &promela_ast.Ident{Name: chan_name.Name + ".in"}, Rhs: &promela_ast.Ident{Name: chan_name.Name + "_in"}}
												call_monitor := &promela_ast.RunStmt{X: promela_ast.CallExpr{Fun: promela_ast.Ident{Name: "chanMonitor"}, Args: []promela_ast.Expr{&promela_ast.Ident{Name: chan_name.Name}}}}

												m.Chans[val.Names[i]] = channel
												block_stmt.List = append([]promela_ast.Stmt{chan_def, alias_chan}, block_stmt.List...)
												block_stmt.List = append(block_stmt.List, set_chan, call_monitor)
											} else {
												m.Counters = append(m.Counters, Counter{
													Proj_name: m.Project_name,
													Fun:       m.Fun.Name.String(),
													Name:      "Chan in for",
													Line:      p.Fileset.Position(ident.Pos()).Line,
													Commit:    m.Commit,
													Filename:  p.Fileset.Position(ident.Pos()).Filename,
												})
												// fmt.Printf("Channel created inside a for loop")
												// Need to log that
											}
										}
									}
								}
							}
						}
					}
				}
			}
			addBlock(block_stmt, m.translateDeclStmt(p, stmt))
		case *ast.GoStmt:
			addBlock(block_stmt, m.TranslateGoStmt(p, stmt))
		case *ast.ExprStmt:
			addBlock(block_stmt, m.translateExprStmt(p, stmt))
		case *ast.ForStmt:
			addBlock(block_stmt, m.translateForStmt(p, stmt))
		case *ast.SendStmt:
			addBlock(block_stmt, m.translateSendStmt(p, stmt))
		case *ast.RangeStmt:
			addBlock(block_stmt, m.translateRangeStmt(p, stmt))
		case *ast.ReturnStmt:
			addBlock(block_stmt, m.translateReturnStmt(p, stmt))
		case *ast.SelectStmt:
			addBlock(block_stmt, m.translateSelectStmt(p, stmt))
		case *ast.SwitchStmt:
			addBlock(block_stmt, m.translateSwitchStmt(p, stmt))
		case *ast.LabeledStmt:
			addBlock(block_stmt, m.translateLabeledStmt(p, stmt))
		case *ast.BranchStmt:
			addBlock(block_stmt, m.translateBranchStmt(p, stmt))
		case *ast.DeferStmt:
			defer_stmts.Block = p.Fileset.Position(stmt.Pos())
			addBlock(defer_stmts, m.TranslateExpr(p, stmt.Call))
		case *ast.IfStmt:
			addBlock(block_stmt, m.translateIfStmt(p, stmt))
		}
	}

	addBlock(block_stmt, defer_stmts)
	return block_stmt
}

func (m *Model) translateIfStmt(p *ProjectInfo, s *ast.IfStmt) *promela_ast.BlockStmt {
	b := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	i := &promela_ast.IfStmt{If: p.Fileset.Position(s.Pos())}

	addBlock(b, m.TranslateBlockStmt(p, &ast.BlockStmt{List: []ast.Stmt{s.Init}}))

	stmts := m.TranslateBlockStmt(p, s.Body)
	contains := false
	if len(stmts.List) != 0 {
		contains = true
		i.Guards = append(i.Guards, promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: stmts})
	}

	switch block := s.Else.(type) {
	case *ast.BlockStmt:
		stmts := m.TranslateBlockStmt(p, block)
		if len(stmts.List) != 0 {
			contains = true
			i.Guards = append(i.Guards, promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: stmts})
		}
	default:
		if s.Else != nil {
			stmts := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
			switch els := s.Else.(type) {
			case *ast.BlockStmt:
				stmts = m.TranslateBlockStmt(p, els)
			default:
				stmts = m.TranslateBlockStmt(p, &ast.BlockStmt{List: []ast.Stmt{s.Else}})
			}
			if len(stmts.List) != 0 {
				contains = true
				i.Guards = append(i.Guards, promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: stmts})
			}
		} else if contains {
			i.Guards = append(i.Guards, promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: &promela_ast.BlockStmt{}})
		}
	}

	if contains {
		b.List = append(b.List, i)
	}
	return b
}

func (m *Model) TranslateGoStmt(p *ProjectInfo, s *ast.GoStmt) *promela_ast.BlockStmt {
	// Find the declaration of the call
	stmts := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}

	var fun string       // The name of the function we are translating
	var func_name string // The corresponding promela function name consisting of package + fun + num of param + len(proctypes)
	var pack_name string = m.Package
	call_expr := s.Call
	prom_call := promela_ast.CallExpr{Call: p.Fileset.Position(call_expr.Pos())}

	switch name := call_expr.Fun.(type) {
	case *ast.FuncLit: // in the case we have an anonymous func call
		func_name = "Anonymous" + strconv.Itoa(len(m.Proctypes))

		proc := &promela_ast.Proctype{Name: promela_ast.Ident{Name: func_name, Ident: p.Fileset.Position(s.Pos())}, Pos: p.Fileset.Position(call_expr.Pos()), Active: false, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}
		prom_call.Fun = promela_ast.Ident{Name: func_name, Ident: p.Fileset.Position(s.Pos())}
		counter := 0
		for _, field := range m.Fun.Type.Params.List {
			for _, n := range field.Names {
				switch field.Type.(type) {
				case *ast.ChanType:

					proc.Params = append(proc.Params, promela_ast.Param{Name: n.Name, Types: promela_types.Chandef})

					chan_name := m.TranslateArgs(p, n)

					prom_call.Args = append(prom_call.Args, chan_name)
					m.Chans[n] = &ChanStruct{Name: promela_ast.Ident{Name: n.Name}}

				}

				counter++
			}
		}
		chans := AnalyseFuncCall(p.Fileset, m.Fun, p.AstMap[m.Package]) // Returns the channels that are declared before the call

		for _, ch := range chans {
			proc.Params = append(proc.Params, promela_ast.Param{Name: TranslateIdent(p, ch.Name).Name, Types: promela_types.Chandef})

			prom_call.Args = append(prom_call.Args, m.TranslateArgs(p, ch.Name))
		}

		r := &promela_ast.RunStmt{X: prom_call, Run: p.Fileset.Position(s.Pos())}
		stmts.List = append(stmts.List, r)

		counter = 0
		for _, field := range name.Type.Params.List {
			for _, n := range field.Names {
				switch field.Type.(type) {
				case *ast.ChanType:
					RenameBlockStmt(name.Body, []ast.Expr{n}, call_expr.Args[counter])
					m.Chans[call_expr.Args[counter]] = &ChanStruct{Name: translateIdent(call_expr.Args[counter])}
				}
				counter++
			}
		}
		proc.Body = m.TranslateBlockStmt(p, name.Body)
		m.Proctypes = append(m.Proctypes, proc) // adding the new proc type to the list of proctype

	default:

		// Find name of function
		switch name := call_expr.Fun.(type) {
		case *ast.Ident:
			func_name = filepath.Base(pack_name) + name.Name + strconv.Itoa(len(call_expr.Args))
			fun = name.Name
		case *ast.SelectorExpr:
			func_name = FindIdent(name.X).Name + name.Sel.Name + strconv.Itoa(len(call_expr.Args))
			fun = name.Sel.Name
			pack_name = FindIdent(name.X).Name
		}
		if found, decl := FindDecl(pack_name, fun, len(call_expr.Args), p.AstMap); found {

			hasChan := false
			for _, field := range decl.Type.Params.List {
				switch field.Type.(type) {
				case *ast.ChanType:
					hasChan = true
				}
			}
			if hasChan {
				func_name = "go_" + func_name
				if !m.CallExists(func_name) {
					proc := &promela_ast.Proctype{Name: promela_ast.Ident{Name: func_name}, Pos: p.Fileset.Position(call_expr.Pos()), Active: false, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}
					proc.Params = []promela_ast.Param{}

					counter := 0
					for _, field := range decl.Type.Params.List {
						for _, name := range field.Names {
							if counter < len(call_expr.Args) {
								switch field.Type.(type) {
								case *ast.ChanType:

									proc.Params = append(proc.Params, promela_ast.Param{Name: name.Name, Types: promela_types.Chandef})
									m.Chans[name] = &ChanStruct{Name: promela_ast.Ident{Name: name.Name}, Chan: p.Fileset.Position(name.Pos())}
								// decl.Body = RenameBlockStmt(decl.Body, []ast.Expr{name}, call_expr.Args[counter])
								default:
									// the arg is not a channel therefore we include what it does before the call
									addBlock(stmts, m.TranslateExpr(p, call_expr.Args[counter]))
								}
							}
							counter++
						}
					}

					// Translate the commPar of the function call ignoring the args that are not needed
					commPars := m.AnalyseCommParam(p.Fileset, pack_name, decl, p.AstMap) // recover the commPar

					// Add the commparam to the param of the new proc
					for _, commPar := range commPars {
						decl.Type.Params.List[commPar.Pos].Names[0] = &ast.Ident{Name: commPar.Name.Name + "_1"}
						RenameBlockStmt(decl.Body, []ast.Expr{commPar.Name}, &ast.Ident{Name: commPar.Name.Name + "_1"})
						proc.Params = append(proc.Params, promela_ast.Param{Name: commPar.Name.Name + "_1", Types: promela_types.Int})
					}

					m.Proctypes = append(m.Proctypes, proc)
					proc.Body = m.TranslateBlockStmt(p, decl.Body)
				}

				counter := 0
				for _, field := range decl.Type.Params.List {
					for range field.Names {
						if counter < len(call_expr.Args) {
							switch field.Type.(type) {
							case *ast.ChanType:
								prom_call.Args = append(prom_call.Args, m.TranslateArgs(p, call_expr.Args[counter]))
							default:
								// the arg is not a channel therefore we include what it does before the call
								addBlock(stmts, m.TranslateExpr(p, call_expr.Args[counter]))
							}
						}

						counter++
					}
				}

				// Translate the commPar of the function call ignoring the args that are not needed
				commPars := m.AnalyseCommParam(p.Fileset, pack_name, decl, p.AstMap) // recover the commPar

				for _, commPar := range commPars {
					prom_call.Args = append(prom_call.Args, m.TranslateArgs(p, call_expr.Args[commPar.Pos]))
				}
				prom_call.Fun = promela_ast.Ident{Name: func_name, Ident: p.Fileset.Position(call_expr.Pos())}

				r := &promela_ast.RunStmt{X: prom_call, Run: p.Fileset.Position(s.Pos())}

				stmts.List = append(stmts.List, r)

				if m.For_counter.In_for {
					m.For_counter.With_go = true
					m.Counters = append(m.Counters, Counter{
						Proj_name: m.Project_name,
						Fun:       m.Fun.Name.String(),
						Name:      "Go in for",
						Line:      p.Fileset.Position(s.Pos()).Line,
						Commit:    m.Commit,
						Filename:  p.Fileset.Position(s.Pos()).Filename,
					})
				}
			}
		} else {
			fmt.Print("promela_translator.go : Func of go statement not found : " + func_name + "\n Called at :")
			fmt.Println(p.Fileset.Position(call_expr.Fun.Pos()))

			for _, arg := range call_expr.Args {
				for _, e := range m.TranslateExpr(p, arg).List {
					switch e := e.(type) {
					case *promela_ast.RcvStmt:
						stmts.List = append(stmts.List, e)
					}
				}
			}
		}

	}

	return stmts
}

func (m *Model) translateAssignStmt(p *ProjectInfo, s *ast.AssignStmt) *promela_ast.BlockStmt {
	b := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	for _, spec := range s.Rhs {
		addBlock(b, m.TranslateExpr(p, spec))
	}

	return b
}

func (m *Model) translateForStmt(p *ProjectInfo, s *ast.ForStmt) *promela_ast.BlockStmt {
	b := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}

	was_in_for := m.For_counter.In_for //used to check if this is the outer loop
	had_go := m.For_counter.With_go
	// update 'for' counter to generate the appropriate label
	m.For_counter.With_go = false

	if m.For_counter.In_for {
		m.For_counter.Y++
	} else {
		m.For_counter.X++
		m.For_counter.In_for = true
	}

	label_name := fmt.Sprintf("for%d%d", m.For_counter.X, m.For_counter.Y)

	addBlock(b, m.TranslateExpr(p, s.Cond)) // translating the condition in case there is a <-a

	addBlock(b, m.TranslateBlockStmt(p, &ast.BlockStmt{List: []ast.Stmt{s.Init}}))

	addBlock(b, m.TranslateBlockStmt(p, &ast.BlockStmt{List: []ast.Stmt{s.Post}}))

	for_label := &promela_ast.LabelStmt{Name: label_name + "_exit"}

	lb, ub := p.lookUpFor(s, m, p.AstMap[m.Package])

	// Translated body of for loop
	body := promela_ast.BlockStmt{List: append(
		[]promela_ast.Stmt{&promela_ast.LabelStmt{Name: label_name}},
		m.TranslateBlockStmt(p, s.Body).List...)}

	if m.For_counter.With_go {

		// need to change the for loop into a bounded for loop
		b.List = append(b.List, &promela_ast.ForStmt{
			For:  p.Fileset.Position(s.Pos()),
			Lb:   lb,
			Ub:   ub,
			Body: body,
		})

	} else {
		// print the with the if
		if_stmt := promela_ast.IfStmt{If: p.Fileset.Position(s.Pos())}

		lb_not_given := promela_ast.BinaryExpr{Lhs: &lb, Rhs: &promela_ast.Ident{Name: "-1"}, Op: "!="}
		ub_not_given := promela_ast.BinaryExpr{Lhs: &ub, Rhs: &promela_ast.Ident{Name: "-1"}, Op: "!="}
		then := promela_ast.GuardStmt{
			Cond: &promela_ast.BinaryExpr{Lhs: &lb_not_given,
				Rhs: &ub_not_given, Op: "&&"},
			Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&promela_ast.ForStmt{For: p.Fileset.Position(s.Pos()), Lb: lb, Ub: ub, Body: body}}},
		}
		// the else part
		d := &promela_ast.DoStmt{Do: p.Fileset.Position(s.Pos())}

		d.Guards = append(
			d.Guards,
			promela_ast.GuardStmt{
				Cond: &promela_ast.Ident{Name: "true"},
				Body: &body},
		)

		// adding the option to break of the for loop
		d.Guards = append(d.Guards, promela_ast.GuardStmt{
			Cond: &promela_ast.Ident{Name: "true"},
			Body: &promela_ast.BlockStmt{
				List: []promela_ast.Stmt{&promela_ast.Ident{Name: "break"}}}})
		// b.List = append(b.List, d)

		els := promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "else"}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{d}}}

		if_stmt.Guards = []promela_ast.GuardStmt{then, els}

		b.List = append(b.List, &if_stmt)
	}

	b.List = append(b.List, for_label)

	if !was_in_for { // if outer loop set in for to false and reset y
		m.For_counter.In_for = false
		m.For_counter.Y = 0
	}
	m.For_counter.With_go = false

	if had_go {
		m.For_counter.With_go = true
	}

	return b
}

func (m *Model) translateRangeStmt(p *ProjectInfo, s *ast.RangeStmt) *promela_ast.BlockStmt {
	b := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	d := &promela_ast.DoStmt{Do: p.Fileset.Position(s.Pos())}

	had_go := m.For_counter.With_go
	was_in_for := m.For_counter.In_for //used to check if this is the outer loop
	// update 'for' counter to generate the appropriate label
	if m.For_counter.In_for {
		m.For_counter.Y++
	} else {
		m.For_counter.X++
		m.For_counter.In_for = true
	}

	label_name := fmt.Sprintf("for%d%d", m.For_counter.X, m.For_counter.Y)

	if m.containsChan(s.X) {
		chan_struct := m.getChanStruct(s.X)

		do_guard := promela_ast.GuardStmt{Cond: &promela_ast.RcvStmt{Chan: &promela_ast.Ident{Name: chan_struct.Name.Name + ".is_closed"}, Rhs: &promela_ast.Ident{Name: "state"}}}
		if_closed_guard := promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "state"}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&promela_ast.Ident{Name: "break"}}}}

		if_not_closed_guard := promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "else"}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&promela_ast.RcvStmt{Chan: &promela_ast.Ident{Name: chan_struct.Name.Name + ".in"}, Rhs: &promela_ast.Ident{Name: "0"}}}}}

		if_not_closed_guard.Body.List = append(if_not_closed_guard.Body.List, m.TranslateBlockStmt(p, s.Body).List...)

		body := &promela_ast.BlockStmt{List: []promela_ast.Stmt{&promela_ast.CondStmt{Guards: []promela_ast.GuardStmt{if_closed_guard, if_not_closed_guard}}}}
		do_guard.Body = body
		d.Guards = append(d.Guards, do_guard)
		b.List = append(b.List, d)
	} else {

		block_stmt := m.TranslateBlockStmt(p, s.Body)
		// add the 'for' label
		block_stmt.List = append([]promela_ast.Stmt{&promela_ast.LabelStmt{Name: label_name}}, block_stmt.List...)

		if m.For_counter.With_go {

			// need to change the for loop into a bounded for loop
			ub := m.lookUp(p, s.X)
			b.List = append(b.List, &promela_ast.ForStmt{For: p.Fileset.Position(s.Pos()), Lb: promela_ast.Ident{Name: "1"}, Ub: ub, Body: *block_stmt})
		} else {
			d.Guards = append(d.Guards, promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: block_stmt})
			b.List = append(b.List, d)
		}
	}

	if !was_in_for { // if outer loop set in for to false and reset y
		m.For_counter.In_for = false
		m.For_counter.Y = 0
	}
	m.For_counter.With_go = false

	if had_go {
		m.For_counter.With_go = true
	}

	return b
}

func (m *Model) translateSwitchStmt(p *ProjectInfo, s *ast.SwitchStmt) *promela_ast.BlockStmt {
	b := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	i := &promela_ast.IfStmt{If: p.Fileset.Position(s.Pos()), Init: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}

	i.Init = m.TranslateExpr(p, s.Tag)

	addBlock(i.Init, m.TranslateBlockStmt(p, &ast.BlockStmt{List: []ast.Stmt{s.Init}}))

	for _, stmt := range s.Body.List {
		switch stmt := stmt.(type) {
		case *ast.CaseClause:

			for _, e := range stmt.List {
				addBlock(b, m.TranslateExpr(p, e))
			}
			guard := &promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: m.TranslateBlockStmt(p, &ast.BlockStmt{List: stmt.Body})}

			i.Guards = append(i.Guards, *guard)
		default:
			fmt.Println("Promela_translator.go: in a switch and its not a case clause or a default")
		}
	}

	b.List = append(b.List, i)

	return b
}

func (m *Model) translateSelectStmt(p *ProjectInfo, s *ast.SelectStmt) *promela_ast.BlockStmt {
	b := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	i := &promela_ast.SelectStmt{Select: p.Fileset.Position(s.Pos())}

	for _, comm := range s.Body.List {
		switch comm := comm.(type) {
		case *ast.CommClause: // can only be a commClause
			guard := promela_ast.GuardStmt{Guard: p.Fileset.Position(comm.Pos()), Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}
			if comm.Comm != nil { // check if default select

				block_stmt := m.TranslateBlockStmt(p, &ast.BlockStmt{List: []ast.Stmt{comm.Comm}})
				if len(block_stmt.List) > 0 {
					guard.Cond = block_stmt.List[0]

					if len(block_stmt.List) > 1 { // add the rest to the body of the case (Especially the check to the close channel)
						guard.Body.List = block_stmt.List[1:]
					}
				} else {
					fmt.Println("stmt_translator, translateSelectStatement: A case was found on a channel that could not be found ! ")

					guard.Cond = &promela_ast.Ident{Name: "true"}
				}
			} else { // it is default
				i.Has_default = true
				guard.Cond = &promela_ast.Ident{Name: "true"}
			}
			guard.Body.List = append(guard.Body.List, m.TranslateBlockStmt(p, &ast.BlockStmt{List: comm.Body}).List...)

			if !containsBreak(guard.Body) && !containsReturn(guard.Body) { // no return or break then just break
				guard.Body.List = append(guard.Body.List, &promela_ast.Ident{Name: "break"})
			} else {
				if containsBreak(guard.Body) {
					// removes the break to replace it with a goto
					guard.Body.List = guard.Body.List[:len(guard.Body.List)-1]
					// add a goto end of select and break
					guard.Body.List = append(guard.Body.List, &promela_ast.GotoStmt{Label: fmt.Sprintf("for%d%d_exit", m.For_counter.X, m.For_counter.Y)})
				}
			}

			i.Guards = append(i.Guards, guard)

		}
	}

	b.List = append([]promela_ast.Stmt{i}, b.List...)

	return b
}

func (m *Model) translateExprStmt(p *ProjectInfo, s *ast.ExprStmt) *promela_ast.BlockStmt {
	b := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	addBlock(b, m.TranslateExpr(p, s.X))
	return b
}

func (m *Model) translateSendStmt(p *ProjectInfo, s *ast.SendStmt) *promela_ast.BlockStmt {
	b := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	i := &promela_ast.SendStmt{Send: p.Fileset.Position(s.Pos())}

	channel := m.getChanStruct(s.Chan)

	if channel != nil {
		chan_name := TranslateIdent(p, s.Chan)
		i.Chan = &promela_ast.SelectorExpr{X: &chan_name, Sel: promela_ast.Ident{Name: "in"}}

		addBlock(b, m.TranslateExpr(p, s.Value))

		i.Rhs = &promela_ast.Ident{Name: "0"}

		b.List = append(b.List, i)

		closed_chan := &promela_ast.SelectorExpr{X: &chan_name, Sel: promela_ast.Ident{Name: "sending"}}
		b.List = append(b.List, &promela_ast.RcvStmt{Chan: closed_chan, Rhs: &promela_ast.Ident{Name: "state"}})
	}
	return b

}

func (m *Model) translateDeclStmt(p *ProjectInfo, s *ast.DeclStmt) *promela_ast.BlockStmt {
	b := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	switch d := s.Decl.(type) {
	case *ast.GenDecl:
		for _, spec := range d.Specs {
			switch spec := spec.(type) {
			case *ast.ValueSpec:
				for _, val := range spec.Values {
					addBlock(b, m.TranslateExpr(p, val))
				}
			}

		}
	}
	return b
}

func (m *Model) translateReturnStmt(p *ProjectInfo, s *ast.ReturnStmt) *promela_ast.BlockStmt {
	b := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	for _, spec := range s.Results {
		addBlock(b, m.TranslateExpr(p, spec))
	}

	b.List = append(b.List,
		&promela_ast.GotoStmt{
			Goto:  p.Fileset.Position(s.Pos()),
			Label: "stop_process"})
	return b
}

func (m *Model) translateBranchStmt(p *ProjectInfo, s *ast.BranchStmt) *promela_ast.BlockStmt {
	b := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	br := &promela_ast.GotoStmt{
		Goto: p.Fileset.Position(s.Pos()),
	}

	if s.Tok == token.BREAK {

		if s.Label != nil {
			br.Label = translateIdent(s.Label).Name
			b.List = append(b.List, br)
		} else {
			b.List = append(b.List, &promela_ast.Ident{Name: "break"})
		}
	} else if s.Tok == token.GOTO {
		br.Label = translateIdent(s.Label).Name
		b.List = append(b.List, br)
	}

	return b
}

func (m *Model) translateLabeledStmt(p *ProjectInfo, s *ast.LabeledStmt) *promela_ast.BlockStmt {
	b := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	label := &promela_ast.LabelStmt{Label: p.Fileset.Position(s.Pos()), Name: s.Label.Name}

	b.List = append(b.List, label, m.TranslateBlockStmt(p, &ast.BlockStmt{List: []ast.Stmt{s.Stmt}}))

	return b
}

func (m *Model) TranslateExpr(p *ProjectInfo, expr ast.Expr) *promela_ast.BlockStmt {
	stmts := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	switch expr := expr.(type) {
	case *ast.BinaryExpr:
		addBlock(stmts, m.TranslateExpr(p, expr.X))
		addBlock(stmts, m.TranslateExpr(p, expr.Y))
	case *ast.CallExpr:
		switch name := expr.Fun.(type) {
		case *ast.Ident:
			if name.Name == "close" && len(expr.Args) == 1 { // closing a chan
				// chan_struct := m.getChanStruct(expr.Args[0])
				send := &promela_ast.SendStmt{Send: p.Fileset.Position(name.Pos())}
				ch := TranslateIdent(p, expr.Args[0])
				send.Chan = &promela_ast.SelectorExpr{
					X: &ch, Sel: promela_ast.Ident{Name: "closing"},
					Pos: p.Fileset.Position(expr.Args[0].Pos()),
				}
				send.Rhs = &promela_ast.Ident{Name: "true"}
				p.Chan_closing = true
				stmts.List = append(stmts.List, send)

			} else {
				addBlock(stmts, m.TranslateCallExpr(p, expr, p.AstMap[m.Package].TypesInfo.ObjectOf(name)))
			}

		case *ast.SelectorExpr:
			// could be a call on a struct
			obj := p.AstMap[m.Package].TypesInfo.ObjectOf(FindIdent(name.X))
			if obj != nil {

				obj := p.AstMap[m.Package].TypesInfo.ObjectOf(name.Sel)
				if obj != nil {
					switch obj.Type().(type) {
					case *types.Signature:
						contains := false
						for _, arg := range expr.Args {
							switch u := arg.(type) {
							case *ast.UnaryExpr:
								if u.Op == token.ARROW {
									contains = true

								}
							}
						}

						if contains {
							addBlock(stmts, m.TranslateCallExpr(p, expr, obj))
						}
					}
				}
			}
		case *ast.FuncLit:
			new_block := name.Body
			for i, field := range name.Type.Params.List {
				for _, name := range field.Names {
					new_block = RenameBlockStmt(new_block, []ast.Expr{name}, expr.Args[i])
				}
			}

			return m.TranslateBlockStmt(p, new_block)

		}

	case *ast.UnaryExpr:
		switch expr.Op {
		case token.ARROW:

			channel := m.getChanStruct(expr.X)
			if channel != nil {
				chan_name := m.TranslateArgs(p, expr.X)

				stmts.List = append(stmts.List, &promela_ast.RcvStmt{Chan: &promela_ast.SelectorExpr{X: chan_name, Sel: promela_ast.Ident{Name: "in"}}, Rcv: p.Fileset.Position(expr.Pos()), Rhs: &promela_ast.Ident{Name: "0"}})
			}
		}

	case *ast.ParenExpr:
		addBlock(stmts, m.TranslateExpr(p, expr.X))
	}
	return stmts
}

func addBlock(b1 *promela_ast.BlockStmt, b2 *promela_ast.BlockStmt) {
	for _, b := range b2.List {
		b1.List = append(b1.List, b)
	}
}

// 1. Replace the name of the channel with the name we have in the body of the function
// 2. Create a process with a channel child to act as a return
// 3. Translate the body of the function to Promela.
// 4. Translate arguments that are communication parameters

func (m *Model) TranslateCallExpr(p *ProjectInfo, call_expr *ast.CallExpr, obj types.Object) *promela_ast.BlockStmt {
	stmts := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	if obj != nil {

		var fun string       // The name of the function we are translating
		var func_name string // The corresponding promela function name consisting of package + fun + num of param
		var pack_name string = m.Package

		// Find name of function
		switch name := call_expr.Fun.(type) {
		case *ast.Ident:
			func_name = filepath.Base(pack_name) + name.Name + strconv.Itoa(len(call_expr.Args))
			fun = name.Name
		case *ast.SelectorExpr:
			func_name = FindIdent(name.X).Name + name.Sel.Name + strconv.Itoa(len(call_expr.Args))
			fun = name.Sel.Name
			pack_name = obj.Pkg().Path()
		case *ast.FuncLit:
			panic("Promela_translator.go : Should not have a funclit here")
		}

		if !m.CallExists(func_name) {
			if found, decl := FindDecl(pack_name, fun, len(call_expr.Args), p.AstMap); found {

				hasChan := false

				for _, field := range decl.Type.Params.List {
					switch field.Type.(type) {
					case *ast.ChanType:
						hasChan = true
					}
				}

				if hasChan {
					// Generate a new proctype to model the recursive call
					proc := &promela_ast.Proctype{Name: promela_ast.Ident{Name: func_name}, Pos: p.Fileset.Position(call_expr.Pos()), Active: false, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}
					proc.Params = []promela_ast.Param{}

					var args []promela_ast.Expr = []promela_ast.Expr{} // building the new call's args

					// change the aliases and translate the channel
					for i, arg := range call_expr.Args {
						if m.containsChan(arg) {
							param := findExprFromParams(decl.Type.Params, i)
							proc.Params = append(proc.Params, promela_ast.Param{Name: param.Name, Types: promela_types.Chandef})
							args = append(args, &m.getChanStruct(arg).Name)
						}
					}

					// Translate the commPar of the function call ignoring the args that are not needed
					commPars := m.AnalyseCommParam(p.Fileset, pack_name, decl, p.AstMap) // recover the commPar

					for _, commPar := range commPars {

						RenameChan(decl, commPar.Name, &ast.Ident{Name: commPar.Name.Name + " _1"})
						proc.Params = append(proc.Params, promela_ast.Param{Name: commPar.Name.Name + " _1", Types: promela_types.Int})
						args = append(args, m.TranslateArgs(p, call_expr.Args[commPar.Pos]))
					}
					proc.Params = append(proc.Params, promela_ast.Param{Name: "child", Types: promela_types.Chan})

					prev_decl := *m.Fun
					m.Fun = decl
					proc.Body.List = m.TranslateBlockStmt(p, decl.Body).List
					proc.Body.List = append(proc.Body.List, &promela_ast.SendStmt{Chan: &promela_ast.Ident{Name: "child"}, Rhs: &promela_ast.Ident{Name: "0"}})
					m.Proctypes = append(m.Proctypes, proc)
					m.Fun = &prev_decl

					// add call to the proctype
					args = append(args, &promela_ast.Ident{Name: "child_" + func_name + strconv.Itoa(m.Counter)})

					// add a call to it
					stmts.List = append(stmts.List,
						&promela_ast.Chandef{Name: promela_ast.Ident{Name: "child_" + func_name + strconv.Itoa(m.Counter)}, Size: promela_ast.Ident{Name: "0"}, Types: []promela_types.Types{promela_types.Int}},
						&promela_ast.RunStmt{X: promela_ast.CallExpr{Fun: promela_ast.Ident{Name: func_name}, Args: args}},
						&promela_ast.RcvStmt{Chan: &promela_ast.Ident{Name: "child_" + func_name + strconv.Itoa(m.Counter)}, Rhs: &promela_ast.Ident{Name: "0"}},
					)
					m.Counter++
					// }
				} else {
					// fmt.Print("users_translation.go : Func call not found : " + func_name + "\n Called at :")
					// fmt.Println(p.Fileset.Position(call_expr.Fun.Pos()))

					for _, arg := range call_expr.Args {
						for _, e := range m.TranslateExpr(p, arg).List {
							switch e := e.(type) {
							case *promela_ast.RcvStmt:
								stmts.List = append(stmts.List, e)
							}
						}
					}
				}
			}

		} else {
			if m.CallExists(func_name) { // have we translated this call already?

				// add call to the proctype
				var args []promela_ast.Expr = []promela_ast.Expr{}
				for _, arg := range call_expr.Args {
					if m.containsChan(arg) {
						args = append(args, &m.getChanStruct(arg).Name)
					}
				}
				args = append(args, &promela_ast.Ident{Name: "child_" + func_name + strconv.Itoa(m.Counter)})

				// add a call to it
				stmts.List = append(stmts.List,
					&promela_ast.Chandef{Name: promela_ast.Ident{Name: "child_" + func_name + strconv.Itoa(m.Counter)}, Size: promela_ast.Ident{Name: "0"}, Types: []promela_types.Types{promela_types.Int}},
					&promela_ast.RunStmt{X: promela_ast.CallExpr{Fun: promela_ast.Ident{Name: func_name}, Args: args}},
					&promela_ast.RcvStmt{Chan: &promela_ast.Ident{Name: "child_" + func_name + strconv.Itoa(m.Counter)}, Rhs: &promela_ast.Ident{Name: "0"}},
				)
				m.Counter++
			}
		}
	}

	return stmts
}

func (m *Model) TranslateArgs(p *ProjectInfo, expr ast.Expr) promela_ast.Expr {

	var e1 promela_ast.Expr
	switch expr := expr.(type) {
	case *ast.Ident:

		e1 = &promela_ast.Ident{Name: expr.Name, Ident: p.Fileset.Position(expr.Pos())}

	case *ast.SelectorExpr:

		e1 = &promela_ast.SelectorExpr{
			X:   m.TranslateArgs(p, expr.X),
			Sel: promela_ast.Ident{Name: expr.Sel.Name, Ident: p.Fileset.Position(expr.Pos())},
			Pos: p.Fileset.Position(expr.Pos())}
	case *ast.BinaryExpr:
		e1 = &promela_ast.BinaryExpr{Lhs: m.TranslateArgs(p, expr.X), Op: expr.Op.String(), Rhs: m.TranslateArgs(p, expr.Y)}
	case *ast.UnaryExpr:
		e1 = &promela_ast.ExprStmt{X: m.TranslateArgs(p, expr.X)}
	case *ast.CallExpr:
		// Need to create the call here.
		// if found, fun_decl := FindDecl(m.Package, getIdent(expr.Fun), len(expr.Args), p.AstMap); found{

		// } else {
		// create new inline
		call := promela_ast.CallExpr{Fun: promela_ast.Ident{Name: getIdent(expr.Fun).Name}, Call: p.Fileset.Position(expr.Pos())}

		if !m.containsInline(expr.Fun) { // if the function has not been seen previously lets ask the user for its value

			args := []promela_ast.Expr{}

			for _, arg := range expr.Args {
				args = append(args, m.TranslateArgs(p, arg))
			}
			call.Args = args

			m.Inlines = append(m.Inlines, &promela_ast.Inline{Name: promela_ast.Ident{Name: getIdent(expr.Fun).Name}, Params: args})
		}

		e1 = &call

	case *ast.BasicLit:
		e1 = &promela_ast.Ident{Name: expr.Value}
		// }
	}

	return e1
}

func (m *Model) getChanStruct(expr ast.Expr) *ChanStruct {
	for e, s := range m.Chans {
		if IdenticalExpr(e, expr) {
			return s
		}
	}
	return nil
}

func FindDecl(pack string, func_name string, param_num int, ast_map map[string]*packages.Package) (bool, *ast.FuncDecl) {

	if ast_map[pack] != nil {
		for _, file := range ast_map[pack].Syntax {
			if file.Decls != nil {
				for _, decl := range file.Decls {
					switch decl := decl.(type) {
					case *ast.FuncDecl:

						if func_name == decl.Name.Name {
							if decl.Type.Params.NumFields() == param_num {
								return true, decl
							}
						}
					}
				}
			}
		}
	}
	return false, nil
}

func (m *Model) containsChan(expr ast.Expr) bool {
	for e, _ := range m.Chans {
		if IdenticalExpr(e, expr) {
			return true
		}
	}
	return false
}

func (m *Model) CallExists(name string) bool {

	for _, proc := range m.Proctypes {
		if proc.Name.Name == name {
			return true
		}
	}

	return false
}

func isRecursive(pack string, block *ast.BlockStmt, ast_map map[string]*packages.Package, call_seen []ast.Expr) bool {

	recursive := false
	ast.Inspect(block, func(n ast.Node) bool {
		switch n := n.(type) {
		case *ast.CallExpr:
			if IdenticalExprs(call_seen, n.Fun) {
				recursive = true
			}

		}
		return true
	})

	return recursive
}

// take a for or range loop and return if its const, the bound of the for loop and the name in Go of the bound
func (p *ProjectInfo) lookUpFor(s ast.Stmt, m *Model, pack *packages.Package) (lb promela_ast.Ident, ub promela_ast.Ident) {

	well_formed := false
	switch s := s.(type) {
	case *ast.ForStmt:
		switch cond := s.Cond.(type) {
		case *ast.BinaryExpr:
			if cond.Op == token.GEQ || cond.Op == token.GTR {
				switch inc := s.Post.(type) {
				case *ast.IncDecStmt:
					if inc.Tok == token.DEC {
						ident := m.lookUp(p, cond.Y)
						lb.Name = ident.Print(0)

						// look for upper bound
						switch stmt := s.Init.(type) {
						case *ast.AssignStmt:
							for _, rh := range stmt.Rhs {
								ident := m.lookUp(p, rh)
								ub.Name = ident.Print(0)

								if cond.Op == token.GTR {
									ub.Name += "-1"
								}
								well_formed = true
							}
						}
					}
				}

			} else if cond.Op == token.LSS || cond.Op == token.LEQ {
				switch inc := s.Post.(type) {
				case *ast.IncDecStmt:
					if inc.Tok == token.INC {
						ident := m.lookUp(p, cond.Y)
						ub.Name = ident.Print(0)

						// look for lower bound
						switch stmt := s.Init.(type) {
						case *ast.AssignStmt:
							for _, rh := range stmt.Rhs {
								ident := m.lookUp(p, rh)
								lb.Name = ident.Print(0)

								if cond.Op == token.LSS {
									ub.Name += "-1"
								}
								well_formed = true
							}
						}
					}
				}
			}

		}

	case *ast.RangeStmt:
		lb.Name = "0"
		ident := m.lookUp(p, s.X)
		ub.Name = ident.Print(0)
		well_formed = true

	default:
		panic("promela_translator: A loop should be a range or a for and nothing else. Should not happen")
	}

	if !well_formed {
		lb_decl := promela_ast.DefineStmt{Rhs: &promela_ast.Ident{Name: strconv.Itoa(m.Default_lb)}}
		ub_decl := promela_ast.DefineStmt{Rhs: &promela_ast.Ident{Name: strconv.Itoa(m.Default_ub)}}

		fmt.Println("For loop at : ", p.Fileset.Position(s.Pos()), " is badly formed.")
		// ask user to give lb and ub for the for loop naming the variable according to its line number and unique number
		lb_decl.Name.Name = fmt.Sprintf("lb_for%d_%d", p.Fileset.Position(s.Pos()).Line, len(m.Defines))
		m.Defines = append(m.Defines, lb_decl) // adding lb

		ub_decl.Name.Name = fmt.Sprintf("ub_for%d_%d", p.Fileset.Position(s.Pos()).Line, len(m.Defines))
		m.Defines = append(m.Defines, ub_decl) // adding ub

		lb = lb_decl.Name // returning the fresh vars
		ub = ub_decl.Name

		m.Counters = append(m.Counters, Counter{
			Proj_name: m.Project_name,
			Fun:       m.Fun.Name.String(),
			Name:      "For loop not well formed",
			Line:      p.Fileset.Position(s.Pos()).Line,
			Commit:    m.Commit,
			Filename:  p.Fileset.Position(s.Pos()).Filename,
		})
	}
	return

}

// take a for or range loop and return if its const, the bound of the for loop and the name in Go of the bound
func (m *Model) lookUp(p *ProjectInfo, expr ast.Expr) promela_ast.Ident {

	var ident promela_ast.Expr

	switch expr := expr.(type) {
	case *ast.UnaryExpr:
		if expr.Op == token.ARROW {
			m.Counters = append(m.Counters, Counter{
				Proj_name: m.Project_name,
				Fun:       m.Fun.Name.String(),
				Name:      "Receive as a bound",
				Info:      "Name : " + prettyPrint(expr),
				Line:      m.Fileset.Position(expr.Pos()).Line,
				Commit:    m.Commit,
				Filename:  m.Fileset.Position(expr.Pos()).Filename,
			})
		}
	case *ast.CallExpr:

		// Function as a comm param
		m.Counters = append(m.Counters, Counter{
			Proj_name: m.Project_name,
			Fun:       m.Fun.Name.String(),
			Name:      "Func as a bound",
			Info:      "Name : " + prettyPrint(expr),
			Line:      m.Fileset.Position(expr.Pos()).Line,
			Commit:    m.Commit,
			Filename:  m.Fileset.Position(expr.Pos()).Filename,
		})
	}
	ident = m.TranslateArgs(p, expr)
	return promela_ast.Ident{Name: ident.Print(0)}
}

func IsConst(expr ast.Expr, pack *packages.Package) (found bool, val int) {
	switch expr := expr.(type) {
	case *ast.Ident:
		obj := expr.Obj
		if obj != nil {
			if obj.Kind == ast.Con {
				switch value_spec := obj.Decl.(type) {
				case *ast.ValueSpec:
					if value_spec.Values != nil && len(value_spec.Values) > 0 {
						switch val := value_spec.Values[0].(type) {
						case *ast.BasicLit:
							v, err := strconv.Atoi(val.Value)
							if err == nil {
								return true, v
							}
						case *ast.Ident:
							return IsConst(val, pack)
						}
					}
				}
			}
		}
	case *ast.SelectorExpr:
		obj := expr.Sel.Obj
		if obj != nil {
			if obj.Kind == ast.Con {
				switch value_spec := obj.Decl.(type) {
				case *ast.ValueSpec:
					if value_spec.Values != nil && len(value_spec.Values) > 0 {
						switch val := value_spec.Values[0].(type) {
						case *ast.BasicLit:
							v, err := strconv.Atoi(val.Value)
							if err == nil {
								return true, v
							}
						case *ast.Ident:
							return IsConst(val, pack)
						}
					}
				}
			}
		}
	case *ast.BasicLit:
		if expr.Kind == token.INT {
			val, err := strconv.Atoi(expr.Value)
			if err == nil {
				return true, val
			}
		}
	}

	return false, -1
}

func translateIdent(expr ast.Expr) (expr1 promela_ast.Ident) {
	switch e := expr.(type) {
	case *ast.Ident:
		expr1 = promela_ast.Ident{Name: e.Name}
	case *ast.SelectorExpr:
		expr1 = promela_ast.Ident{Name: translateIdent(e.X).Name + "_" + e.Sel.Name}
	}

	return expr1
}

func containsExpr(exprs []ast.Expr, expr ast.Expr) bool {
	for _, e := range exprs {
		if IdenticalExpr(e, expr) {
			return true
		}
	}

	return false
}
func containsBreak(b *promela_ast.BlockStmt) bool {
	for _, stmt := range b.List {
		switch stmt := stmt.(type) {
		case *promela_ast.Ident:
			if stmt.Name == "break" {
				return true
			}

		}
	}
	return false
}
func (m *Model) containsInline(expr ast.Expr) bool {
	for _, inline := range m.Inlines {
		if inline.Name.Name == getIdent(expr).Name {
			return true
		}
	}
	return false
}
func containsReturn(b *promela_ast.BlockStmt) bool {
	for _, stmt := range b.List {
		switch stmt := stmt.(type) {
		case *promela_ast.GotoStmt:
			if stmt.Label == "stop_process" { // there is a return statement
				return true
			}
		}
	}
	return false
}

func prettyPrint(expr ast.Expr) string {
	switch expr := expr.(type) {
	case *ast.CallExpr:

		name := prettyPrint(expr.Fun) + "("

		for i, arg := range expr.Args {
			name += prettyPrint(arg)

			if i < len(expr.Args)-1 {
				name += "."
			}
		}

		return name + ")"
	default:
		return fmt.Sprint(expr)
	}
}
