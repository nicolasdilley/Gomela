package promela

import (
	"errors"
	"fmt"
	"go/ast"
	"go/token"
	"path/filepath"
	"strconv"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
	"github.com/nicolasdilley/gomela/promela/promela_types"
)

// 1. Replace the name of the channel with the name we have in the body of the function
// 2. Create a process with a channel child to act as a return
// 3. Translate the body of the function to Promela.
// 4. Translate arguments that are communication parameters

func (m *Model) TranslateCallExpr(call_expr *ast.CallExpr) (stmts *promela_ast.BlockStmt, err *ParseError) {
	stmts = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	// if obj != nil {
	var fun string       // The name of the function we are translating
	var func_name string // The corresponding promela function name consisting of package + fun + num of param
	var pack_name string = m.Package

	switch name := call_expr.Fun.(type) {
	case *ast.Ident:
		func_name = filepath.Base(pack_name) + name.Name
		fun = name.Name
	case *ast.SelectorExpr:
		// Check if its a call a Waitgroup call (Add(x), Done or Wait)
		func_name = name.Sel.Name
		fun = name.Sel.Name
		pack_name = getPackName(name)

		if m.containsWaitgroup(&ast.Ident{Name: translateIdent(name.X).Name}) {
			return m.parseWgFunc(call_expr, name)
		}
	case *ast.FuncLit:
		panic("Promela_translator.go : Should not have a funclit here")
	}

	if !m.ContainsRecFunc(pack_name, func_name) {
		if found, decl := m.FindDecl(pack_name, fun, len(call_expr.Args), m.AstMap); found {

			hasChan := false
			known := true                                      // Do we know all the channel that it might take as args ?? (if time.After() given as arg then we dont translate the call)
			var args []promela_ast.Expr = []promela_ast.Expr{} // building the new call's args
			new_chans := make(map[ast.Expr]*ChanStruct)
			new_wg := make(map[ast.Expr]*WaitGroupStruct)
			params := []*promela_ast.Param{}

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
										wg := &WaitGroupStruct{Name: &promela_ast.Ident{Name: name.Name, Ident: m.Fileset.Position(name.Pos())}, Wait: m.Fileset.Position(name.Pos())}

										params = append(params, &promela_ast.Param{Name: name.Name, Types: promela_types.Wgdef})
										new_wg[name] = wg
										if m.containsWaitgroup(call_expr.Args[x+y]) {
											arg, _, err1 := m.TranslateArg(call_expr.Args[x+y])
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
						ch := &ChanStruct{Name: &promela_ast.Ident{Name: name.Name, Ident: m.Fileset.Position(name.Pos())}, Chan: m.Fileset.Position(name.Pos())}
						params = append(params, &promela_ast.Param{Name: name.Name, Types: promela_types.Chandef})
						new_chans[name] = ch
						if m.getChanStruct(call_expr.Args[x+y]) != nil {
							arg, _, err1 := m.TranslateArg(call_expr.Args[x+y])
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
									wg := &WaitGroupStruct{Name: &promela_ast.Ident{Name: name.Name, Ident: m.Fileset.Position(name.Pos())}, Wait: m.Fileset.Position(name.Pos())}
									params = append(params, &promela_ast.Param{Name: name.Name, Types: promela_types.Wgdef})
									new_wg[name] = wg
									if m.containsWaitgroup(call_expr.Args[x+y]) {
										arg, _, err1 := m.TranslateArg(call_expr.Args[x+y])
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
				// Generate a new proctype to model the call
				proc := &promela_ast.Proctype{
					Name: &promela_ast.Ident{Name: func_name},
					Pos:  m.Fileset.Position(call_expr.Pos()), Active: false,
					Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}},
				}

				proc.Params = params
				// Translate the commPar of the function call ignoring the args that are not needed

				new_mod := m.newModel(pack_name, decl)
				new_mod.Chans = new_chans
				new_mod.WaitGroups = new_wg
				new_mod.CommPars = new_mod.AnalyseCommParam(pack_name, decl, m.AstMap, false) // recover the commPar
				candidatesParams := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}

				for _, commPar := range new_mod.CommPars {
					name := "Candidate Param"
					if !commPar.Candidate {
						name = "Actual Param"
						proc.Params = append(proc.Params, &promela_ast.Param{Name: commPar.Name.Name, Types: promela_types.Int})
						arg, _, err1 := m.TranslateArg(call_expr.Args[commPar.Pos])
						if err1 == nil {
							args = append(args, arg)
						} else { // the arguments passed as a commparam cannot be translated
							ident := &promela_ast.Ident{Name: "not_found_" + strconv.Itoa(m.Fileset.Position(call_expr.Args[commPar.Pos].Pos()).Line)}
							if commPar.Mandatory {
								m.Defines = append(m.Defines, promela_ast.DefineStmt{Name: ident, Rhs: &promela_ast.Ident{Name: DEFAULT_BOUND}})
							} else {
								m.Defines = append(m.Defines, promela_ast.DefineStmt{Name: ident, Rhs: &promela_ast.Ident{Name: OPTIONAL_BOUND}})
							}
							args = append(args, ident)
						}
					} else {
						// candidate param
						bound := ""
						if commPar.Mandatory {
							bound = DEFAULT_BOUND
						} else {
							bound = OPTIONAL_BOUND
						}
						candidatesParams.List = append(candidatesParams.List, &promela_ast.DeclStmt{Name: &promela_ast.Ident{Name: commPar.Name.Name}, Rhs: &promela_ast.Ident{Name: bound}, Types: promela_types.Int})
					}

					Features = append(Features, Feature{
						Proj_name: m.Project_name,
						Model:     m.Name,
						Fun:       new_mod.Fun.Name.String(),
						Name:      name,
						Mandatory: fmt.Sprint(commPar.Mandatory),
						Info:      commPar.Name.Name,
						Line:      0,
						Commit:    m.Commit,
						Filename:  m.Fileset.Position(m.Fun.Pos()).Filename,
					})
				}

				args = append(args, &promela_ast.Ident{Name: "child_" + func_name + strconv.Itoa(m.Counter)})
				// add child param
				proc.Params = append(proc.Params, &promela_ast.Param{Name: "child", Types: promela_types.Chan})

				// add child chan as arg to the call
				if !m.CallExists(func_name) {
					new_mod.Proctypes = append(new_mod.Proctypes, proc)

					s1, defers, err1 := new_mod.TranslateBlockStmt(decl.Body)
					m.ContainsChan = new_mod.ContainsChan
					m.ContainsWg = new_mod.ContainsWg
					m.addNewProctypes(new_mod) // adding the new proctypes create in the new model

					if err1 != nil {
						err = err1
					}
					proc.Body.List = append(candidatesParams.List, s1.List...)
					proc.Body.List = append(proc.Body.List, &promela_ast.LabelStmt{Name: "stop_process"})
					for i, j := 0, len(defers.List)-1; i < j; i, j = i+1, j-1 {
						defers.List[i], defers.List[j] = defers.List[j], defers.List[i]
					}
					proc.Body.List = append(proc.Body.List, defers.List...)
					proc.Body.List = append(proc.Body.List, &promela_ast.SendStmt{Chan: &promela_ast.Ident{Name: "child"}, Rhs: &promela_ast.Ident{Name: "0"}})
				}

				// add a call to it
				stmts.List = append(stmts.List,
					&promela_ast.Chandef{Name: &promela_ast.Ident{Name: "child_" + func_name + strconv.Itoa(m.Counter)}, Size: &promela_ast.Ident{Name: "0"}, Types: []promela_types.Types{promela_types.Int}},
					&promela_ast.RunStmt{X: &promela_ast.CallExpr{Fun: &promela_ast.Ident{Name: func_name}, Args: args}},
					&promela_ast.RcvStmt{Chan: &promela_ast.Ident{Name: "child_" + func_name + strconv.Itoa(m.Counter)}, Rhs: &promela_ast.Ident{Name: "0"}},
				)
				m.Counter++

				// }

			} else {

				switch name := call_expr.Fun.(type) {
				case *ast.SelectorExpr:
					switch ident := name.X.(type) {
					case *ast.Ident:
						if ident.Name == "signal" {
							if name.Sel.Name == "Notify" {

								// Send guard
								if m.containsChan(call_expr.Args[0]) {

									chan_name := m.getChanStruct(call_expr.Args[0])

									sync_send := &promela_ast.SendStmt{
										Chan: &promela_ast.SelectorExpr{
											X:   chan_name.Name,
											Sel: &promela_ast.Ident{Name: "sync"}},
										Rhs:  &promela_ast.Ident{Name: "false,0"},
										Send: m.Fileset.Position(call_expr.Pos())}
									async_send := &promela_ast.SendStmt{
										Chan: &promela_ast.SelectorExpr{
											X:   chan_name.Name,
											Sel: &promela_ast.Ident{Name: "async_send"}},
										Rhs:  &promela_ast.Ident{Name: "0"},
										Send: m.Fileset.Position(call_expr.Pos())}

									sending_chan := &promela_ast.SelectorExpr{X: chan_name.Name, Sel: &promela_ast.Ident{Name: "sending"}}

									sync_guard := &promela_ast.GuardStmt{
										Cond: sync_send,
										Body: &promela_ast.BlockStmt{
											List: []promela_ast.Stmt{
												&promela_ast.RcvStmt{
													Chan: sending_chan,
													Rhs:  &promela_ast.Ident{Name: "0"}},
												&promela_ast.Ident{Name: "break"},
											},
										},
										Guard: m.Fileset.Position(call_expr.Pos())}
									async_guard := &promela_ast.GuardStmt{Cond: async_send, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&promela_ast.Ident{Name: "break"}}}, Guard: m.Fileset.Position(call_expr.Pos())}

									// true guard
									true_guard := &promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&promela_ast.Ident{Name: "break"}}}}

									select_stmt := &promela_ast.SelectStmt{Guards: []*promela_ast.GuardStmt{async_guard, sync_guard, true_guard}, Select: m.Fileset.Position(name.Pos())}

									stmts.List = append(stmts.List, select_stmt)
								} else {
									return stmts, &ParseError{err: errors.New(UNKNOWN_NOTIFY + m.Fileset.Position(call_expr.Pos()).String())}
								}
							}
						}
					}

				}
				containsChan := false

				for _, arg := range call_expr.Args {
					if m.containsChan(arg) {
						containsChan = true
					} else if m.containsWaitgroup(arg) {
						containsChan = true
					}
				}

				if containsChan {
					err = &ParseError{err: errors.New(UNKNOWN_DECL + m.Fileset.Position(call_expr.Fun.Pos()).String())}
				} else {
					var stmts1 *promela_ast.BlockStmt
					stmts1, err = m.ParseFuncArgs(call_expr)
					addBlock(stmts, stmts1)
				}
			}
		} else {
			containsChan := false

			for _, arg := range call_expr.Args {
				if m.containsChan(arg) {
					containsChan = true
				} else if m.containsWaitgroup(arg) {
					containsChan = true
				}
			}

			if containsChan {
				err = &ParseError{err: errors.New(UNKNOWN_DECL + m.Fileset.Position(call_expr.Fun.Pos()).String())}
			} else {
				var stmts1 *promela_ast.BlockStmt
				stmts1, err = m.ParseFuncArgs(call_expr)
				addBlock(stmts, stmts1)
			}
		}
	} else {
		containsChan := false

		for _, arg := range call_expr.Args {
			if m.containsChan(arg) {
				containsChan = true
			} else if m.containsWaitgroup(arg) {
				containsChan = true
			}
		}

		if containsChan {
			err = &ParseError{err: errors.New(UNKNOWN_DECL + m.Fileset.Position(call_expr.Fun.Pos()).String())}
		} else {

			var stmts1 *promela_ast.BlockStmt
			stmts1, err = m.ParseFuncArgs(call_expr)
			addBlock(stmts, stmts1)
		}
	}

	return stmts, err
}

func (m *Model) ParseFuncArgs(call_expr *ast.CallExpr) (*promela_ast.BlockStmt, *ParseError) {

	stmts := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	for _, arg := range call_expr.Args {
		switch e := arg.(type) {
		case *ast.UnaryExpr:
			if e.Op == token.ARROW {

				if m.containsChan(e.X) {
					chan_name := m.getChanStruct(e.X)
					async_rcv := &promela_ast.RcvStmt{Chan: &promela_ast.SelectorExpr{X: chan_name.Name, Sel: &promela_ast.Ident{Name: "async_rcv"}}, Rhs: &promela_ast.Ident{Name: "state,num_msgs"}}

					sync_rcv := &promela_ast.RcvStmt{Chan: &promela_ast.SelectorExpr{X: chan_name.Name, Sel: &promela_ast.Ident{Name: "sync"}}, Rhs: &promela_ast.Ident{Name: "state,num_msgs"}}

					async_guard := &promela_ast.GuardStmt{Cond: async_rcv, Guard: m.Fileset.Position(arg.Pos()), Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}

					sync_guard := &promela_ast.GuardStmt{
						Cond: sync_rcv,
						Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}},
					}
					i := &promela_ast.IfStmt{Init: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}, Guards: []*promela_ast.GuardStmt{async_guard, sync_guard}}
					stmts.List = append(stmts.List, i)

				} else {
					return stmts, &ParseError{err: errors.New(UNKNOWN_ARG + m.Fileset.Position(call_expr.Pos()).String())}
				}
			}
		}
	}

	return stmts, nil
}

// take an ident or a selector expr and return the name of the ident or the X of selectorExpr
func getPackName(sel ast.Expr) string {
	name := ""
	switch sel := sel.(type) {
	case *ast.Ident:
		name = sel.Name
	case *ast.SelectorExpr:
		name = getPackName(sel.X)
	case *ast.CallExpr:
		name = getPackName(sel.Fun)
	}

	return name
}
func (m *Model) parseWgFunc(call_expr *ast.CallExpr, name *ast.SelectorExpr) (stmts *promela_ast.BlockStmt, err *ParseError) {
	stmts = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	if name.Sel.Name == "Add" {
		ub, err1 := m.lookUp(call_expr.Args[0], ADD_BOUND, m.For_counter.In_for)

		if err1 != nil {
			err = err1
		}

		if m.For_counter.In_for {
			Features = append(Features, Feature{
				Proj_name: m.Project_name,
				Model:     m.Name,
				Fun:       m.Fun.Name.String(),
				Name:      "Add in for",
				Mandatory: "true",
				Line:      m.Fileset.Position(name.Pos()).Line,
				Info:      "",
				Commit:    m.Commit,
				Filename:  m.Fileset.Position(name.Pos()).Filename,
			})
		}
		stmts.List = append(stmts.List, &promela_ast.SendStmt{Chan: &promela_ast.Ident{Name: translateIdent(name.X).Name + ".Add"}, Rhs: ub})

	}
	if name.Sel.Name == "Done" {
		if m.For_counter.In_for {
			Features = append(Features, Feature{
				Proj_name: m.Project_name,
				Model:     m.Name,
				Fun:       m.Fun.Name.String(),
				Name:      "Done in for",
				Mandatory: "false",
				Line:      m.Fileset.Position(name.Pos()).Line,
				Info:      "",
				Commit:    m.Commit,
				Filename:  m.Fileset.Position(name.Pos()).Filename,
			})
		}
		stmts.List = append(stmts.List, &promela_ast.SendStmt{Chan: &promela_ast.Ident{Name: translateIdent(name.X).Name + ".Add"}, Rhs: &promela_ast.Ident{Name: "-1"}})
	}
	if name.Sel.Name == "Wait" {
		stmts.List = append(stmts.List, &promela_ast.RcvStmt{Chan: &promela_ast.Ident{Name: translateIdent(name.X).Name + ".Wait"}, Rhs: &promela_ast.Ident{Name: "0"}})
	}

	return stmts, err
}
