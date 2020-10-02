package promela

import (
	"errors"
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
	CHAN_NAME       = "_ch"
	DEFAULT_BOUND   = "5"
	CHAN_BOUND      = 0
	ADD_BOUND       = 1
	LOWER_FOR_BOUND = 2
	UPPER_FOR_BOUND = 3
)

type Model struct {
	Result_fodler   string // the name of the folder where the model need to ne printed
	Project_name    string // the full name of  project (eg. "nicolasdilley/Gomela")
	Package         string // the name of the package
	Model           string // the name of the model
	Name            string // the name of the file that will be generated. (Composed of "pack_functionName_numOfParam")
	Commit          string // the commit of the project
	RecFuncs        []RecFunc
	SpawningFuncs   []*SpawningFunc
	Fileset         *token.FileSet
	Proctypes       []*promela_ast.Proctype       // the processes representing the functions of the model
	Inlines         []*promela_ast.Inline         // the inlines function that represent the commpar args that are function calls
	Fun             *ast.FuncDecl                 // the function being modelled
	Chans           map[ast.Expr]*ChanStruct      // the promela chan used in the module mapped to their go expr
	WaitGroups      map[ast.Expr]*WaitGroupStruct // the promela chan used in the module mapped to their go expr
	Init            *promela_ast.InitDef          // The proctype consisting of the "main" function of the source program
	Global_vars     []promela_ast.Stmt            // the global variable used in the ltl properties
	Defines         []promela_ast.DefineStmt      // the channel bounds
	CommPars        []*CommPar                    // the communications paramer
	Features        []Feature                     // The features for the survey
	process_counter int                           // to give unique name to Promela processes
	func_counter    int                           // to give unique name to inline func call
	For_counter     *ForCounter                   // Used to translate the for loop to break out properly out of them
	Counter         int                           // used to differentiate call expr channels
	Default_lb      int
	Default_ub      int
	AstMap          map[string]*packages.Package // the map used to find the type of the channels
	Chan_closing    bool
}

// Used to represent a function for recursive calls
type RecFunc struct {
	Pkg  string
	Name string
}

// represent a function and states if it spawns or not
type SpawningFunc struct {
	Rec_func    RecFunc
	is_spawning bool
}

type Bound struct {
	Name ast.Expr
	Var  promela_ast.Ident
	Val  int
}

type ParseError struct {
	err error
}

// Take a go function and translate it to a Promela module
func (m *Model) GoToPromela() {
	m.Name = m.Package + "_" + m.Fun.Name.String()
	m.CommPars = m.AnalyseCommParam(m.Package, m.Fun, m.AstMap, true)
	//. Create a global var for each
	m.Init = &promela_ast.InitDef{Def: m.Fileset.Position(m.Fun.Pos()), Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}
	for _, commPar := range m.CommPars {
		if commPar.Candidate {
			m.Init.Body.List = append(m.Init.Body.List, &promela_ast.DeclStmt{Name: promela_ast.Ident{Name: commPar.Name.Name}, Rhs: &promela_ast.Ident{Name: DEFAULT_BOUND}, Types: promela_types.Int})
		}
	}
	m.Init.Body.List = append(m.Init.Body.List,
		&promela_ast.DeclStmt{Name: promela_ast.Ident{Name: "i"}, Types: promela_types.Int},
		&promela_ast.DeclStmt{Name: promela_ast.Ident{Name: "state"}, Types: promela_types.Bool, Rhs: &promela_ast.Ident{Name: "false"}})
	s1, err := m.TranslateBlockStmt(m.Fun.Body)

	m.Init.Body.List = append(m.Init.Body.List,
		s1.List...)

	if len(m.Chans) > 0 || len(m.WaitGroups) > 0 {

		PrintFeatures(m, m.Features)

		// generate the model only if it contains only supported features
		if err == nil {
			Print(m) // print the model
		} else {
			fmt.Println("Could not parse model ", m.Name, " :")
			fmt.Println(err)
		}
	}

}

// take a go block stmt and returns its promela counterpart
func (m *Model) TranslateBlockStmt(b *ast.BlockStmt) (block_stmt *promela_ast.BlockStmt, err *ParseError) {

	block_stmt = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	defer_stmts := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	if b != nil {
		block_stmt.Block = m.Fileset.Position(b.Pos())
		for _, stmt := range b.List {
			if stmt != nil {
				switch stmt := stmt.(type) {
				case *ast.DeferStmt:
					s1, err1 := m.TranslateExpr(stmt.Call)

					if err1 != nil {
						err = err1
					}
					defer_stmts.Block = m.Fileset.Position(stmt.Pos())
					addBlock(defer_stmts, s1)
				default:
					var s1 *promela_ast.BlockStmt = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
					var err1 *ParseError
					switch stmt := stmt.(type) {
					case *ast.AssignStmt:
						// look if the struct is a struct that contains the "automatic" declaration of a new WaitGroup
						for _, l := range stmt.Lhs {
							s := m.AstMap[m.Package].TypesInfo.TypeOf(l)
							switch types := s.(type) {
							case *types.Pointer:
								s = types.Elem()
							}
							switch s.(type) {
							case *types.Named:
								switch s := s.Underlying().(type) {
								case *types.Struct:
									for i := 0; i < s.NumFields(); i++ {
										switch field := s.Field(i).Type().(type) {
										case *types.Named:
											if field.Obj() != nil {
												if field.Obj().Pkg() != nil {
													if field.Obj().Pkg().Name() == "sync" {
														if field.Obj().Name() == "WaitGroup" {
															if !m.For_counter.In_for {
																wg_name := &ast.Ident{Name: translateIdent(l).Name + "_" + s.Field(i).Name(), NamePos: l.Pos()}
																// we have found a waitgroup that is a field

																prom_wg_name := promela_ast.Ident{Name: translateIdent(l).Name + "_" + s.Field(i).Name(), Ident: m.Fileset.Position(l.Pos())}

																m.WaitGroups[wg_name] = &WaitGroupStruct{
																	Name:    prom_wg_name,
																	Wait:    m.Fileset.Position(l.Pos()),
																	Counter: 0,
																}
																block_stmt.List = append(block_stmt.List,
																	&promela_ast.DeclStmt{Name: prom_wg_name, Types: promela_types.Wgdef},
																	&promela_ast.RunStmt{X: promela_ast.CallExpr{Fun: promela_ast.Ident{Name: "wgMonitor"}, Args: []promela_ast.Expr{&prom_wg_name}}})

															} else {
																m.AddFeature(Feature{
																	Proj_name: m.Project_name,
																	Fun:       m.Fun.Name.String(),
																	Name:      "WaitGroup in for",
																	Mandatory: "false",
																	Line:      m.Fileset.Position(stmt.Pos()).Line,
																	Commit:    m.Commit,
																	Filename:  m.Fileset.Position(stmt.Pos()).Filename,
																})

																err = &ParseError{err: errors.New("Waitgroup created in a for loop at pos :" + m.Fileset.Position(stmt.Pos()).String())}
															}
														}
													}
												}

											}
										}
									}
								}
							}
						}
						for i := len(stmt.Rhs) - 1; i >= 0; i-- {
							call := stmt.Rhs[i]
							switch unary := call.(type) {
							case *ast.UnaryExpr:
								call = unary.X
							}
							switch call := call.(type) {
							case *ast.CallExpr:
								switch ident := call.Fun.(type) {
								case *ast.Ident:
									if ident.Name == "make" && len(call.Args) > 0 { // possibly a new chan
										switch call.Args[0].(type) {
										case *ast.ChanType:
											if !m.For_counter.In_for {
												// a new channel is found lets change its name, rename it in function and add to struct

												// b.List = RenameBlockStmt(b, []ast.Expr{stmt.Lhs[i]}, &chan_name).List
												ch, err1 := m.translateChan(stmt.Lhs[i], call.Args)

												if err1 != nil {
													err = err1
												}
												addBlock(block_stmt, ch)
											} else {
												m.AddFeature(Feature{
													Proj_name: m.Project_name,
													Fun:       m.Fun.Name.String(),
													Name:      "Chan in for",
													Mandatory: "false",
													Line:      m.Fileset.Position(ident.Pos()).Line,
													Commit:    m.Commit,
													Filename:  m.Fileset.Position(ident.Pos()).Filename,
												})
												err = &ParseError{err: errors.New("Channel created in a for loop at pos :" + m.Fileset.Position(stmt.Pos()).String())}
											}

										}
									}
								}

							case *ast.CompositeLit:
								for _, elt := range call.Elts {
									switch elt := elt.(type) {
									case *ast.KeyValueExpr:
										switch call := elt.Value.(type) {
										case *ast.CallExpr:
											switch ident := call.Fun.(type) {
											case *ast.Ident:
												if ident.Name == "make" && len(call.Args) > 0 { // possibly a new chan
													switch call.Args[0].(type) {
													case *ast.ChanType:
														if !m.For_counter.In_for {
															// a new channel is found lets change its name, rename it in function and add to struct
															sel := &ast.SelectorExpr{X: stmt.Lhs[i], Sel: &ast.Ident{Name: translateIdent(elt.Key).Name}}
															ch, err1 := m.translateChan(sel, call.Args)

															if err1 != nil {
																err = err1
															}
															addBlock(block_stmt, ch)

														} else {
															m.AddFeature(Feature{
																Proj_name: m.Project_name,
																Fun:       m.Fun.Name.String(),
																Name:      "Chan in for",
																Mandatory: "false",
																Line:      m.Fileset.Position(ident.Pos()).Line,
																Commit:    m.Commit,
																Filename:  m.Fileset.Position(ident.Pos()).Filename,
															})
															err = &ParseError{err: errors.New("Channel created in a for loop at pos :" + m.Fileset.Position(stmt.Pos()).String())}

														}

													}
												}
											}

										}
									}

								}

								switch sel := call.Type.(type) {
								case *ast.SelectorExpr:
									if sel.Sel.Name == "WaitGroup" {
										switch sel := sel.X.(type) {
										case *ast.Ident:
											if sel.Name == "sync" {
												// we have a waitgroup
												for _, name := range stmt.Lhs {
													if !m.For_counter.In_for {
														prom_wg_name := promela_ast.Ident{Name: translateIdent(name).Name, Ident: m.Fileset.Position(name.Pos())}
														m.WaitGroups[name] = &WaitGroupStruct{
															Name:    prom_wg_name,
															Wait:    m.Fileset.Position(stmt.Pos()),
															Counter: 0,
														}

														block_stmt.List = append(block_stmt.List,
															&promela_ast.DeclStmt{Name: prom_wg_name, Types: promela_types.Wgdef},
															&promela_ast.RunStmt{X: promela_ast.CallExpr{Fun: promela_ast.Ident{Name: "wgMonitor"}, Args: []promela_ast.Expr{&prom_wg_name}}})
													} else {
														m.AddFeature(Feature{
															Proj_name: m.Project_name,
															Fun:       m.Fun.Name.String(),
															Name:      "WaitGroup in for",
															Mandatory: "false",
															Line:      m.Fileset.Position(stmt.Pos()).Line,
															Commit:    m.Commit,
															Filename:  m.Fileset.Position(stmt.Pos()).Filename,
														})
														err = &ParseError{err: errors.New("Waitgroup created in a for loop at pos :" + m.Fileset.Position(stmt.Pos()).String())}
													}
												}
											}
										}
									}
								}
							}
						}
						s1, err1 = m.translateAssignStmt(stmt)
					case *ast.DeclStmt:

						switch decl := stmt.Decl.(type) {
						case *ast.GenDecl:
							for _, spec := range decl.Specs {
								switch spec := spec.(type) {
								case *ast.ValueSpec:
									for i, rhs := range spec.Values {
										switch call := rhs.(type) {
										case *ast.CallExpr:
											switch ident := call.Fun.(type) {
											case *ast.Ident:
												if ident.Name == "make" && len(call.Args) > 0 { // possibly a new chan
													switch call.Args[0].(type) {
													case *ast.ChanType:

														if !m.For_counter.In_for {

															ch, err1 := m.translateChan(spec.Names[i], call.Args)
															if err1 != nil {
																err = err1
															}
															addBlock(block_stmt, ch)
														} else {
															err = &ParseError{err: errors.New("Channel created in a for loop at pos :" + m.Fileset.Position(stmt.Pos()).String())}

															m.AddFeature(Feature{
																Proj_name: m.Project_name,
																Fun:       m.Fun.Name.String(),
																Name:      "Chan in for",
																Mandatory: "false",
																Line:      m.Fileset.Position(ident.Pos()).Line,
																Commit:    m.Commit,
																Filename:  m.Fileset.Position(ident.Pos()).Filename,
															})
														}
													}
												}
											}
										}
									}

									// check if its the declaration of a WG
									switch sel := spec.Type.(type) {
									case *ast.SelectorExpr:
										if sel.Sel.Name == "WaitGroup" {
											switch sel := sel.X.(type) {
											case *ast.Ident:
												if sel.Name == "sync" {
													// we have a waitgroup

													if !m.For_counter.In_for {
														for _, name := range spec.Names {
															prom_wg_name := promela_ast.Ident{Name: name.Name, Ident: m.Fileset.Position(name.Pos())}
															m.WaitGroups[name] = &WaitGroupStruct{
																Name:    prom_wg_name,
																Wait:    m.Fileset.Position(spec.Pos()),
																Counter: 0,
															}

															block_stmt.List = append(block_stmt.List,
																&promela_ast.DeclStmt{Name: prom_wg_name, Types: promela_types.Wgdef},
																&promela_ast.RunStmt{X: promela_ast.CallExpr{Fun: promela_ast.Ident{Name: "wgMonitor"}, Args: []promela_ast.Expr{&prom_wg_name}}})

														}
													} else {
														m.AddFeature(Feature{
															Proj_name: m.Project_name,
															Fun:       m.Fun.Name.String(),
															Name:      "WaitGroup in for",
															Mandatory: "false",
															Line:      m.Fileset.Position(sel.Pos()).Line,
															Commit:    m.Commit,
															Filename:  m.Fileset.Position(sel.Pos()).Filename,
														})
														err = &ParseError{err: errors.New("Waitgroup created in a for loop at pos :" + m.Fileset.Position(stmt.Pos()).String())}
													}
												}
											}
										}
									}
								}
							}
						}
						s1, err1 = m.translateDeclStmt(stmt)
					case *ast.GoStmt:
						s1, err1 = m.TranslateGoStmt(stmt)
					case *ast.ExprStmt:
						s1, err1 = m.translateExprStmt(stmt)
					case *ast.ForStmt:
						s1, err1 = m.translateForStmt(stmt)
					case *ast.SendStmt:
						s1, err1 = m.translateSendStmt(stmt)
					case *ast.RangeStmt:
						s1, err1 = m.translateRangeStmt(stmt)
					case *ast.ReturnStmt:
						s1, err1 = m.translateReturnStmt(stmt)
					case *ast.SelectStmt:
						s1, err1 = m.translateSelectStmt(stmt)
					case *ast.SwitchStmt:
						s1, err1 = m.translateSwitchStmt(stmt)
					case *ast.LabeledStmt:
						s1, err1 = m.translateLabeledStmt(stmt)
					case *ast.BranchStmt:
						s1, err1 = m.translateBranchStmt(stmt)
					case *ast.IfStmt:
						s1, err1 = m.translateIfStmt(stmt)
					}

					if err1 != nil {
						err = err1
					} else {
						addBlock(block_stmt, s1)
					}
				}
			}
		}
	}

	addBlock(block_stmt, defer_stmts)
	return block_stmt, err
}
func (m *Model) translateChan(go_chan_name ast.Expr, args []ast.Expr) (b *promela_ast.BlockStmt, err *ParseError) {
	prom_chan_name := translateIdent(go_chan_name)
	channel := &ChanStruct{Name: prom_chan_name, Chan: m.Fileset.Position(go_chan_name.Pos())}
	chan_def := &promela_ast.DeclStmt{Name: promela_ast.Ident{Name: prom_chan_name.Name}, Types: promela_types.Chandef}
	block_stmt := &promela_ast.BlockStmt{List: []promela_ast.Stmt{chan_def}}
	if_stmt := &promela_ast.IfStmt{Guards: []promela_ast.GuardStmt{}}
	sync_monitor := &promela_ast.RunStmt{X: promela_ast.CallExpr{Fun: promela_ast.Ident{Name: "sync_monitor"}, Args: []promela_ast.Expr{&prom_chan_name}}}
	if len(args) > 1 { // check if the channel is buffered or not
		channel.Buffered = true
		var size promela_ast.Ident
		size, err = m.lookUp(args[1], CHAN_BOUND, false)

		async_guard := promela_ast.GuardStmt{
			Cond: &promela_ast.Ident{Name: size.Name + " > 0"},
			Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{
				&promela_ast.AssignStmt{Lhs: &promela_ast.SelectorExpr{X: &prom_chan_name, Sel: promela_ast.Ident{Name: "size"}}, Rhs: &size},
				&promela_ast.RunStmt{X: promela_ast.CallExpr{Fun: promela_ast.Ident{Name: "emptyChan"}, Args: []promela_ast.Expr{&prom_chan_name}}},
			}}}
		sync_guard := promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "else"},
			Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{sync_monitor}}}

		if_stmt.Guards = append(if_stmt.Guards, async_guard, sync_guard)
		block_stmt.List = append(block_stmt.List, if_stmt)
	} else {
		block_stmt.List = append(block_stmt.List, sync_monitor)
	}
	m.Chans[go_chan_name] = channel

	return block_stmt, err
}
func (m *Model) translateIfStmt(s *ast.IfStmt) (b *promela_ast.BlockStmt, err *ParseError) {
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	i := &promela_ast.IfStmt{If: m.Fileset.Position(s.Pos())}

	stmts, err1 := m.TranslateBlockStmt(&ast.BlockStmt{List: []ast.Stmt{s.Init}})
	if err1 != nil {
		err = err1
	}
	addBlock(b, stmts)

	body, err1 := m.TranslateBlockStmt(s.Body)
	if err1 != nil {
		err = err1
	}
	contains := false
	if len(body.List) != 0 {
		contains = true
		i.Guards = append(i.Guards, promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: body})
	}

	if s.Else != nil {
		stmts := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
		switch els := s.Else.(type) {
		case *ast.BlockStmt:
			s1, err1 := m.TranslateBlockStmt(els)
			if err1 != nil {
				err = err1
			}
			stmts = s1
			if len(stmts.List) != 0 {
				contains = true
				i.Guards = append(i.Guards, promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: stmts})
			}
		default:
			s1, err1 := m.TranslateBlockStmt(&ast.BlockStmt{List: []ast.Stmt{s.Else}})
			if err1 != nil {
				err = err1
			}
			stmts = s1
		}
		if len(stmts.List) != 0 {
			contains = true
			i.Guards = append(i.Guards, promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: stmts})
		}
	} else if contains {
		i.Guards = append(i.Guards, promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: &promela_ast.BlockStmt{}})
	}

	if contains {
		b.List = append(b.List, i)
	}
	return b, err
}

func (m *Model) TranslateGoStmt(s *ast.GoStmt) (b *promela_ast.BlockStmt, err *ParseError) {
	// Find the declaration of the call
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}

	var fun string       // The name of the function we are translating
	var func_name string // The corresponding promela function name consisting of package + fun + num of param + len(proctypes)
	var pack_name string = m.Package
	call_expr := s.Call

	prom_call := promela_ast.CallExpr{Call: m.Fileset.Position(call_expr.Pos())}

	switch name := call_expr.Fun.(type) {
	case *ast.FuncLit: // in the case we have an anonymous func call
		func_name = "Anonymous" + strconv.Itoa(len(m.Proctypes))

		proc := &promela_ast.Proctype{
			Name:   promela_ast.Ident{Name: func_name, Ident: m.Fileset.Position(s.Pos())},
			Pos:    m.Fileset.Position(call_expr.Pos()),
			Active: false,
			Body:   &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}
		prom_call.Fun = promela_ast.Ident{Name: func_name, Ident: m.Fileset.Position(s.Pos())}
		for x, field := range name.Type.Params.List {
			for y, n := range field.Names {
				switch field := field.Type.(type) {
				case *ast.ChanType:
					proc.Params = append(proc.Params, promela_ast.Param{Name: n.Name, Types: promela_types.Chandef})
					chan_name := TranslateIdent(call_expr.Args[x+y], m.Fileset)
					prom_call.Args = append(prom_call.Args, &chan_name)
				case *ast.StarExpr:
					switch sel := field.X.(type) {
					case *ast.SelectorExpr:
						switch ident := sel.X.(type) {
						case *ast.Ident:
							if ident.Name == "sync" {
								if sel.Sel.Name == "WaitGroup" {
									proc.Params = append(proc.Params, promela_ast.Param{Name: n.Name, Types: promela_types.Wgdef})
									wg_name := TranslateIdent(call_expr.Args[x+y], m.Fileset)
									prom_call.Args = append(prom_call.Args, &wg_name)
								}
							}
						}
					}
				}

			}
		}

		chans, wgs := AnalyseFuncCall(m.Fileset, m.Fun, m.AstMap[m.Package]) // Returns the channels that are declared before the call
		for _, ch := range chans {
			if !containsExpr(s.Call.Args, ch) {
				chan_name := TranslateIdent(ch, m.Fileset)
				proc.Params = append(proc.Params, promela_ast.Param{Name: chan_name.Name, Types: promela_types.Chandef})
				prom_call.Args = append(prom_call.Args, &chan_name)
			}
		}

		for _, wg := range wgs {

			var exprs []ast.Expr

			for _, arg := range s.Call.Args {
				switch arg := arg.(type) {
				case *ast.UnaryExpr:
					exprs = append(exprs, arg.X)
				default:
					exprs = append(exprs, arg)
				}
			}
			if !containsExpr(exprs, wg) {
				proc.Params = append(proc.Params, promela_ast.Param{Name: TranslateIdent(wg, m.Fileset).Name, Types: promela_types.Wgdef})

				arg, err1 := m.TranslateArgs(wg)

				if err1 != nil {
					err = err1
				}
				prom_call.Args = append(prom_call.Args, arg)
			}
		}

		r := &promela_ast.RunStmt{X: prom_call, Run: m.Fileset.Position(s.Pos())}
		b.List = append(b.List, r)

		// Update the WG and Chan available in the anonymous call

		new_chans := make(map[ast.Expr]*ChanStruct)
		new_wgs := make(map[ast.Expr]*WaitGroupStruct)
		for _, param := range proc.Params {
			name := &ast.Ident{Name: param.Name}

			switch param.Types {
			case promela_types.Chandef:
				new_chans[name] = &ChanStruct{Name: promela_ast.Ident{Name: name.Name}}
			default:
				new_wgs[name] = &WaitGroupStruct{Name: promela_ast.Ident{Name: name.Name}}
			}
		}

		old_chans := m.Chans
		old_wgs := m.WaitGroups

		m.Chans = new_chans
		m.WaitGroups = new_wgs
		stmt, err1 := m.TranslateBlockStmt(name.Body)
		if err1 != nil {
			err = err1
		}
		proc.Body = stmt
		m.Chans = old_chans
		m.WaitGroups = old_wgs
		m.Proctypes = append(m.Proctypes, proc) // adding the new proc type to the list of proctype

	default:
		// Find name of function
		switch name := call_expr.Fun.(type) {
		case *ast.Ident:
			func_name = filepath.Base(pack_name) + name.Name
			fun = name.Name
		case *ast.SelectorExpr:

			sel := m.AstMap[m.Package].TypesInfo.Selections[name]

			pack_name = TranslateIdent(name.X, m.Fileset).Name
			if sel != nil {
				if sel.Obj() != nil {
					if sel.Obj().Pkg() != nil {
						pack_name = sel.Obj().Pkg().Name()
					}
				}
			}
			func_name = TranslateIdent(name.X, m.Fileset).Name + name.Sel.Name
			fun = name.Sel.Name
		}

		if found, decl := FindDecl(pack_name, fun, len(call_expr.Args), m.AstMap); found {

			hasChan := false
			known := false
			func_name = "go_" + func_name

			commPars := m.AnalyseCommParam(pack_name, decl, m.AstMap, false) // recover the commPar

			prev_comm := m.CommPars
			m.CommPars = commPars
			prev_decl := m.Fun
			m.Fun = decl
			prev_wg := m.WaitGroups
			prev_chans := m.Chans
			prev_pack := m.Package
			new_chans := make(map[ast.Expr]*ChanStruct)
			new_wgs := make(map[ast.Expr]*WaitGroupStruct)

			if !m.CallExists(func_name) {
				proc := &promela_ast.Proctype{Name: promela_ast.Ident{Name: func_name}, Pos: m.Fileset.Position(call_expr.Pos()), Active: false, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}
				proc.Params = []promela_ast.Param{}

				counter := 0
				for _, field := range decl.Type.Params.List {
					for _, name := range field.Names {
						switch sel := field.Type.(type) {
						case *ast.ChanType:
							hasChan = true

							if m.containsChan(call_expr.Args[counter]) {
								proc.Params = append(proc.Params, promela_ast.Param{Name: name.Name, Types: promela_types.Chandef})
								new_chans[name] = &ChanStruct{Name: promela_ast.Ident{Name: name.Name}, Chan: m.Fileset.Position(name.Pos())}

								arg, err1 := m.TranslateArgs(call_expr.Args[counter])
								if err1 != nil {
									err = err1
								}
								prom_call.Args = append(prom_call.Args, arg)
								known = true
							} else {
								known = false
							}
						case *ast.StarExpr:
							switch sel := sel.X.(type) {
							case *ast.SelectorExpr:
								switch ident := sel.X.(type) {
								case *ast.Ident:
									if ident.Name == "sync" {
										if sel.Sel.Name == "WaitGroup" {
											hasChan = true
											if m.containsWaitgroup(call_expr.Args[counter]) {
												wg := &WaitGroupStruct{Name: promela_ast.Ident{Name: name.Name, Ident: m.Fileset.Position(name.Pos())}, Wait: m.Fileset.Position(name.Pos())}
												proc.Params = append(proc.Params, promela_ast.Param{Name: name.Name, Types: promela_types.Wgdef})
												new_wgs[name] = wg

												arg, err1 := m.TranslateArgs(call_expr.Args[counter])
												if err1 != nil {
													err = err1
												}
												prom_call.Args = append(prom_call.Args, arg)
												known = true
											} else {
												known = false
											}
										}
									}
								}
							}
						case *ast.SelectorExpr:
							switch ident := sel.X.(type) {
							case *ast.Ident:
								if ident.Name == "sync" {
									if sel.Sel.Name == "WaitGroup" {
										hasChan = true
										if m.containsWaitgroup(call_expr.Args[counter]) {
											wg := &WaitGroupStruct{Name: promela_ast.Ident{Name: name.Name, Ident: m.Fileset.Position(name.Pos())}, Wait: m.Fileset.Position(name.Pos())}
											proc.Params = append(proc.Params, promela_ast.Param{Name: name.Name, Types: promela_types.Wgdef})
											new_wgs[name] = wg

											arg, err1 := m.TranslateArgs(call_expr.Args[counter])
											if err1 != nil {
												err = err1
											}
											prom_call.Args = append(prom_call.Args, arg)
											known = true
										} else {
											known = false
										}
									}
								}
							}
						default:
							// the arg is not a channel therefore we include what it does before the call

							stmt, err1 := m.TranslateExpr(call_expr.Args[counter])
							if err1 != nil {
								err = err1
							}
							addBlock(b, stmt)
						}

						counter++
					}
				}

				if hasChan && known {
					// Add the commparam to the param of the new proc
					for _, commPar := range commPars {
						if commPar.Candidate {
							proc.Body.List = append([]promela_ast.Stmt{&promela_ast.DeclStmt{Name: promela_ast.Ident{Name: commPar.Name.Name}, Rhs: &promela_ast.Ident{Name: DEFAULT_BOUND}, Types: promela_types.Int}}, proc.Body.List...)
						} else {
							// decl.Type.Params.List[commPar.Pos].Names[0] = &ast.Ident{Name: commPar.Name.Name + "_1"}
							// RenameBlockStmt(decl.Body, []ast.Expr{commPar.Name}, &ast.Ident{Name: commPar.Name.Name + "_1"})
							proc.Params = append(proc.Params, promela_ast.Param{Name: commPar.Name.Name, Types: promela_types.Int})
						}
					}
					m.Chans = new_chans
					m.WaitGroups = new_wgs
					m.Proctypes = append(m.Proctypes, proc)
					stmt, err1 := m.TranslateBlockStmt(decl.Body)

					if err1 != nil {
						err = err1
					}
					proc.Body = stmt
					m.Fun = prev_decl
					m.Chans = prev_chans
					m.WaitGroups = prev_wg
					m.Package = prev_pack
					m.CommPars = prev_comm
					// need to reset Model because its used in m.TranslateArgs
					for _, commPar := range commPars {
						if !commPar.Candidate {
							arg, err1 := m.TranslateArgs(call_expr.Args[commPar.Pos])
							if err1 != nil {
								err = err1
							}
							prom_call.Args = append(prom_call.Args, arg)
						}
					}

					prom_call.Fun = promela_ast.Ident{Name: func_name, Ident: m.Fileset.Position(call_expr.Pos())}

					r := &promela_ast.RunStmt{X: prom_call, Run: m.Fileset.Position(s.Pos())}

					b.List = append(b.List, r)
				}

				// need to reset Model

				m.Fun = prev_decl
				m.Chans = prev_chans
				m.WaitGroups = prev_wg
				m.Package = prev_pack
				m.CommPars = prev_comm

			}
		} else {
			fmt.Print("promela_translator.go : Func of go statement not found : " + func_name + "\n Called at :")
			fmt.Println(m.Fileset.Position(call_expr.Fun.Pos()))

			for _, arg := range call_expr.Args {
				stmt, err1 := m.TranslateExpr(arg)

				if err1 != nil {
					err = err1
				}
				for _, e := range stmt.List {
					switch e := e.(type) {
					case *promela_ast.RcvStmt:
						b.List = append(b.List, e)
					}
				}
			}
		}

	}

	if m.For_counter.In_for {
		m.For_counter.With_go = true
		m.AddFeature(Feature{
			Proj_name: m.Project_name,
			Fun:       m.Fun.Name.String(),
			Name:      "Go in for",
			Mandatory: "false",
			Line:      m.Fileset.Position(s.Pos()).Line,
			Commit:    m.Commit,
			Filename:  m.Fileset.Position(s.Pos()).Filename,
		})
	}

	return b, err
}

func (m *Model) translateAssignStmt(s *ast.AssignStmt) (b *promela_ast.BlockStmt, err *ParseError) {
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	for _, spec := range s.Rhs {

		expr, err1 := m.TranslateExpr(spec)

		if err1 != nil {
			err = err1
		}
		addBlock(b, expr)
	}

	return b, err
}

func (m *Model) translateForStmt(s *ast.ForStmt) (b *promela_ast.BlockStmt, err *ParseError) {
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}

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

	cond, err1 := m.TranslateExpr(s.Cond)

	if err1 != nil {
		err = err1
	}
	addBlock(b, cond) // translating the condition in case there is a <-a
	init, err1 := m.TranslateBlockStmt(&ast.BlockStmt{List: []ast.Stmt{s.Init}})
	if err1 != nil {
		err = err1
	}
	addBlock(b, init)

	post, err1 := m.TranslateBlockStmt(&ast.BlockStmt{List: []ast.Stmt{s.Post}})
	addBlock(b, post)

	if err1 != nil {
		err = err1
	}

	for_label := &promela_ast.LabelStmt{Name: label_name + "_exit"}

	lb, ub, err1 := m.lookUpFor(s, m.AstMap[m.Package])

	if err1 != nil {
		err = err1
	}
	// Translated body of for loop
	stmts, err1 := m.TranslateBlockStmt(s.Body)

	if err1 != nil {
		err = err1
	}
	body := promela_ast.BlockStmt{List: append(
		[]promela_ast.Stmt{&promela_ast.LabelStmt{Name: label_name}},
		stmts.List...)}

	if m.For_counter.With_go {

		// need to change the for loop into a bounded for loop
		b.List = append(b.List, &promela_ast.ForStmt{
			For:  m.Fileset.Position(s.Pos()),
			Lb:   lb,
			Ub:   ub,
			Body: body,
		})

	} else {

		d := &promela_ast.DoStmt{Do: m.Fileset.Position(s.Pos())}
		d.Guards = append(
			d.Guards,
			promela_ast.GuardStmt{
				Cond: &promela_ast.Ident{Name: "true"},
				Body: &body},
		)
		if s.Cond == nil && s.Post == nil && s.Init == nil {
			// infinite for loop
			// Dont add the if statement just the guard just translate it as an infinite for loop
			b.List = append(b.List, d)
		} else {
			// print the for loop  with the if
			if_stmt := promela_ast.IfStmt{If: m.Fileset.Position(s.Pos())}

			lb_not_given := promela_ast.BinaryExpr{Lhs: &lb, Rhs: &promela_ast.Ident{Name: "-1"}, Op: "!="}
			ub_not_given := promela_ast.BinaryExpr{Lhs: &ub, Rhs: &promela_ast.Ident{Name: "-1"}, Op: "!="}
			then := promela_ast.GuardStmt{
				Cond: &promela_ast.BinaryExpr{Lhs: &lb_not_given,
					Rhs: &ub_not_given, Op: "&&"},
				Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&promela_ast.ForStmt{For: m.Fileset.Position(s.Pos()), Lb: lb, Ub: ub, Body: body}}},
			}
			// the else part

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

	return b, err
}

func (m *Model) translateRangeStmt(s *ast.RangeStmt) (b *promela_ast.BlockStmt, err *ParseError) {
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	d := &promela_ast.DoStmt{Do: m.Fileset.Position(s.Pos())}

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

	ub, err1 := m.lookUp(s.X, UPPER_FOR_BOUND, true)

	if err1 != nil {
		err = err1
	}

	if m.containsChan(s.X) {
		chan_name := m.getChanStruct(s.X)

		do_guard := promela_ast.GuardStmt{Cond: &promela_ast.RcvStmt{Chan: &promela_ast.Ident{Name: chan_name.Name.Name + ".is_closed"}, Rhs: &promela_ast.Ident{Name: "state"}}}
		if_closed_guard := promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "state"}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&promela_ast.Ident{Name: "break"}}}}

		async_rcv := &promela_ast.RcvStmt{Chan: &promela_ast.SelectorExpr{X: &chan_name.Name, Sel: promela_ast.Ident{Name: "async_rcv"}}, Rhs: &promela_ast.Ident{Name: "0"}}

		sync_rcv := &promela_ast.RcvStmt{Chan: &promela_ast.SelectorExpr{X: &chan_name.Name, Sel: promela_ast.Ident{Name: "sync"}}, Rhs: &promela_ast.Ident{Name: "0"}}

		async_guard := promela_ast.GuardStmt{Cond: async_rcv, Guard: m.Fileset.Position(s.Pos()), Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}

		sync_guard := promela_ast.GuardStmt{
			Cond: sync_rcv,
			Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}},
		}
		i := &promela_ast.IfStmt{Guards: []promela_ast.GuardStmt{async_guard, sync_guard}}
		if_not_closed_guard := promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "else"}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{i}}}

		s1, err1 := m.TranslateBlockStmt(s.Body)

		if err1 != nil {
			err = err1
		}
		if_not_closed_guard.Body.List = append(if_not_closed_guard.Body.List, s1.List...)

		body := &promela_ast.BlockStmt{List: []promela_ast.Stmt{&promela_ast.CondStmt{Guards: []promela_ast.GuardStmt{if_closed_guard, if_not_closed_guard}}}}
		do_guard.Body = body
		d.Guards = append(d.Guards, do_guard)
		b.List = append(b.List, d)

	} else {

		// change into (for i:=0; i < len(x);i++)
		s1, err1 := m.TranslateBlockStmt(s.Body)
		block_stmt := s1

		if err1 != nil {
			err = err1
		}
		// add the 'for' label
		block_stmt.List = append([]promela_ast.Stmt{&promela_ast.LabelStmt{Name: label_name}}, block_stmt.List...)

		if m.spawns(s.Body, false) || ContainsCommParam(m.CommPars, &CommPar{Name: &ast.Ident{Name: ub.Name}}) {
			// need to change the for loop into a bounded for loop
			b.List = append(b.List, &promela_ast.ForStmt{For: m.Fileset.Position(s.Pos()), Lb: promela_ast.Ident{Name: "1"}, Ub: ub, Body: *block_stmt})
		} else {

			break_branch := promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&promela_ast.Ident{Name: "break"}}}}
			d.Guards = append(d.Guards,
				promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: block_stmt},
				break_branch,
			)
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

	return b, err
}

func (m *Model) translateSwitchStmt(s *ast.SwitchStmt) (b *promela_ast.BlockStmt, err *ParseError) {
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	i := &promela_ast.IfStmt{If: m.Fileset.Position(s.Pos()), Init: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}

	tag, err1 := m.TranslateExpr(s.Tag)
	if err1 != nil {
		err = err1
	}
	i.Init = tag

	init, err1 := m.TranslateBlockStmt(&ast.BlockStmt{List: []ast.Stmt{s.Init}})
	if err1 != nil {
		err = err1
	}
	addBlock(i.Init, init)

	for _, stmt := range s.Body.List {
		switch stmt := stmt.(type) {
		case *ast.CaseClause:

			for _, e := range stmt.List {

				expr, err1 := m.TranslateExpr(e)

				if err1 != nil {
					err = err1
				}
				addBlock(b, expr)
			}

			body, err1 := m.TranslateBlockStmt(&ast.BlockStmt{List: stmt.Body})

			if err1 != nil {
				err = err1
			}
			guard := &promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: body}

			i.Guards = append(i.Guards, *guard)
		default:
			fmt.Println("Promela_translator.go: in a switch and its not a case clause or a default")
		}
	}

	b.List = append(b.List, i)

	return b, err
}

func (m *Model) translateSelectStmt(s *ast.SelectStmt) (b *promela_ast.BlockStmt, err *ParseError) {
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	i := &promela_ast.SelectStmt{Select: m.Fileset.Position(s.Pos())}

	for _, comm := range s.Body.List {
		switch comm := comm.(type) {
		case *ast.CommClause: // can only be a commClause
			body, err1 := m.TranslateBlockStmt(&ast.BlockStmt{List: comm.Body})

			if err1 != nil {
				err = err1
			}
			if comm.Comm != nil { // check if default select

				switch com := comm.Comm.(type) {
				case *ast.SendStmt: // send
					if m.containsChan(com.Chan) {
						chan_name := m.getChanStruct(com.Chan)

						async_send := &promela_ast.SendStmt{Chan: &promela_ast.SelectorExpr{X: &chan_name.Name, Sel: promela_ast.Ident{Name: "async_send"}}, Rhs: &promela_ast.Ident{Name: "0"}}

						sync_send := &promela_ast.SendStmt{Chan: &promela_ast.SelectorExpr{X: &chan_name.Name, Sel: promela_ast.Ident{Name: "sync"}}, Rhs: &promela_ast.Ident{Name: "0"}}

						async_guard := promela_ast.GuardStmt{Cond: async_send, Guard: m.Fileset.Position(comm.Pos()), Body: m.checkForBreak(*body)}
						sending_chan := &promela_ast.SelectorExpr{X: &chan_name.Name, Sel: promela_ast.Ident{Name: "sending"}}

						sync_guard := promela_ast.GuardStmt{
							Cond: sync_send,
							Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{
								&promela_ast.RcvStmt{
									Chan: sending_chan,
									Rhs:  &promela_ast.Ident{Name: "0"}}}},
							Guard: m.Fileset.Position(s.Pos())}

						sync_guard.Body.List = append(sync_guard.Body.List, body.List...)

						sync_guard.Body = m.checkForBreak(*sync_guard.Body)
						i.Guards = append(i.Guards, async_guard, sync_guard)
					} else {
						i.Guards = append(i.Guards, promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: body})
					}
				case *ast.ExprStmt:
					switch una := com.X.(type) {
					case *ast.UnaryExpr: //receive
						if una.Op == token.ARROW {
							if m.containsChan(una.X) {
								chan_name := m.getChanStruct(una.X)
								async_rcv := &promela_ast.RcvStmt{Chan: &promela_ast.SelectorExpr{X: &chan_name.Name, Sel: promela_ast.Ident{Name: "async_rcv"}}, Rhs: &promela_ast.Ident{Name: "0"}}

								sync_rcv := &promela_ast.RcvStmt{Chan: &promela_ast.SelectorExpr{X: &chan_name.Name, Sel: promela_ast.Ident{Name: "sync"}}, Rhs: &promela_ast.Ident{Name: "0"}}

								async_guard := promela_ast.GuardStmt{Cond: async_rcv, Guard: m.Fileset.Position(comm.Pos()), Body: m.checkForBreak(*body)}

								sync_guard := promela_ast.GuardStmt{
									Cond: sync_rcv,
									Body: m.checkForBreak(*body),
								}
								i.Guards = append(i.Guards, async_guard, sync_guard)
							} else {
								i.Guards = append(i.Guards, promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: body})
							}
						}
					}
				}

			} else { // it is default
				i.Has_default = true
				i.Guards = append(i.Guards, promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Guard: m.Fileset.Position(comm.Pos()), Body: m.checkForBreak(*body)})
			}

		}
	}

	b.List = append(b.List, i)

	return b, err
}

// takes a promela body and add break if there are no breaks at the end or if there is
// add a goto to the surrounding for loop
func (m *Model) checkForBreak(body promela_ast.BlockStmt) *promela_ast.BlockStmt {
	if !containsBreak(&body) && !containsReturn(&body) { // no return or break then just break
		body.List = append(body.List, &promela_ast.Ident{Name: "break"})
	} else {
		if containsBreak(&body) {
			// removes the break to replace it with a goto
			body.List = body.List[:len(body.List)-1]
			// add a goto end of select and break
			body.List = append(body.List, &promela_ast.GotoStmt{Label: fmt.Sprintf("for%d%d_exit", m.For_counter.X, m.For_counter.Y)})
		}
	}
	return &body
}

func (m *Model) translateExprStmt(s *ast.ExprStmt) (b *promela_ast.BlockStmt, err *ParseError) {
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}

	expr, err1 := m.TranslateExpr(s.X)

	if err1 != nil {
		err = err1
	}
	addBlock(b, expr)
	return b, err
}

func (m *Model) translateSendStmt(s *ast.SendStmt) (b *promela_ast.BlockStmt, err *ParseError) {
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}

	if m.containsChan(s.Chan) {
		chan_name := m.getChanStruct(s.Chan)

		sync_send := &promela_ast.SendStmt{
			Chan: &promela_ast.SelectorExpr{
				X:   &chan_name.Name,
				Sel: promela_ast.Ident{Name: "sync"}},
			Rhs:  &promela_ast.Ident{Name: "0"},
			Send: m.Fileset.Position(s.Pos())}
		async_send := &promela_ast.SendStmt{
			Chan: &promela_ast.SelectorExpr{
				X:   &chan_name.Name,
				Sel: promela_ast.Ident{Name: "async_send"}},
			Rhs:  &promela_ast.Ident{Name: "0"},
			Send: m.Fileset.Position(s.Pos())}

		sending_chan := &promela_ast.SelectorExpr{X: &chan_name.Name, Sel: promela_ast.Ident{Name: "sending"}}

		sync_guard := promela_ast.GuardStmt{
			Cond: sync_send,
			Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{
				&promela_ast.RcvStmt{
					Chan: sending_chan,
					Rhs:  &promela_ast.Ident{Name: "0"}}}},
			Guard: m.Fileset.Position(s.Pos())}
		async_guard := promela_ast.GuardStmt{Cond: async_send, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}, Guard: m.Fileset.Position(s.Pos())}
		if_stmt := &promela_ast.IfStmt{Guards: []promela_ast.GuardStmt{async_guard, sync_guard}}
		expr, err1 := m.TranslateExpr(s.Value)

		if err1 != nil {
			err = err1
		}
		addBlock(b, expr)

		b.List = append(b.List, if_stmt)
	}

	return b, err

}

func (m *Model) translateDeclStmt(s *ast.DeclStmt) (b *promela_ast.BlockStmt, err *ParseError) {
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	switch d := s.Decl.(type) {
	case *ast.GenDecl:
		for _, spec := range d.Specs {
			switch spec := spec.(type) {
			case *ast.ValueSpec:
				for _, val := range spec.Values {
					expr, err1 := m.TranslateExpr(val)
					if err1 != nil {
						err = err1
					}
					addBlock(b, expr)
				}
			}

		}
	}
	return b, err
}

func (m *Model) translateReturnStmt(s *ast.ReturnStmt) (b *promela_ast.BlockStmt, err *ParseError) {
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	for _, spec := range s.Results {

		expr, err1 := m.TranslateExpr(spec)
		if err1 != nil {
			err = err1
		}
		addBlock(b, expr)
	}

	b.List = append(b.List,
		&promela_ast.GotoStmt{
			Goto:  m.Fileset.Position(s.Pos()),
			Label: "stop_process"})
	return b, err
}

func (m *Model) translateBranchStmt(s *ast.BranchStmt) (b *promela_ast.BlockStmt, err *ParseError) {
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	br := &promela_ast.GotoStmt{
		Goto: m.Fileset.Position(s.Pos()),
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

	return b, err
}

func (m *Model) translateLabeledStmt(s *ast.LabeledStmt) (b *promela_ast.BlockStmt, err *ParseError) {
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	label := &promela_ast.LabelStmt{Label: m.Fileset.Position(s.Pos()), Name: s.Label.Name}

	stmts, err1 := m.TranslateBlockStmt(&ast.BlockStmt{List: []ast.Stmt{s.Stmt}})
	if err1 != nil {
		err = err1
	}
	b.List = append(b.List, label, stmts)

	return b, err
}

func (m *Model) TranslateExpr(expr ast.Expr) (b *promela_ast.BlockStmt, err *ParseError) {
	stmts := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	switch expr := expr.(type) {
	case *ast.BinaryExpr:
		e1, err1 := m.TranslateExpr(expr.X)
		if err1 != nil {
			err = err1
		}
		addBlock(stmts, e1)

		expr2, err2 := m.TranslateExpr(expr.Y)
		if err2 != nil {
			err = err2
		}
		addBlock(stmts, expr2)

	case *ast.CallExpr:
		switch name := expr.Fun.(type) {
		case *ast.Ident:
			if name.Name == "close" && len(expr.Args) == 1 { // closing a chan
				send := &promela_ast.SendStmt{Send: m.Fileset.Position(name.Pos())}

				ch := TranslateIdent(expr.Args[0], m.Fileset)

				if m.containsChan(expr.Args[0]) {
					send.Chan = &promela_ast.SelectorExpr{
						X: &ch, Sel: promela_ast.Ident{Name: "closing"},
						Pos: m.Fileset.Position(expr.Args[0].Pos()),
					}
					send.Rhs = &promela_ast.Ident{Name: "true"}
					m.Chan_closing = true
					stmts.List = append(stmts.List, send)
				}
			} else {
				call, err1 := m.TranslateCallExpr(expr)
				if err1 != nil {
					err = err1
				}
				addBlock(stmts, call)
			}

		case *ast.SelectorExpr:
			call, err1 := m.TranslateCallExpr(expr)
			if err1 != nil {
				err = err1
			}
			addBlock(stmts, call)

		case *ast.FuncLit:
			new_block := name.Body
			for x, field := range name.Type.Params.List {
				for y, name := range field.Names {

					arg := expr.Args[x+y]
					switch expr := expr.Args[x+y].(type) {
					case *ast.UnaryExpr:
						arg = expr.X
					}
					new_block = RenameBlockStmt(new_block, []ast.Expr{name}, arg)
				}
			}

			return m.TranslateBlockStmt(new_block)

		}

	case *ast.UnaryExpr:
		switch expr.Op {
		case token.ARROW:

			channel := m.getChanStruct(expr.X)
			if channel != nil {
				chan_name := &channel.Name

				if_stmt := &promela_ast.IfStmt{Guards: []promela_ast.GuardStmt{}}

				async_rcv := &promela_ast.RcvStmt{Chan: &promela_ast.SelectorExpr{X: chan_name, Sel: promela_ast.Ident{Name: "async_rcv"}}, Rhs: &promela_ast.Ident{Name: "0"}, Rcv: m.Fileset.Position(expr.Pos())}
				sync_rcv := &promela_ast.RcvStmt{Chan: &promela_ast.SelectorExpr{X: chan_name, Sel: promela_ast.Ident{Name: "sync"}}, Rhs: &promela_ast.Ident{Name: "0"}, Rcv: m.Fileset.Position(expr.Pos())}

				async_guard := promela_ast.GuardStmt{Cond: async_rcv, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}
				sync_guard := promela_ast.GuardStmt{Cond: sync_rcv, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}

				if_stmt.Guards = append(if_stmt.Guards, async_guard, sync_guard)

				stmts.List = append(stmts.List, if_stmt)
			}
		}

	case *ast.ParenExpr:
		call, err1 := m.TranslateExpr(expr.X)
		if err1 != nil {
			err = err1
		}
		addBlock(stmts, call)
	}
	return stmts, err
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

func (m *Model) TranslateCallExpr(call_expr *ast.CallExpr) (b *promela_ast.BlockStmt, err *ParseError) {

	stmts := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	// if obj != nil {
	var fun string       // The name of the function we are translating
	var func_name string // The corresponding promela function name consisting of package + fun + num of param
	var pack_name string = m.Package

	var obj types.Object

	// Find name of function
	switch name := call_expr.Fun.(type) {
	case *ast.Ident:
		obj = m.AstMap[m.Package].TypesInfo.ObjectOf(name)
	case *ast.SelectorExpr:
		// Check if its a call a Waitgroup call (Add(x), Done or Wait)
		sel := m.AstMap[m.Package].TypesInfo.Selections[name]
		fun = name.Sel.Name

		if sel == nil {
			obj = m.AstMap[m.Package].TypesInfo.ObjectOf(name.Sel)
		} else {
			obj = sel.Obj()
		}
	case *ast.FuncLit:
		panic("Promela_translator.go : Should not have a funclit here")
	}
	if obj != nil {
		switch name := call_expr.Fun.(type) {
		case *ast.Ident:
			func_name = filepath.Base(pack_name) + name.Name
			fun = name.Name
		case *ast.SelectorExpr:
			// Check if its a call a Waitgroup call (Add(x), Done or Wait)
			func_name = TranslateIdent(name.X, m.Fileset).Name + name.Sel.Name
			fun = name.Sel.Name
			if obj.Pkg() != nil {
				pack_name = obj.Pkg().Name()
			}

			if m.containsWaitgroup(&ast.Ident{Name: translateIdent(name.X).Name}) {
				if pack_name == "sync" {
					if name.Sel.Name == "Add" {
						ub, err1 := m.lookUp(call_expr.Args[0], ADD_BOUND, m.For_counter.In_for)

						if err1 != nil {
							err = err1
						}
						stmts.List = append(stmts.List, &promela_ast.SendStmt{Chan: &promela_ast.Ident{Name: translateIdent(name.X).Name + ".Add"}, Rhs: &ub})

					}
					if name.Sel.Name == "Done" {
						stmts.List = append(stmts.List, &promela_ast.SendStmt{Chan: &promela_ast.Ident{Name: translateIdent(name.X).Name + ".Add"}, Rhs: &promela_ast.Ident{Name: "-1"}})
					}
					if name.Sel.Name == "Wait" {
						stmts.List = append(stmts.List, &promela_ast.RcvStmt{Chan: &promela_ast.Ident{Name: translateIdent(name.X).Name + ".Wait"}, Rhs: &promela_ast.Ident{Name: "0"}})
					}
				}
			}
		case *ast.FuncLit:
			panic("Promela_translator.go : Should not have a funclit here")
		}
		if !m.ContainsRecFunc(pack_name, func_name) && !m.CallExists(func_name) {

			if found, decl := FindDecl(pack_name, fun, len(call_expr.Args), m.AstMap); found {
				hasChan := false
				known := true                                      // Do we know all the channel that it might take as args ?? (if time.After() given as arg then we dont translate the call)
				var args []promela_ast.Expr = []promela_ast.Expr{} // building the new call's args
				new_chans := make(map[ast.Expr]*ChanStruct)
				new_wg := make(map[ast.Expr]*WaitGroupStruct)
				params := []promela_ast.Param{}

				for x, param := range decl.Type.Params.List {
					for y, name := range param.Names {
						switch sel := param.Type.(type) {
						case *ast.StarExpr:
							switch sel := sel.X.(type) {
							case *ast.SelectorExpr:
								switch ident := sel.X.(type) {
								case *ast.Ident:
									if ident.Name == "sync" {
										if sel.Sel.Name == "WaitGroup" {
											hasChan = true
											wg := &WaitGroupStruct{Name: promela_ast.Ident{Name: name.Name, Ident: m.Fileset.Position(name.Pos())}, Wait: m.Fileset.Position(name.Pos())}
											params = append(params, promela_ast.Param{Name: name.Name, Types: promela_types.Wgdef})
											new_wg[name] = wg
											if m.containsWaitgroup(call_expr.Args[x+y]) {
												arg, err1 := m.TranslateArgs(call_expr.Args[x+y])
												if err1 != nil {
													err = err1
												}
												args = append(args, arg)
											} else {
												known = false
											}
										}
									}
								}
							}
						case *ast.ChanType:

							hasChan = true
							ch := &ChanStruct{Name: promela_ast.Ident{Name: name.Name, Ident: m.Fileset.Position(name.Pos())}, Chan: m.Fileset.Position(name.Pos())}
							params = append(params, promela_ast.Param{Name: name.Name, Types: promela_types.Chandef})
							new_chans[name] = ch
							if m.getChanStruct(call_expr.Args[x+y]) != nil {
								arg, err1 := m.TranslateArgs(call_expr.Args[x+y])
								if err1 != nil {
									err = err1
								}
								args = append(args, arg)
							} else {
								known = false
							}
						case *ast.SelectorExpr:
							switch ident := sel.X.(type) {
							case *ast.Ident:
								if ident.Name == "sync" {
									if sel.Sel.Name == "WaitGroup" {
										hasChan = true
										wg := &WaitGroupStruct{Name: promela_ast.Ident{Name: name.Name, Ident: m.Fileset.Position(name.Pos())}, Wait: m.Fileset.Position(name.Pos())}
										params = append(params, promela_ast.Param{Name: name.Name, Types: promela_types.Wgdef})
										new_wg[name] = wg
										if m.containsWaitgroup(call_expr.Args[x+y]) {
											arg, err1 := m.TranslateArgs(call_expr.Args[x+y])
											if err1 != nil {
												err = err1
											}
											args = append(args, arg)
										} else {
											known = false
										}
									}
								}
							}
						}
					}
				}

				if hasChan && known {
					m.AddRecFunc(pack_name, fun)
					// Generate a new proctype to model the recursive call
					proc := &promela_ast.Proctype{
						Name: promela_ast.Ident{Name: func_name},
						Pos:  m.Fileset.Position(call_expr.Pos()), Active: false,
						Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}},
					}

					proc.Params = params
					// Translate the commPar of the function call ignoring the args that are not needed

					prev_decl := *m.Fun
					prev_pack := m.Package
					m.Package = pack_name
					prev_chans := m.Chans
					prev_wg := m.WaitGroups
					m.Chans = new_chans
					m.WaitGroups = new_wg
					m.Fun = decl

					commPars := m.AnalyseCommParam(pack_name, decl, m.AstMap, false) // recover the commPar

					for _, commPar := range commPars {
						if !commPar.Candidate {
							proc.Params = append(proc.Params, promela_ast.Param{Name: commPar.Name.Name, Types: promela_types.Int})
							arg, err1 := m.TranslateArgs(call_expr.Args[commPar.Pos])
							if err1 == nil {
								args = append(args, arg)
							} else { // the arguments passed as a commparam cannot be translated
								ident := promela_ast.Ident{Name: "not_found_" + strconv.Itoa(m.Fileset.Position(call_expr.Args[commPar.Pos].Pos()).Line)}
								m.Defines = append(m.Defines, promela_ast.DefineStmt{Name: ident, Rhs: &promela_ast.Ident{Name: DEFAULT_BOUND}})
								args = append(args, &ident)
							}
						}
					}

					// add child param
					proc.Params = append(proc.Params, promela_ast.Param{Name: "child", Types: promela_types.Chan})

					// add child chan as arg to the call
					args = append(args, &promela_ast.Ident{Name: "child_" + func_name + strconv.Itoa(m.Counter)})

					m.Proctypes = append(m.Proctypes, proc)

					s1, err1 := m.TranslateBlockStmt(decl.Body)

					if err1 != nil {
						err = err1
					}

					proc.Body.List = s1.List
					proc.Body.List = append(proc.Body.List, &promela_ast.SendStmt{Chan: &promela_ast.Ident{Name: "child"}, Rhs: &promela_ast.Ident{Name: "0"}})
					m.Fun = &prev_decl
					m.Chans = prev_chans
					m.WaitGroups = prev_wg
					m.Package = prev_pack

					// add a call to it
					stmts.List = append(stmts.List,
						&promela_ast.Chandef{Name: promela_ast.Ident{Name: "child_" + func_name + strconv.Itoa(m.Counter)}, Size: promela_ast.Ident{Name: "0"}, Types: []promela_types.Types{promela_types.Int}},
						&promela_ast.RunStmt{X: promela_ast.CallExpr{Fun: promela_ast.Ident{Name: func_name}, Args: args}},
						&promela_ast.RcvStmt{Chan: &promela_ast.Ident{Name: "child_" + func_name + strconv.Itoa(m.Counter)}, Rhs: &promela_ast.Ident{Name: "0"}},
					)
					m.Counter++

					// }
				} else {
					for _, arg := range call_expr.Args {
						switch e := arg.(type) {
						case *ast.UnaryExpr:
							if e.Op == token.ARROW {
								if m.containsChan(e.X) {
									chan_name := m.getChanStruct(e.X)
									async_rcv := &promela_ast.RcvStmt{Chan: &promela_ast.SelectorExpr{X: &chan_name.Name, Sel: promela_ast.Ident{Name: "async_rcv"}}, Rhs: &promela_ast.Ident{Name: "0"}}

									sync_rcv := &promela_ast.RcvStmt{Chan: &promela_ast.SelectorExpr{X: &chan_name.Name, Sel: promela_ast.Ident{Name: "sync"}}, Rhs: &promela_ast.Ident{Name: "0"}}

									async_guard := promela_ast.GuardStmt{Cond: async_rcv, Guard: m.Fileset.Position(arg.Pos()), Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}

									sync_guard := promela_ast.GuardStmt{
										Cond: sync_rcv,
										Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}},
									}
									i := &promela_ast.IfStmt{Guards: []promela_ast.GuardStmt{async_guard, sync_guard}}
									stmts.List = append(stmts.List, i)
								}
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

	return stmts, err
}

// Return if the expr given could be translated to a var or not and if it can its promela expr.
func (m *Model) TranslateArgs(expr ast.Expr) (e promela_ast.Expr, err *ParseError) {

	var e1 promela_ast.Expr = nil

	switch expr := expr.(type) {
	case *ast.Ident:
		e1 = &promela_ast.Ident{Name: expr.Name, Ident: m.Fileset.Position(expr.Pos())}
	case *ast.SelectorExpr:
		e1 = &promela_ast.Ident{Name: m.getIdent(expr.X).Name + "_" + expr.Sel.Name,
			Ident: m.Fileset.Position(expr.Pos())}
	case *ast.BinaryExpr:
		lhs, err1 := m.TranslateArgs(expr.X)

		if err1 != nil {
			err = err1
		}
		rhs, err2 := m.TranslateArgs(expr.Y)

		if err2 != nil {
			err = err2
		}
		if err == nil {

			e1 = &promela_ast.BinaryExpr{Lhs: lhs, Op: expr.Op.String(), Rhs: rhs}
		}
	case *ast.UnaryExpr:
		unary, err1 := m.TranslateArgs(expr.X)

		if err1 != nil {
			err = err1
		} else {
			e1 = &promela_ast.ExprStmt{X: unary}
		}
	case *ast.CallExpr:
		if TranslateIdent(expr.Fun, m.Fileset).Name == "len" {
			return m.TranslateArgs(expr.Args[0]) // if its len just return the translation of the first args which is the list
		}

		arg, err1 := m.TranslateArgs(expr.Fun)

		if err1 != nil {
			err = err1

			call := &promela_ast.CallExpr{Fun: promela_ast.Ident{Name: m.getIdent(expr.Fun).Name}, Call: m.Fileset.Position(expr.Pos())}

			args := []promela_ast.Expr{}

			for i, arg := range expr.Args {

				if ContainsCommParam(m.CommPars, &CommPar{Name: m.getIdent(arg)}) {
					arg1, err1 := m.TranslateArgs(arg)

					if err1 != nil {
						err = err1
					}

					args = append(args, arg1)
				} else {

					ident := &promela_ast.Ident{Name: m.getIdent(expr.Fun).Name + strconv.Itoa(m.Fileset.Position(expr.Fun.Pos()).Line) + "_arg" + strconv.Itoa(i)}
					m.Defines = append(m.Defines, promela_ast.DefineStmt{Name: *ident, Rhs: &promela_ast.Ident{Name: "-1"}})
					args = append(args, ident)
					// }
				}
			}
			call.Args = args
			// create new inline if not seen before
			if !m.containsInline(expr.Fun) { // if the function has not been seen previously lets ask the user for its value
				m.Inlines = append(m.Inlines, &promela_ast.Inline{Name: promela_ast.Ident{Name: m.getIdent(expr.Fun).Name}, Params: args, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&promela_ast.Ident{Name: "return 0"}}}})
			}
			e1 = call
		} else {
			return arg, &ParseError{err: errors.New("Could not parse the name of the function at pos " + m.Fileset.Position(expr.Pos()).String())}
		}
	case *ast.BasicLit:
		e1 = &promela_ast.Ident{Name: expr.Value}
	case *ast.StarExpr:
		return m.TranslateArgs(expr.X)
	case *ast.ParenExpr:
		return m.TranslateArgs(expr.X)
	case *ast.CompositeLit:
		return &promela_ast.Ident{Name: strconv.Itoa(len(expr.Elts))}, nil
	default:
		err = &ParseError{err: errors.New("Could not parse an arguments at line " + m.Fileset.Position(expr.Pos()).String())}
		// e1 := &promela_ast.Ident{Name: "not_found_" + strconv.Itoa(len(m.Defines)), Ident: m.Fileset.Position(expr.Pos())}

		// case *ast.IndexExpr:
		// 	e1 = m.TranslateArgs(expr.X)
		// 	// }
		// case *ast.SliceExpr:
		// 	e1 = m.TranslateArgs(expr.X)
		// case *ast.KeyValueExpr:
		// 	e1 = m.TranslateArgs(expr.Key)
		// case *ast.ArrayType:
		// 	anonym := &promela_ast.Ident{Name: "not_found_" + strconv.Itoa(len(m.Defines)), Ident: m.Fileset.Position(expr.Pos())}
		// 	m.Defines = append(m.Defines, promela_ast.DefineStmt{Name: *anonym, Rhs: &promela_ast.Ident{Name: DEFAULT_BOUND}})
		// 	return anonym
		// case *ast.StructType:
		// 	anonym := &promela_ast.Ident{Name: "not_found_" + strconv.Itoa(len(m.Defines)), Ident: m.Fileset.Position(expr.Pos())}
		// 	m.Defines = append(m.Defines, promela_ast.DefineStmt{Name: *anonym, Rhs: &promela_ast.Ident{Name: DEFAULT_BOUND}})
		// 	return anonym
		// case *ast.ChanType:
		// 	anonym := &promela_ast.Ident{Name: "not_found_" + strconv.Itoa(len(m.Defines)), Ident: m.Fileset.Position(expr.Pos())}
		// 	m.Defines = append(m.Defines, promela_ast.DefineStmt{Name: *anonym, Rhs: &promela_ast.Ident{Name: DEFAULT_BOUND}})
		// 	return anonym
		// case *ast.TypeAssertExpr:
		// 	e1 = &promela_ast.Ident{Name: "type_assert", Ident: m.Fileset.Position(expr.Pos())}
		// case *ast.FuncLit:
		// 	e1 = &promela_ast.Ident{Name: "func_lit", Ident: m.Fileset.Position(expr.Pos())}
		// default:
		// 	ast.Print(m.Fileset, expr)
	}
	return e1, err
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

func (m *Model) containsWaitgroup(expr ast.Expr) bool {

	switch ptr := expr.(type) {
	case *ast.UnaryExpr:
		expr = ptr.X
	}

	for e, _ := range m.WaitGroups {
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
func (m *Model) lookUpFor(s *ast.ForStmt, pack *packages.Package) (lb promela_ast.Ident, ub promela_ast.Ident, err *ParseError) {

	well_formed := false

	switch cond := s.Cond.(type) {
	case *ast.BinaryExpr:
		if cond.Op == token.GEQ || cond.Op == token.GTR {
			switch inc := s.Post.(type) {
			case *ast.IncDecStmt:
				if inc.Tok == token.DEC {
					ident, err1 := m.lookUp(cond.Y, LOWER_FOR_BOUND, m.spawns(s.Body, false))
					if err1 != nil {
						err = err1
					}
					lb.Name = ident.Print(0)

					// look for upper bound
					switch stmt := s.Init.(type) {
					case *ast.AssignStmt:
						for _, rh := range stmt.Rhs {
							ident, err1 := m.lookUp(rh, UPPER_FOR_BOUND, m.spawns(s.Body, false))
							if err1 != nil {
								err = err1
							}
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
					ident, err1 := m.lookUp(cond.Y, UPPER_FOR_BOUND, m.spawns(s.Body, false))
					if err1 != nil {
						err = err1
					}
					ub.Name = ident.Print(0)

					// look for lower bound
					switch stmt := s.Init.(type) {
					case *ast.AssignStmt:
						for _, rh := range stmt.Rhs {
							ident, err1 := m.lookUp(rh, LOWER_FOR_BOUND, m.spawns(s.Body, false))
							if err1 != nil {
								err = err1
							}
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

	if !well_formed {
		lb_decl := promela_ast.DefineStmt{Rhs: &promela_ast.Ident{Name: strconv.Itoa(m.Default_lb)}}
		ub_decl := promela_ast.DefineStmt{Rhs: &promela_ast.Ident{Name: strconv.Itoa(m.Default_ub)}}

		// ask user to give lb and ub for the for loop naming the variable according to its line number and unique number
		lb_decl.Name.Name = fmt.Sprintf("lb_for%d_%d", m.Fileset.Position(s.Pos()).Line, len(m.Defines))
		m.Defines = append(m.Defines, lb_decl) // adding lb

		ub_decl.Name.Name = fmt.Sprintf("ub_for%d_%d", m.Fileset.Position(s.Pos()).Line, len(m.Defines))
		m.Defines = append(m.Defines, ub_decl) // adding ub

		lb = lb_decl.Name // returning the fresh vars
		ub = ub_decl.Name

		if !(s.Init == nil && s.Cond == nil && s.Post == nil) {
			m.AddFeature(Feature{
				Proj_name: m.Project_name,
				Fun:       m.Fun.Name.String(),
				Name:      "For loop not well formed",
				Mandatory: "false",
				Info:      fmt.Sprint("Init : ", s.Init, " Cond : ", s.Cond, " Post : ", s.Post),
				Line:      m.Fileset.Position(s.Pos()).Line,
				Commit:    m.Commit,
				Filename:  m.Fileset.Position(s.Pos()).Filename,
			})
		}
	}
	return

}

// take a for or range loop and return if its const, the bound of the for loop and the name in Go of the bound
func (m *Model) lookUp(expr ast.Expr, bound_type int, spawning_for_loop bool) (promela_ast.Ident, *ParseError) {

	var ident promela_ast.Expr
	var err *ParseError
	var bound string = "for bound"
	var mandatory string = "false"
	switch bound_type {
	case CHAN_BOUND:
		bound = "chan bound"
		mandatory = "true"
	case LOWER_FOR_BOUND:
		bound = "for lower bound"
		if spawning_for_loop {
			mandatory = "true"
			bound = "spawning for lower bound"
		}
	case UPPER_FOR_BOUND:
		bound = "for upper bound"
		if spawning_for_loop {
			mandatory = "true"
			bound = "spawning for upper bound"
		}
	case ADD_BOUND:
		mandatory = "true"
		bound = "add bound"
	}
	i1, err1 := m.TranslateArgs(expr)
	if err1 != nil {
		err = err1
	}

	ident = i1
	switch expr := expr.(type) {
	case *ast.UnaryExpr:

		if expr.Op == token.ARROW {
			m.AddBound(Feature{
				Proj_name: m.Project_name,
				Fun:       m.Fun.Name.String(),
				Name:      "Receive as a " + bound,
				Mandatory: mandatory,
				Info:      "Name : " + prettyPrint(expr) + " Mandatory : " + mandatory,
				Line:      m.Fileset.Position(expr.Pos()).Line,
				Commit:    m.Commit,
				Filename:  m.Fileset.Position(expr.Pos()).Filename,
			})
		} else if expr.Op == token.AND {
			m.AddBound(Feature{
				Proj_name: m.Project_name,
				Fun:       m.Fun.Name.String(),
				Name:      "Pointer as a " + bound,
				Mandatory: mandatory,
				Info:      "Name : " + prettyPrint(expr.X),
				Line:      m.Fileset.Position(expr.Pos()).Line,
				Commit:    m.Commit,
				Filename:  m.Fileset.Position(expr.Pos()).Filename,
			})
		}

	case *ast.CallExpr:
		// Function as a comm param
		m.AddBound(Feature{
			Proj_name: m.Project_name,
			Fun:       m.Fun.Name.String(),
			Name:      "Func as a " + bound,
			Mandatory: mandatory,
			Info:      "Name : " + prettyPrint(expr),
			Line:      m.Fileset.Position(expr.Pos()).Line,
			Commit:    m.Commit,
			Filename:  m.Fileset.Position(expr.Pos()).Filename,
		})
		if m.getIdent(expr.Fun).Name == "len" {
			m.AddBound(Feature{
				Proj_name: m.Project_name,
				Fun:       m.Fun.Name.String(),
				Name:      "len() as a " + bound,
				Mandatory: mandatory,
				Info:      "Name : " + prettyPrint(expr),
				Line:      m.Fileset.Position(expr.Pos()).Line,
				Commit:    m.Commit,
				Filename:  m.Fileset.Position(expr.Pos()).Filename,
			})

		}
	case *ast.SelectorExpr:
		Types := m.AstMap[m.Package].TypesInfo.Selections[expr]

		if Types == nil {
			fmt.Println("Could not find type of expr : ", expr, " at pos : ", m.Fileset.Position(expr.Pos()))
		} else {
			switch Types.Type().(type) {
			case *types.Struct:
				// Struct as a bound
				m.AddBound(Feature{
					Proj_name: m.Project_name,
					Fun:       m.Fun.Name.String(),
					Name:      "Struct as a " + bound,
					Mandatory: mandatory,
					Info:      "UNSUPPORTED",
					Line:      m.Fileset.Position(expr.Pos()).Line,
					Commit:    m.Commit,
					Filename:  m.Fileset.Position(expr.Pos()).Filename,
				})

			case *types.Named:
				// Struct as a bound
				m.AddBound(Feature{
					Proj_name: m.Project_name,
					Fun:       m.Fun.Name.String(),
					Name:      "UNSUPPORTED",
					Mandatory: mandatory,
					Info:      "Name : " + prettyPrint(expr),
					Line:      m.Fileset.Position(expr.Pos()).Line,
					Commit:    m.Commit,
					Filename:  m.Fileset.Position(expr.Pos()).Filename,
				})

			}
		}
	case *ast.IndexExpr:
		m.AddBound(Feature{
			Name:      "Uses an item of a list as a " + bound,
			Mandatory: mandatory,
			Info:      "UNSUPPORTED",
			Fun:       m.Fun.Name.Name,
			Proj_name: m.Project_name,
			Line:      m.Fileset.Position(expr.Pos()).Line,
			Filename:  m.Fileset.Position(expr.Pos()).String(),
			Commit:    m.Commit,
		})

	case *ast.CompositeLit:
		m.AddBound(Feature{
			Name:      "List as a " + bound,
			Info:      fmt.Sprint(expr.Type),
			Mandatory: mandatory,
			Fun:       m.Fun.Name.Name,
			Proj_name: m.Project_name,
			Line:      m.Fileset.Position(expr.Pos()).Line,
			Filename:  m.Fileset.Position(expr.Pos()).String(),
			Commit:    m.Commit,
		})
	default:
		Types := m.AstMap[m.Package].TypesInfo.TypeOf(expr)
		if Types == nil {
			fmt.Println("Could not find type of expr : ", expr, "at pos : ", m.Fileset.Position(expr.Pos()))
		} else {
			switch Types := Types.(type) {
			case *types.Struct:
				// Struct as a bound
				m.AddBound(Feature{
					Proj_name: m.Project_name,
					Fun:       m.Fun.Name.String(),
					Name:      "Field of a struct as a " + bound,
					Mandatory: mandatory,
					Info:      "Name : " + prettyPrint(expr),
					Line:      m.Fileset.Position(expr.Pos()).Line,
					Commit:    m.Commit,
					Filename:  m.Fileset.Position(expr.Pos()).Filename,
				})

			case *types.Basic:

				if isConstant(expr) != "not found" {
					m.AddBound(Feature{
						Proj_name: m.Project_name,
						Fun:       m.Fun.Name.String(),
						Name:      "Integer as a " + bound,
						Mandatory: mandatory,
						Info:      isConstant(expr),
						Line:      m.Fileset.Position(expr.Pos()).Line,
						Commit:    m.Commit,
						Filename:  m.Fileset.Position(expr.Pos()).Filename,
					})
				} else {
					m.AddBound(Feature{
						Proj_name: m.Project_name,
						Fun:       m.Fun.Name.String(),
						Name:      "Var as a " + bound,
						Mandatory: mandatory,
						Info:      fmt.Sprint(expr),
						Line:      m.Fileset.Position(expr.Pos()).Line,
						Commit:    m.Commit,
						Filename:  m.Fileset.Position(expr.Pos()).Filename,
					})
				}

			case *types.Slice:
				m.AddBound(Feature{
					Proj_name: m.Project_name,
					Fun:       m.Fun.Name.String(),
					Name:      "Slice as a " + bound,
					Mandatory: mandatory,
					Info:      "Name : " + prettyPrint(expr),
					Line:      m.Fileset.Position(expr.Pos()).Line,
					Commit:    m.Commit,
					Filename:  m.Fileset.Position(expr.Pos()).Filename,
				})
			case *types.Map:
				m.AddBound(Feature{
					Proj_name: m.Project_name,
					Fun:       m.Fun.Name.String(),
					Name:      "Map as a " + bound,
					Mandatory: mandatory,
					Info:      "Name : " + Types.String(),
					Line:      m.Fileset.Position(expr.Pos()).Line,
					Commit:    m.Commit,
					Filename:  m.Fileset.Position(expr.Pos()).Filename,
				})
			case *types.Named:
				m.AddBound(Feature{
					Proj_name: m.Project_name,
					Fun:       m.Fun.Name.String(),
					Name:      "Var as a " + bound,
					Mandatory: mandatory,
					Info:      "Name : " + Types.String(),
					Line:      m.Fileset.Position(expr.Pos()).Line,
					Commit:    m.Commit,
					Filename:  m.Fileset.Position(expr.Pos()).Filename,
				})
			}
		}
	}
	if err == nil {
		return promela_ast.Ident{Name: ident.Print(0)}, nil
	}
	return promela_ast.Ident{Name: "null"}, err
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
		switch e := e.(type) {
		case *ast.SelectorExpr:
			if IdenticalExpr(&ast.Ident{Name: translateIdent(e.X).Name + "_" + e.Sel.Name}, expr) {
				return true
			}
		default:

			if IdenticalExpr(e, expr) {
				return true
			}
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
		if inline.Name.Name == m.getIdent(expr).Name {
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

func (m *Model) ContainsRecFunc(pkg string, name string) bool {

	for _, fun := range m.RecFuncs {
		if pkg == fun.Pkg && name == fun.Name {
			return true
		}
	}

	return false
}

func (m *Model) AddRecFunc(pkg string, name string) {
	m.RecFuncs = append(m.RecFuncs, RecFunc{Pkg: pkg, Name: name})
}

func (m *Model) notDefine(name string) bool {
	found := false

	for _, define := range m.Defines {
		if define.Name.Name == name {
			found = true
		}
	}
	return found
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
