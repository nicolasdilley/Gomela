package promela

import (
	"errors"
	"go/ast"
	"go/types"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
	"github.com/nicolasdilley/gomela/promela/promela_types"
)

// take a go block stmt and returns its promela counterpart
func (m *Model) TranslateBlockStmt(b *ast.BlockStmt) (block_stmt *promela_ast.BlockStmt, defer_stmts *promela_ast.BlockStmt, err *ParseError) {

	block_stmt = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	defer_stmts = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
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
					var defers *promela_ast.BlockStmt = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
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

																prom_wg_name := &promela_ast.Ident{Name: translateIdent(l).Name + "_" + s.Field(i).Name(), Ident: m.Fileset.Position(l.Pos())}
																if !m.containsWaitgroup(wg_name) {
																	m.ContainsWg = true
																	m.WaitGroups[wg_name] = &WaitGroupStruct{
																		Name:    prom_wg_name,
																		Wait:    m.Fileset.Position(l.Pos()),
																		Counter: 0,
																	}

																	Features = append(Features, Feature{
																		Proj_name: m.Project_name,
																		Model:     m.Name,
																		Fun:       m.Fun.Name.String(),
																		Name:      "new WaitGroup",
																		Info:      "Name :" + prom_wg_name.Name,
																		Mandatory: "false",
																		Line:      m.Fileset.Position(l.Pos()).Line,
																		Commit:    m.Commit,
																		Filename:  m.Fileset.Position(l.Pos()).Filename,
																	})

																	block_stmt.List = append(block_stmt.List,
																		&promela_ast.DeclStmt{Name: prom_wg_name, Types: promela_types.Wgdef},
																		&promela_ast.RunStmt{X: &promela_ast.CallExpr{Fun: &promela_ast.Ident{Name: "wgMonitor"}, Args: []promela_ast.Expr{prom_wg_name}}})
																}
															} else {
																Features = append(Features, Feature{
																	Proj_name: m.Project_name,
																	Model:     m.Name,
																	Fun:       m.Fun.Name.String(),
																	Name:      "WaitGroup in for",
																	Mandatory: "false",
																	Line:      m.Fileset.Position(stmt.Pos()).Line,
																	Commit:    m.Commit,
																	Filename:  m.Fileset.Position(stmt.Pos()).Filename,
																})

																err = &ParseError{err: errors.New(WAITGROUP_IN_FOR + m.Fileset.Position(stmt.Pos()).String())}
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
												Features = append(Features, Feature{
													Proj_name: m.Project_name,
													Model:     m.Name,
													Fun:       m.Fun.Name.String(),
													Name:      "Chan in for",
													Mandatory: "false",
													Line:      m.Fileset.Position(ident.Pos()).Line,
													Commit:    m.Commit,
													Filename:  m.Fileset.Position(ident.Pos()).Filename,
												})
												err = &ParseError{err: errors.New(CHAN_IN_FOR + m.Fileset.Position(stmt.Pos()).String())}
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
															Features = append(Features, Feature{
																Proj_name: m.Project_name,
																Model:     m.Name,
																Fun:       m.Fun.Name.String(),
																Name:      "Chan in for",
																Mandatory: "false",
																Line:      m.Fileset.Position(ident.Pos()).Line,
																Commit:    m.Commit,
																Filename:  m.Fileset.Position(ident.Pos()).Filename,
															})
															err = &ParseError{err: errors.New(CHAN_IN_FOR + m.Fileset.Position(stmt.Pos()).String())}

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
														prom_wg_name := &promela_ast.Ident{Name: translateIdent(name).Name, Ident: m.Fileset.Position(name.Pos())}
														if !m.containsWaitgroup(name) {
															m.WaitGroups[name] = &WaitGroupStruct{
																Name:    prom_wg_name,
																Wait:    m.Fileset.Position(stmt.Pos()),
																Counter: 0,
															}
															m.ContainsWg = true

															Features = append(Features, Feature{
																Proj_name: m.Project_name,
																Model:     m.Name,
																Fun:       m.Fun.Name.String(),
																Name:      "new WaitGroup",
																Info:      "Name :" + prom_wg_name.Name,
																Mandatory: "false",
																Line:      m.Fileset.Position(stmt.Pos()).Line,
																Commit:    m.Commit,
																Filename:  m.Fileset.Position(stmt.Pos()).Filename,
															})

															block_stmt.List = append(block_stmt.List,
																&promela_ast.DeclStmt{Name: prom_wg_name, Types: promela_types.Wgdef},
																&promela_ast.RunStmt{X: &promela_ast.CallExpr{Fun: &promela_ast.Ident{Name: "wgMonitor"}, Args: []promela_ast.Expr{prom_wg_name}}})
														}
													} else {
														Features = append(Features, Feature{
															Proj_name: m.Project_name,
															Model:     m.Name,
															Fun:       m.Fun.Name.String(),
															Name:      "WaitGroup in for",
															Mandatory: "false",
															Line:      m.Fileset.Position(stmt.Pos()).Line,
															Commit:    m.Commit,
															Filename:  m.Fileset.Position(stmt.Pos()).Filename,
														})
														err = &ParseError{err: errors.New(WAITGROUP_IN_FOR + m.Fileset.Position(stmt.Pos()).String())}
													}
												}
											}
										}
									}
								}
							}
						}
						s1, defers, err1 = m.translateAssignStmt(stmt)

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
															err = &ParseError{err: errors.New(CHAN_IN_FOR + m.Fileset.Position(stmt.Pos()).String())}

															Features = append(Features, Feature{
																Proj_name: m.Project_name,
																Model:     m.Name,
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
									var expr ast.Expr = spec.Type
									// check if its the declaration of a WG
									switch sel := spec.Type.(type) {
									case *ast.StarExpr:
										expr = sel.X
									}
									switch sel := expr.(type) {
									case *ast.SelectorExpr:
										if sel.Sel.Name == "WaitGroup" {
											switch sel := sel.X.(type) {
											case *ast.Ident:
												if sel.Name == "sync" {
													// we have a waitgroup

													if !m.For_counter.In_for {
														for _, name := range spec.Names {
															prom_wg_name := &promela_ast.Ident{Name: name.Name, Ident: m.Fileset.Position(name.Pos())}
															if !m.containsWaitgroup(name) {
																m.ContainsWg = true
																m.WaitGroups[name] = &WaitGroupStruct{
																	Name:    prom_wg_name,
																	Wait:    m.Fileset.Position(spec.Pos()),
																	Counter: 0,
																}

																Features = append(Features, Feature{
																	Proj_name: m.Project_name,
																	Model:     m.Name,
																	Fun:       m.Fun.Name.String(),
																	Name:      "new WaitGroup",
																	Info:      "Name :" + prom_wg_name.Name,
																	Mandatory: "false",
																	Line:      m.Fileset.Position(spec.Pos()).Line,
																	Commit:    m.Commit,
																	Filename:  m.Fileset.Position(spec.Pos()).Filename,
																})

																block_stmt.List = append(block_stmt.List,
																	&promela_ast.DeclStmt{Name: prom_wg_name, Types: promela_types.Wgdef},
																	&promela_ast.RunStmt{X: &promela_ast.CallExpr{Fun: &promela_ast.Ident{Name: "wgMonitor"}, Args: []promela_ast.Expr{prom_wg_name}}})
															}
														}
													} else {
														Features = append(Features, Feature{
															Proj_name: m.Project_name,
															Model:     m.Name,
															Fun:       m.Fun.Name.String(),
															Name:      "WaitGroup in for",
															Mandatory: "false",
															Line:      m.Fileset.Position(sel.Pos()).Line,
															Commit:    m.Commit,
															Filename:  m.Fileset.Position(sel.Pos()).Filename,
														})
														err = &ParseError{err: errors.New(WAITGROUP_IN_FOR + m.Fileset.Position(stmt.Pos()).String())}
													}
												}
											}
										}
									}
								}
							}
						}
						s1, defers, err1 = m.translateDeclStmt(stmt)
					case *ast.SendStmt:
						s1, defers, err1 = m.translateSendStmt(stmt)
					case *ast.GoStmt:
						s1, defers, err1 = m.TranslateGoStmt(stmt)
					case *ast.ReturnStmt:
						s1, defers, err1 = m.translateReturnStmt(stmt)
					case *ast.ExprStmt:
						s1, defers, err1 = m.translateExprStmt(stmt)
					case *ast.LabeledStmt:
						s1, defers, err1 = m.translateLabeledStmt(stmt)
					case *ast.ForStmt:
						s1, defers, err1 = m.translateForStmt(stmt)
					case *ast.RangeStmt:
						s1, defers, err1 = m.translateRangeStmt(stmt)
					case *ast.SelectStmt:
						s1, defers, err1 = m.translateSelectStmt(stmt)
					case *ast.SwitchStmt:
						s1, defers, err1 = m.translateSwitchStmt(stmt)
					case *ast.BranchStmt:
						s1, defers, err1 = m.translateBranchStmt(stmt)
					case *ast.IfStmt:
						s1, defers, err1 = m.translateIfStmt(stmt)
					}

					if err1 != nil {
						err = err1
					} else {
						addBlock(block_stmt, s1)
						addBlock(defer_stmts, defers)
					}
				}
			}
		}
	}

	return block_stmt, defer_stmts, err
}
