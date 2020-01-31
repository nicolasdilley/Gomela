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
	Package         string                   // the name of the package
	Name            string                   // the name of the file that will be generated. (Composed of "pack_functionName_numOfParam")
	Proctypes       []*promela_ast.Proctype  // the processes representing the users and the recursive function of the model
	Fun             *ast.FuncDecl            // the function being modelled
	Chans           map[ast.Expr]*ChanStruct // the promela chan used in the module mapped to their go expr
	Init            *promela_ast.InitDef
	LTL_Properties  []promela_ast.LTL_property
	Defines         []promela_ast.DefineStmt // the define statement used to specify the bounds
	Global_vars     []promela_ast.Stmt       // the global variable used in the ltl properties
	process_counter int                      // to give unique name to Promela processes
	func_counter    int                      // to give unique name to inline func call
	For_counter     *ForCounter              // Used to translate the for loop to break out properly out of them
	Counter         int                      // used to differentiate call expr channels
}

type ProjectInfo struct {
	Project_name string // the name of the project
	Fileset      *token.FileSet
	AstMap       map[string]*packages.Package // the map used to find the type of the channels
	Known_bounds *Bounds
	Chan_closing bool
}

type Chan_info struct {
	Name ast.Expr
	Size promela_ast.Ident
}

// Take a go function and translate it to a Promela module
func (m *Model) GoToPromela(project_name string, f *token.FileSet, ast_map map[string]*packages.Package) {
	project := &ProjectInfo{
		Project_name: project_name,
		Fileset:      f,
		AstMap:       ast_map,
		Known_bounds: &Bounds{List: []*Bound{}},
		Chan_closing: false,
	}
	m.Name = m.Package + "_" + m.Fun.Name.String() + strconv.Itoa(m.Fun.Type.Params.NumFields())
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
		switch s := stmt.(type) {
		case *ast.IfStmt:
			addBlock(block_stmt, m.translateIfStmt(p, s))
		case *ast.AssignStmt:

			for i := len(s.Rhs) - 1; i >= 0; i-- {
				switch call := s.Rhs[i].(type) {
				case *ast.CallExpr:
					switch ident := call.Fun.(type) {
					case *ast.Ident:
						if ident.Name == "make" && len(call.Args) > 0 { // possibly a new chan

							switch call.Args[0].(type) {
							case *ast.ChanType:
								if !m.For_counter.In_for {
									// a new channel is found lets change its name, rename it in function and add to struct
									chan_name := ast.Ident{Name: CHAN_NAME + strconv.Itoa(len(m.Chans))}

									b.List = RenameBlockStmt(b, []ast.Expr{s.Lhs[i]}, &chan_name).List
									channel := &ChanStruct{Name: promela_ast.Ident{Name: chan_name.Name, Ident: p.Fileset.Position(ident.Pos())}, Chan: p.Fileset.Position(s.Pos())}
									chan_def := &promela_ast.DeclStmt{Name: promela_ast.Ident{Name: chan_name.Name}, Types: promela_types.Chandef}
									if len(call.Args) > 1 {
										channel.Buffered = true
										if found, val := IsConst(call.Args[1], p.AstMap[m.Package]); found {
											channel.Size = promela_ast.Ident{Name: strconv.Itoa(val)}
										} else {
											bound := promela_ast.Ident{Name: TranslateIdent(p, call.Args[1]).Name + strconv.Itoa(len(m.Defines))}
											channel.Size = bound
											p.Known_bounds.List = append(p.Known_bounds.List, &Bound{Name: call.Args[1], Var: bound})
											m.Defines = append(m.Defines, promela_ast.DefineStmt{Name: bound, Rhs: &promela_ast.Ident{Name: "5"}})
										}
									} else {
										channel.Size = promela_ast.Ident{Name: "0"}
									}
									alias_chan := &promela_ast.Chandef{Name: promela_ast.Ident{Name: chan_name.Name + "_in"}, Types: []promela_types.Types{promela_types.Int}, Size: channel.Size}
									set_chan := &promela_ast.AssignStmt{Lhs: &promela_ast.Ident{Name: chan_name.Name + ".in"}, Rhs: &promela_ast.Ident{Name: chan_name.Name + "_in"}}
									call_monitor := &promela_ast.RunStmt{X: promela_ast.CallExpr{Fun: promela_ast.Ident{Name: "chanMonitor"}, Args: []promela_ast.Expr{&promela_ast.Ident{Name: chan_name.Name}}}}

									m.Chans[s.Lhs[i]] = channel

									block_stmt.List = append([]promela_ast.Stmt{chan_def, alias_chan}, block_stmt.List...)
									block_stmt.List = append(block_stmt.List, set_chan, call_monitor)
								} else {
									panic("Channel created inside a for loop")
								}
							}
						}
					}
				}
			}
			addBlock(block_stmt, m.translateAssignStmt(p, s))
		case *ast.DeclStmt:

			switch decl := s.Decl.(type) {
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
												channel := &ChanStruct{Name: promela_ast.Ident{Name: chan_name.Name, Ident: p.Fileset.Position(ident.Pos())}, Chan: p.Fileset.Position(s.Pos())}
												chan_def := &promela_ast.DeclStmt{Name: promela_ast.Ident{Name: chan_name.Name}, Types: promela_types.Chandef}

												if len(call.Args) > 1 {
													channel.Buffered = true
													if found, val := IsConst(call.Args[1], p.AstMap[m.Package]); found {
														channel.Size = promela_ast.Ident{Name: strconv.Itoa(val)}
													} else {
														bound := promela_ast.Ident{Name: TranslateIdent(p, call.Args[1]).Name + strconv.Itoa(len(m.Defines))}
														channel.Size = bound
														p.Known_bounds.List = append(p.Known_bounds.List, &Bound{Name: call.Args[1], Var: bound})
														m.Defines = append(m.Defines, promela_ast.DefineStmt{Name: bound, Rhs: &promela_ast.Ident{Name: "5"}})
													}
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
												panic("Channel created inside a for loop")
											}
										}
									}
								}
							}
						}
					}
				}
			}
			addBlock(block_stmt, m.translateDeclStmt(p, s))
		case *ast.GoStmt:
			addBlock(block_stmt, m.TranslateGoStmt(p, s))
		case *ast.ExprStmt:
			addBlock(block_stmt, m.translateExprStmt(p, s))
		case *ast.ForStmt:
			addBlock(block_stmt, m.translateForStmt(p, s))
		case *ast.SendStmt:
			addBlock(block_stmt, m.translateSendStmt(p, s))
		case *ast.RangeStmt:
			addBlock(block_stmt, m.translateRangeStmt(p, s))
		case *ast.ReturnStmt:
			addBlock(block_stmt, m.translateReturnStmt(p, s))
		case *ast.SelectStmt:
			addBlock(block_stmt, m.translateSelectStmt(p, s))
		case *ast.SwitchStmt:
			addBlock(block_stmt, m.translateSwitchStmt(p, s))
		case *ast.LabeledStmt:
			addBlock(block_stmt, m.translateLabeledStmt(p, s))
		case *ast.BranchStmt:
			addBlock(block_stmt, m.translateBranchStmt(p, s))
		case *ast.DeferStmt:
			defer_stmts.Block = p.Fileset.Position(s.Pos())
			addBlock(defer_stmts, m.TranslateExpr(p, s.Call))
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
			stmts := m.TranslateBlockStmt(p, s.Else.(*ast.BlockStmt))
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
	// create the new proctype (has to be new each time because the user might create a new chan)

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
		chans := AnalyseFuncCall(p.Fileset, m.Fun, p.AstMap[m.Package])
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

				prom_call.Fun = promela_ast.Ident{Name: func_name, Ident: p.Fileset.Position(call_expr.Pos())}

				r := &promela_ast.RunStmt{X: prom_call, Run: p.Fileset.Position(s.Pos())}

				stmts.List = append(stmts.List, r)

				if m.For_counter.In_for {
					m.For_counter.With_go = true
				}
			}
		} else {
			fmt.Print("users_translation.go : Func of go statement not found : " + func_name + "\n Called at :")
			fmt.Println(p.Fileset.Position(call_expr.Fun.Pos()))

			for _, arg := range call_expr.Args {
				for _, e := range m.TranslateExpr(p, arg).List {
					switch rcv := e.(type) {
					case *promela_ast.RcvStmt:
						stmts.List = append(stmts.List, rcv)
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
	d := &promela_ast.DoStmt{Do: p.Fileset.Position(s.Pos())}

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

	addBlock(b, m.TranslateExpr(p, s.Cond))

	addBlock(b, m.TranslateBlockStmt(p, &ast.BlockStmt{List: []ast.Stmt{s.Init}}))

	d.Guards = append(
		d.Guards,
		promela_ast.GuardStmt{
			Cond: &promela_ast.Ident{Name: "true"},
			Body: &promela_ast.BlockStmt{List: append(
				[]promela_ast.Stmt{&promela_ast.LabelStmt{Name: label_name}},
				m.TranslateBlockStmt(p, s.Body).List...)}},
	)

	addBlock(b, m.TranslateBlockStmt(p, &ast.BlockStmt{List: []ast.Stmt{s.Post}}))

	for_label := &promela_ast.LabelStmt{Name: label_name + "_exit"}

	if seen, val := p.BoundSeen(s); seen {
		f := &promela_ast.ForStmt{Bound: val.Var, Body: *d.Guards[0].Body}
		b.List = append(b.List, f)
	} else {

		if m.For_counter.With_go {

			// need to change the for loop into a bounded for loop

			var bound promela_ast.Ident
			if f, val, v := p.parseGuard(s, p.AstMap[m.Package]); f {
				bound = val
			} else {
				// for_name := promela_ast.Ident{Name: fmt.Sprintf("for%d%d1", m.For_counter.X, m.For_counter.Y)}
				sbound := TranslateIdent(p, v)

				if sbound.Name == "" {
					sbound.Name = "f" + strconv.Itoa(m.For_counter.X) + strconv.Itoa(m.For_counter.Y)
				}

				bound = sbound

				// b.List = append(b.List, &promela_ast.DeclStmt{Name: for_name, Rhs: &sbound, Types: promela_types.Int})
				p.Known_bounds.List = append(p.Known_bounds.List, &Bound{Name: v, Var: bound})
				m.Defines = append(m.Defines, promela_ast.DefineStmt{Name: sbound, Rhs: &promela_ast.Ident{Name: "10"}})

				// bound.Name = for_name.Name
			}
			b.List = append(b.List, &promela_ast.ForStmt{For: p.Fileset.Position(s.Pos()), Bound: bound, Body: *d.Guards[0].Body})

		} else {

			if s.Cond != nil {
				if f, val, _ := p.parseGuard(s, p.AstMap[m.Package]); f {
					b.List = append(b.List, &promela_ast.ForStmt{For: p.Fileset.Position(s.Pos()), Bound: val, Body: *d.Guards[0].Body})
				} else {

					// adding the option to break of the for loop
					d.Guards = append(d.Guards, promela_ast.GuardStmt{
						Cond: &promela_ast.Ident{Name: "true"},
						Body: &promela_ast.BlockStmt{
							List: []promela_ast.Stmt{&promela_ast.Ident{Name: "break"}}}})
					b.List = append(b.List, d)
				}
			} else {

				b.List = append(b.List, d)
			}
		}
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
		if seen, val := p.BoundSeen(&ast.CallExpr{Fun: &ast.Ident{Name: "len"}, Args: []ast.Expr{s.X}}); seen {

			for_name := promela_ast.Ident{Name: fmt.Sprintf("for%d%d1", m.For_counter.X, m.For_counter.Y)}

			f := &promela_ast.ForStmt{Bound: for_name, Body: *block_stmt}
			b.List = append(b.List, &promela_ast.DeclStmt{Name: for_name, Rhs: &val.Var, Types: promela_types.Int}, f)
		} else {

			if m.For_counter.With_go {
				// need to change the for loop into a bounded for loop

				var bound promela_ast.Ident
				_, val, v := p.parseGuard(s, p.AstMap[m.Package])
				bound = promela_ast.Ident{Name: val.Name + strconv.Itoa(len(m.Defines))}
				for_name := promela_ast.Ident{Name: fmt.Sprintf("for%d%d1", m.For_counter.X, m.For_counter.Y)}
				b.List = append(b.List, &promela_ast.DeclStmt{Name: for_name, Rhs: &bound, Types: promela_types.Int})
				p.Known_bounds.List = append(p.Known_bounds.List, &Bound{Name: v, Var: bound})

				bound = for_name
				m.Defines = append(m.Defines, promela_ast.DefineStmt{Name: bound, Rhs: &promela_ast.Ident{Name: "10"}})

				b.List = append(b.List, &promela_ast.ForStmt{For: p.Fileset.Position(s.Pos()), Bound: bound, Body: *block_stmt})
			} else {

				d.Guards = append(d.Guards, promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: block_stmt})
				b.List = append(b.List, d)
			}
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
		switch clause := stmt.(type) {
		case *ast.CaseClause:

			for _, e := range clause.List {
				addBlock(b, m.TranslateExpr(p, e))
			}
			guard := &promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: m.TranslateBlockStmt(p, &ast.BlockStmt{List: clause.Body})}

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
		switch c := comm.(type) {
		case *ast.CommClause: // can only be a commClause
			guard := promela_ast.GuardStmt{Guard: p.Fileset.Position(comm.Pos()), Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}
			if c.Comm != nil { // check if default select

				block_stmt := m.TranslateBlockStmt(p, &ast.BlockStmt{List: []ast.Stmt{c.Comm}})
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
			guard.Body.List = append(guard.Body.List, m.TranslateBlockStmt(p, &ast.BlockStmt{List: c.Body}).List...)

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
			switch v := spec.(type) {
			case *ast.ValueSpec:
				for _, val := range v.Values {
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
	switch e := expr.(type) {
	case *ast.BinaryExpr:
		addBlock(stmts, m.TranslateExpr(p, e.X))
		addBlock(stmts, m.TranslateExpr(p, e.Y))
	case *ast.CallExpr:
		switch name := e.Fun.(type) {
		case *ast.Ident:
			if name.Name == "close" && len(e.Args) == 1 { // closing a chan
				// chan_struct := m.getChanStruct(e.Args[0])
				send := &promela_ast.SendStmt{Send: p.Fileset.Position(name.Pos())}
				ch := TranslateIdent(p, e.Args[0])
				send.Chan = &promela_ast.SelectorExpr{
					X: &ch, Sel: promela_ast.Ident{Name: "closing"},
					Pos: p.Fileset.Position(e.Args[0].Pos()),
				}
				send.Rhs = &promela_ast.Ident{Name: "true"}
				p.Chan_closing = true
				stmts.List = append(stmts.List, send)

			} else {
				addBlock(stmts, m.TranslateCallExpr(p, e, p.AstMap[m.Package].TypesInfo.ObjectOf(name)))
			}

		case *ast.SelectorExpr:
			// could be a call on a struct
			obj := p.AstMap[m.Package].TypesInfo.ObjectOf(FindIdent(name.X))
			if obj != nil {
				switch obj.Type().(type) {
				case *types.Named: // struct
					obj := p.AstMap[m.Package].TypesInfo.ObjectOf(name.Sel)
					switch s := obj.Type().(type) {
					case *types.Signature:
						if s.Recv() == nil {
							panic("promela_translator.go : A struct that has no receiver ! shouldn't happen")
						} else {

							// call on a struct

							// if found, sel := containSelector(u, name); found {
							// 	found, decl := FindDecl(obj.Pkg().Path(), obj.Id(), len(e.Args),p.AstMap)
							// 	if found {

							// 		aliases := []ast.Expr{&ast.SelectorExpr{X: decl.Recv.List[0].Names[0], Sel: sel.Sel}}

							// 		if v.IsChanUsedInBody(aliases, decl.Body, obj.Pkg().Path()) {
							// 			contains = true

							// 			proc_name := name.X.(*ast.Ident).Name + name.Sel.Name

							// 			if !t.Module.ProcExists(proc_name) {
							// 				proc := &promela_ast.Proctype{Name: promela_ast.Ident{Name: proc_name}, Pos:p.Fileset.Position(e.Pos()), Active: false}

							// 				for i, arg := range e.Args {
							// 					if m.containsChan(p, u, arg) {
							// 						param := findExprFromParams(decl.Type.Params, i)
							// 						chan_info :=p.Module.getChanIdent(u, arg).ChanInfo
							// 						u.Aliases[chan_info] = append(u.Aliases[chan_info], param)
							// 						chan_infos = append(chan_infos, chan_info)
							// 						proc.Params = append(proc.Params, promela_ast.Param{Name: param.Name, Types: promela_types.Chandef})
							// 					}
							// 				}

							// 				// find the chans contained in that struct
							// 				for _, chan_info := range chan_infos {
							// 					for _, channel := range u.Aliases[chan_info] {
							// 						switch s := channel.(type) {
							// 						case *ast.SelectorExpr:
							// 							if found, sel := containSelector(u, s); found {
							// 								u.Aliases[chan_info] = append(u.Aliases[chan_info], &ast.SelectorExpr{X: decl.Recv.List[0].Names[0], Sel: sel.Sel})
							// 							}
							// 						}
							// 					}
							// 				}
							// 				proc.Params = append(proc.Params, promela_ast.Param{Name: "child", Types: promela_types.Chan})

							// 				if f, body := TranslateBlockStmt(p, u, decl.Body); f {
							// 					proc.Body = body
							// 				}
							// 				var args []promela_ast.Expr
							// 				for _, arg := range e.Args {
							// 					if containsChan(p, u, arg) {
							// 						channel := TranslateIdent(p, arg)
							// 						args = append(args, &channel)
							// 					}
							// 				}

							// 				args = append(args, &promela_ast.Ident{Name: "child" + name.Sel.Name}) // may need to add a number

							// 				// add a call to it
							// 				stmts.List = append(stmts.List,
							// 					&promela_ast.RunStmt{X: promela_ast.CallExpr{Fun: promela_ast.Ident{Name: proc_name}, Args: args}},
							// 					&promela_ast.RcvStmt{Chan: &promela_ast.Ident{Name: "child" + name.Sel.Name}, Rhs: &promela_ast.Ident{Name: "0"}},
							// 				)
							// 				old_proc :=p.Module.GetProc(proc_name)

							// 				if old_proc != nil {
							// 					proc.Body.List = append([]promela_ast.Stmt{&promela_ast.Chandef{Name: promela_ast.Ident{Name: "child" + name.Sel.Name}, Size: 0, Types: []promela_types.Types{promela_types.Int}}}, proc.Body.List...)
							// 				} else {
							// 					panic("The proc doesnt exist: Shoud not happen")
							// 				}

							// 				old_proc.Body.List = append(old_proc.Body.List, &promela_ast.SendStmt{Chan: &promela_ast.Ident{Name: "child"}, Rhs: &promela_ast.Ident{Name: "0"}})
							// 				t.Module.Proctypes = append(t.Module.Proctypes, proc)
							// 			} else {
							// 				var args []promela_ast.Expr
							// 				for _, arg := range e.Args {
							// 					if containsChan(p, u, arg) {
							// 						channel := TranslateIdent(p, arg)
							// 						args = append(args, &channel)
							// 					}
							// 				}

							// 				args = append(args, &promela_ast.Ident{Name: "child" + name.Sel.Name})

							// 				// add a call to it
							// 				stmts.List = append(stmts.List,
							// 					&promela_ast.RunStmt{X: promela_ast.CallExpr{Fun: promela_ast.Ident{Name: proc_name}, Args: args}},
							// 					&promela_ast.RcvStmt{Chan: &promela_ast.Ident{Name: "child" + name.Sel.Name}, Rhs: &promela_ast.Ident{Name: "0"}},
							// 				)

							// 				// proc :=p.Module.GetProc(proc_name)

							// 				// if proc != nil {
							// 				// 	proc.Body.List = append([]promela_ast.Stmt{&promela_ast.Chandef{Name: promela_ast.Ident{Name: "child" + name.Sel.Name}, Size: 0, Types: []promela_types.Types{promela_types.Int}}}, proc.Body.List...)
							// 				// } else {
							// 				// 	panic("The proc doesnt exist: Shoud not happen")
							// 				// }
							// 			}
							// 		}
							// 	} else {
							// 		fmt.Print("users_translation.go : Func call not found : " + u.Package_name + "." + name.Sel.Name + "\n Called at :")
							// 		fmt.Println(t.Fileset.Position(name.Pos()))
							// 	}

							// }
						}

					}
				default:
					obj := p.AstMap[m.Package].TypesInfo.ObjectOf(name.Sel)
					if obj != nil {
						switch obj.Type().(type) {
						case *types.Signature:
							contains := false
							for _, arg := range e.Args {
								switch u := arg.(type) {
								case *ast.UnaryExpr:
									if u.Op == token.ARROW {
										contains = true

									}
								}
							}

							if contains {
								addBlock(stmts, m.TranslateCallExpr(p, e, obj))
							}
						}
					}
				}
			}
		case *ast.FuncLit:
			new_block := name.Body
			for i, field := range name.Type.Params.List {
				for _, name := range field.Names {
					new_block = RenameBlockStmt(new_block, []ast.Expr{name}, e.Args[i])
				}
			}

			return m.TranslateBlockStmt(p, new_block)

		}

	case *ast.UnaryExpr:
		switch e.Op {
		case token.ARROW:

			channel := m.getChanStruct(e.X)
			if channel != nil {
				chan_name := m.TranslateArgs(p, e.X)

				stmts.List = append(stmts.List, &promela_ast.RcvStmt{Chan: &promela_ast.SelectorExpr{X: chan_name, Sel: promela_ast.Ident{Name: "in"}}, Rcv: p.Fileset.Position(expr.Pos()), Rhs: &promela_ast.Ident{Name: "0"}})
			}
		}
	// case *ast.Ident:
	// 	switch p.AstMap[m.Package].TypesInfo.TypeOf(e).(type) {
	// 	case *types.Chan:
	// 		stmts.List = append(stmts.List, &promela_ast.Ident{Name: e.Name, Ident: p.Fileset.Position(e.Pos())})
	// 	}
	// case *ast.SelectorExpr:
	// 	switch p.AstMap[m.Package].TypesInfo.TypeOf(e.Sel).(type) {
	// 	case *types.Chan:
	// 		stmts.List = append(stmts.List, &promela_ast.SelectorExpr{
	// 			X:   m.TranslateExpr(p, e.X).List[0],
	// 			Sel: promela_ast.Ident{Name: e.Sel.Name, Ident: p.Fileset.Position(e.Pos())},
	// 			Pos: p.Fileset.Position(e.Pos())})
	// 	}

	case *ast.ParenExpr:
		addBlock(stmts, m.TranslateExpr(p, e.X))
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

					// change the aliases
					for i, arg := range call_expr.Args {
						if m.containsChan(arg) {
							param := findExprFromParams(decl.Type.Params, i)
							proc.Params = append(proc.Params, promela_ast.Param{Name: param.Name, Types: promela_types.Chandef})
						}
					}

					proc.Params = append(proc.Params, promela_ast.Param{Name: "child", Types: promela_types.Chan})

					prev_decl := *m.Fun
					m.Fun = decl
					proc.Body.List = m.TranslateBlockStmt(p, decl.Body).List
					proc.Body.List = append(proc.Body.List, &promela_ast.SendStmt{Chan: &promela_ast.Ident{Name: "child"}, Rhs: &promela_ast.Ident{Name: "0"}})
					m.Proctypes = append(m.Proctypes, proc)
					m.Fun = &prev_decl

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
					// }
				} else {
					// fmt.Print("users_translation.go : Func call not found : " + func_name + "\n Called at :")
					// fmt.Println(p.Fileset.Position(call_expr.Fun.Pos()))

					for _, arg := range call_expr.Args {
						for _, e := range m.TranslateExpr(p, arg).List {
							switch rcv := e.(type) {
							case *promela_ast.RcvStmt:
								stmts.List = append(stmts.List, rcv)
							}
						}
					}
				}
			}

		} else {
			if m.isProc(func_name) {

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
	switch e := expr.(type) {
	case *ast.Ident:

		e1 = &promela_ast.Ident{Name: e.Name, Ident: p.Fileset.Position(e.Pos())}

	case *ast.SelectorExpr:

		e1 = &promela_ast.SelectorExpr{
			X:   m.TranslateExpr(p, e.X).List[0],
			Sel: promela_ast.Ident{Name: e.Sel.Name, Ident: p.Fileset.Position(e.Pos())},
			Pos: p.Fileset.Position(e.Pos())}

	}
	return e1
}

func (m *Model) getProc(fun string) *promela_ast.Proctype {
	for _, proc := range m.Proctypes {
		if proc.Name.Name == fun {
			return proc
		}
	}
	panic("Promela_translator.go: Couldnt find proc which is wrong")
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
					switch fun_decl := decl.(type) {
					case *ast.FuncDecl:

						if func_name == fun_decl.Name.Name {
							if fun_decl.Type.Params.NumFields() == param_num {
								return true, fun_decl
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

func (m *Model) isProc(fun string) bool {
	for _, proc := range m.Proctypes {
		if proc.Name.Name == fun {
			return true
		}
	}

	return false
}

func isRecursive(pack string, block *ast.BlockStmt, ast_map map[string]*packages.Package, call_seen []ast.Expr) bool {

	recursive := false
	ast.Inspect(block, func(n ast.Node) bool {
		switch s := n.(type) {
		case *ast.CallExpr:
			if IdenticalExprs(call_seen, s.Fun) {
				recursive = true
			}

		}
		return true
	})

	return recursive
}

// take a for or range loop and return if its const, the bound of the for loop and the name in Go of the bound
func (p *ProjectInfo) parseGuard(s ast.Stmt, pack *packages.Package) (found bool, val promela_ast.Ident, v ast.Expr) {

	switch f := s.(type) {
	case *ast.ForStmt:
		switch cond := f.Cond.(type) {
		case *ast.BinaryExpr:
			if cond.Op == token.GEQ || cond.Op == token.GTR {
				switch inc := f.Post.(type) {
				case *ast.IncDecStmt:
					if inc.Tok == token.DEC {
						if found, v := p.ContainsBound(cond.X); !found {
							if f, c := IsConst(cond.X, pack); f {
								return true, promela_ast.Ident{Name: strconv.Itoa(c)}, cond.X
							} else {
								return false, TranslateIdent(p, cond.X), cond.X
							}
						} else {
							return true, *v, cond.X
						}
					}
				}

			} else if cond.Op == token.LSS || cond.Op == token.LEQ {
				switch inc := f.Post.(type) {
				case *ast.IncDecStmt:
					if inc.Tok == token.INC {
						if found, v := p.ContainsBound(cond.Y); !found {
							if f, c := IsConst(cond.Y, pack); f {
								return true, promela_ast.Ident{Name: strconv.Itoa(c)}, cond.Y
							} else {
								return false, TranslateIdent(p, cond.X), cond.Y
							}
						} else {
							return true, *v, cond.Y
						}
					}
				}
			}

		}
		return false, TranslateIdent(p, f.Cond), f.Cond
	case *ast.RangeStmt:
		return false, TranslateIdent(p, f.X), f.X
	}

	panic("promela_translator: A loop should be a range or a for and nothing else. Should not happen")
	return false, promela_ast.Ident{}, &ast.Ident{}
}

func IsConst(expr ast.Expr, pack *packages.Package) (found bool, val int) {
	switch ident := expr.(type) {
	case *ast.Ident:
		obj := ident.Obj
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
		obj := ident.Sel.Obj
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
		if ident.Kind == token.INT {
			val, err := strconv.Atoi(ident.Value)
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
		switch ident := stmt.(type) {
		case *promela_ast.Ident:
			if ident.Name == "break" {
				return true
			}

		}
	}
	return false
}
func containsReturn(b *promela_ast.BlockStmt) bool {
	for _, stmt := range b.List {
		switch ident := stmt.(type) {
		case *promela_ast.GotoStmt:
			if ident.Label == "stop_process" { // there is a return statement
				return true
			}
		}
	}
	return false
}

func (p *ProjectInfo) ContainsBound(expr ast.Expr) (bool, *promela_ast.Ident) {
	for _, bound := range p.Known_bounds.List {
		if IdenticalExpr(bound.Name, expr) {
			return true, &bound.Var
		}
	}

	return false, nil
}
