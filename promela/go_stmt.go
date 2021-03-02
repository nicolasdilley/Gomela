package promela

import (
	"errors"
	"fmt"
	"strconv"

	"go/ast"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
	"github.com/nicolasdilley/gomela/promela/promela_types"
)

func (m *Model) TranslateGoStmt(s *ast.GoStmt, isMain bool) (b *promela_ast.BlockStmt, err *ParseError) {
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}

	var func_name string // The corresponding promela function name consisting of package + fun + num of param + len(proctypes)
	var pack_name string
	call_expr := s.Call

	// First generate list of params (ParamList) and arguments to the run stmt
	decl, pack, err1 := m.findFunDecl(s.Call)
	pack_name = pack

	if err1 != nil {
		return b, err1
	}

	if decl != nil {
		func_name = "go_" + decl.Name.Name
		prom_call := &promela_ast.CallExpr{Fun: &promela_ast.Ident{Name: func_name}, Call: m.Fileset.Position(call_expr.Pos())}

		hasChan := isMain
		known := isMain
		new_mod := m.newModel(pack_name, decl)
		new_mod.CommPars = new_mod.AnalyseCommParam(pack_name, decl, m.AstMap, false) // recover the commPar
		//. Create a define for each mandatory param

		proc := &promela_ast.Proctype{Name: &promela_ast.Ident{Name: func_name}, Pos: m.Fileset.Position(call_expr.Pos()), Active: false, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}
		proc.Params = []*promela_ast.Param{}

		counter := 0
		for _, field := range decl.Type.Params.List {
			for _, name := range field.Names {
				switch sel := field.Type.(type) {
				case *ast.ChanType:
					hasChan = true

					if m.containsChan(call_expr.Args[counter]) {
						proc.Params = append(proc.Params, &promela_ast.Param{Name: name.Name, Types: promela_types.Chandef})
						new_mod.Chans[name] = &ChanStruct{Name: &promela_ast.Ident{Name: name.Name}, Chan: m.Fileset.Position(name.Pos())}

						arg, _, err1 := m.TranslateArg(call_expr.Args[counter])
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
										wg := &WaitGroupStruct{Name: &promela_ast.Ident{Name: name.Name, Ident: m.Fileset.Position(name.Pos())}, Wait: m.Fileset.Position(name.Pos())}
										proc.Params = append(proc.Params, &promela_ast.Param{Name: name.Name, Types: promela_types.Wgdef})
										new_mod.WaitGroups[name] = wg
										arg, _, err1 := m.TranslateArg(call_expr.Args[counter])
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
									wg := &WaitGroupStruct{Name: &promela_ast.Ident{Name: name.Name, Ident: m.Fileset.Position(name.Pos())}, Wait: m.Fileset.Position(name.Pos())}
									proc.Params = append(proc.Params, &promela_ast.Param{Name: name.Name, Types: promela_types.Wgdef})
									new_mod.WaitGroups[name] = wg
									arg, _, err1 := m.TranslateArg(call_expr.Args[counter])
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
			for _, commPar := range new_mod.CommPars {
				if commPar.Candidate {
					proc.Body.List = append([]promela_ast.Stmt{&promela_ast.DeclStmt{Name: &promela_ast.Ident{Name: commPar.Name.Name}, Rhs: &promela_ast.Ident{Name: OPTIONAL_BOUND}, Types: promela_types.Int}}, proc.Body.List...)
				} else {
					proc.Params = append(proc.Params, &promela_ast.Param{Name: commPar.Name.Name, Types: promela_types.Int})

					arg, _, err1 := m.TranslateArg(call_expr.Args[commPar.Pos])
					if found, _ := ContainsCommParam(m.CommPars, &CommPar{Name: &ast.Ident{Name: TranslateIdent(call_expr.Args[commPar.Pos], m.Fileset).Name}}); found && err1 == nil {
						prom_call.Args = append(prom_call.Args, arg)
					} else { // the arguments passed as a commparam cannot be translated
						ident := &promela_ast.Ident{Name: "not_found_" + strconv.Itoa(m.Fileset.Position(call_expr.Args[commPar.Pos].Pos()).Line)}
						if commPar.Mandatory {
							m.Defines = append(m.Defines, promela_ast.DefineStmt{Name: ident, Rhs: &promela_ast.Ident{Name: DEFAULT_BOUND}})
						} else {
							m.Defines = append(m.Defines, promela_ast.DefineStmt{Name: ident, Rhs: &promela_ast.Ident{Name: OPTIONAL_BOUND}})
						}
						prom_call.Args = append(prom_call.Args, ident)
					}
				}
			}

			candidatesParams := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}

			if !m.CallExists(func_name) { // add the new proctype if the call doesnt exists yet

				m.Proctypes = append(m.Proctypes, proc)
				new_mod.Proctypes = append(new_mod.Proctypes, proc)
				for _, commPar := range new_mod.CommPars {

					name := "Actual Param"
					if commPar.Candidate {
						name = "Candidate Param"
						if commPar.Mandatory {
							def := m.GenerateDefine(commPar) // generate the define statement out of the commpar
							candidatesParams.List = append(candidatesParams.List, &promela_ast.DeclStmt{Name: &promela_ast.Ident{Name: commPar.Name.Name}, Rhs: &promela_ast.Ident{Name: def}, Types: promela_types.Int})
						} else {
							candidatesParams.List = append(candidatesParams.List, &promela_ast.DeclStmt{Name: &promela_ast.Ident{Name: commPar.Name.Name}, Rhs: &promela_ast.Ident{Name: OPTIONAL_BOUND}, Types: promela_types.Int})
						}
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
				stmt, defers, err1 := new_mod.TranslateBlockStmt(decl.Body)
				m.ContainsChan = new_mod.ContainsChan
				m.ContainsWg = new_mod.ContainsWg

				m.addNewProctypes(new_mod) // adding the new proctypes create in the new model

				if isMain {
					m.Chans = new_mod.Chans
					m.WaitGroups = new_mod.WaitGroups
				}

				if err1 != nil {
					err = err1
				}
				proc.Body.List = append(candidatesParams.List, stmt.List...)
				proc.Body.List = append(proc.Body.List, &promela_ast.LabelStmt{Name: "stop_process"})
				for i, j := 0, len(defers.List)-1; i < j; i, j = i+1, j-1 {
					defers.List[i], defers.List[j] = defers.List[j], defers.List[i]
				}
				proc.Body.List = append(proc.Body.List, defers.List...)

			}
			prom_call.Fun = &promela_ast.Ident{Name: func_name, Ident: m.Fileset.Position(call_expr.Pos())}

			r := &promela_ast.RunStmt{X: prom_call, Run: m.Fileset.Position(s.Pos())}

			b.List = append(b.List, r)
		}
	} else { // Could not find the decl of the function
		// So lets check if it takes a receive as an arg
		for _, arg := range call_expr.Args {

			stmt, err1 := m.TranslateExpr(arg)

			if err1 == nil {
				for _, e := range stmt.List {
					switch e := e.(type) {
					case *promela_ast.RcvStmt:

						b.List = append(b.List, e)
					}
				}
			} else {
				return b, err1
			}
		}
	}

	return b, err
}

func (m *Model) findFunDecl(call_expr *ast.CallExpr) (*ast.FuncDecl, string, *ParseError) {
	pack_name := m.Package

	switch name := call_expr.Fun.(type) {
	case *ast.FuncLit: // in the case we have an anonymous func call
		fun_decl := &ast.FuncDecl{Body: &ast.BlockStmt{List: []ast.Stmt{}}, Type: &ast.FuncType{Params: &ast.FieldList{List: []*ast.Field{}}}}
		func_name := fmt.Sprint("Anonymous", len(m.Proctypes))
		ident := &ast.Ident{Name: func_name, NamePos: name.Pos()}
		fun_decl.Name = ident
		fun_decl.Type = name.Type
		fun_decl.Body = name.Body
		chans, wgs := AnalyseFuncCall(m.Fileset, m.Fun, call_expr, m.AstMap[m.Package]) // Returns the channels that are declared before the call
		names := []*ast.Ident{}                                                         // the names of the chans
		for _, ch := range chans {
			if !containsExpr(call_expr.Args, ch) {
				chan_name := TranslateIdent(ch, m.Fileset)
				names = append(names, &ast.Ident{Name: chan_name.Name, NamePos: ch.Pos()})
				call_expr.Args = append(call_expr.Args, ch)
			}
		}
		if len(names) > 0 {
			fun_decl.Type.Params.List = append(fun_decl.Type.Params.List, &ast.Field{Names: names, Type: &ast.ChanType{Value: &ast.Ident{Name: "int"}}})
		}
		wg_names := []*ast.Ident{}

		var exprs []ast.Expr

		for _, arg := range call_expr.Args { // Remove the potential pointers
			switch arg := arg.(type) {
			case *ast.UnaryExpr:
				exprs = append(exprs, arg.X)
			default:
				exprs = append(exprs, arg)
			}
		}
		for _, wg := range wgs {
			if !containsExpr(exprs, wg) {
				wg_names = append(wg_names, &ast.Ident{Name: TranslateIdent(wg, m.Fileset).Name, NamePos: wg.Pos()})
				call_expr.Args = append(call_expr.Args, wg)
			}
		}

		if len(wg_names) > 0 {
			fun_decl.Type.Params.List = append(fun_decl.Type.Params.List, &ast.Field{
				Names: wg_names,
				Type: &ast.StarExpr{X: &ast.SelectorExpr{X: &ast.Ident{Name: "sync"},
					Sel: &ast.Ident{Name: "WaitGroup"}}}})
		}
		// Add all commParam as args
		field := &ast.Field{Names: []*ast.Ident{}, Type: &ast.Ident{Name: "int"}}
		for _, commPar := range m.CommPars {
			field.Names = append(field.Names, commPar.Name)
			call_expr.Args = append(call_expr.Args, commPar.Name)
		}

		if len(field.Names) > 0 {
			fun_decl.Type.Params.List = append(fun_decl.Type.Params.List, field)
		}

		return fun_decl, pack_name, nil

	default:
		fun := ""
		// Find the decl of the function
		switch name := call_expr.Fun.(type) {
		case *ast.Ident:
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
			fun = name.Sel.Name
		}

		if found, decl := m.FindDecl(pack_name, fun, len(call_expr.Args), m.AstMap); found {
			return decl, pack_name, nil
		} else { // The declaration of the function could not be found
			// If the goroutines takes one of our channel as input return an error
			// Otherwise check if the args are a receive on a channel
			for _, arg := range call_expr.Args {
				if m.containsChan(arg) || m.containsWaitgroup(arg) {
					return nil, pack_name, &ParseError{err: errors.New(UNKNOWN_GO_FUNC + fmt.Sprint(m.Fileset.Position(call_expr.Fun.Pos())))}
				}
			}

		}
	}
	return nil, pack_name, nil
}
