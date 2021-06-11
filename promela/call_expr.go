package promela

import (
	"errors"
	"fmt"
	"go/ast"
	"path/filepath"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

// 1. Replace the name of the channel with the name we have in the body of the function
// 2. Create a process with a channel child to act as a return
// 3. Translate the body of the function to Promela.
// 4. Translate arguments that are communication parameters

func (m *Model) TranslateCallExpr(call_expr *ast.CallExpr) (stmts *promela_ast.BlockStmt, err *ParseError) {
	stmts = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}

	// if obj != nil {
	var func_name string // The corresponding promela function name consisting of package + fun + num of param
	var pack_name string = m.Package

	switch name := call_expr.Fun.(type) {
	case *ast.Ident:
		func_name = filepath.Base(pack_name) + name.Name
	case *ast.SelectorExpr:
		// Check if its a call a Waitgroup call (Add(x), Done or Wait)
		func_name = name.Sel.Name

		pack_name = getPackName(name).Name

		if m.isWaitgroup(&ast.Ident{Name: translateIdent(name.X).Name}) {
			return m.parseWgFunc(call_expr, name)
		}

	case *ast.FuncLit:
		panic("Promela_translator.go : Should not have a funclit here")
	}

	decl, new_call_expr, pack_name, err1 := m.findFunDecl(call_expr)

	if err1 != nil {
		return stmts, err1
	} else if decl != nil {
		func_name = decl.Name.Name + fmt.Sprint(m.Fileset.Position(decl.Pos()).Line)
		new_mod := m.newModel(pack_name, decl)

		new_mod.CommPars, err1 = new_mod.AnalyseCommParam(pack_name, decl, m.AstMap, false) // recover the commPar

		if err1 != nil {
			return stmts, err1
		}
		params, args, hasChan, known, err2 := m.translateParams(new_mod, decl, new_call_expr, false)

		// translate args
		if err2 != nil {
			return stmts, err2
		}
		if hasChan && known {
			return m.translateCommParams(new_mod, false, new_call_expr, func_name, decl, params, args, false)
		} else {
			switch name := new_call_expr.Fun.(type) {
			case *ast.SelectorExpr:
				switch ident := name.X.(type) {
				case *ast.Ident:
					if ident.Name == "signal" {
						if name.Sel.Name == "Notify" {

							// Send guard
							if m.containsChan(new_call_expr.Args[0]) {

								chan_name := m.getChanStruct(new_call_expr.Args[0])

								sync_send := &promela_ast.SendStmt{
									Chan: &promela_ast.SelectorExpr{
										X:   chan_name.Name,
										Sel: &promela_ast.Ident{Name: "sync"}},
									Rhs:  &promela_ast.Ident{Name: "false,0"},
									Send: m.Fileset.Position(new_call_expr.Pos())}
								async_send := &promela_ast.SendStmt{
									Chan: &promela_ast.SelectorExpr{
										X:   chan_name.Name,
										Sel: &promela_ast.Ident{Name: "enq"}},
									Rhs:  &promela_ast.Ident{Name: "0"},
									Send: m.Fileset.Position(new_call_expr.Pos())}

								sending_chan := &promela_ast.SelectorExpr{X: chan_name.Name, Sel: &promela_ast.Ident{Name: "sending"}}

								sync_guard := &promela_ast.GuardStmt{
									Cond: sync_send,
									Body: &promela_ast.BlockStmt{
										List: []promela_ast.Stmt{
											&promela_ast.SendStmt{
												Chan: sending_chan,
												Rhs:  &promela_ast.Ident{Name: "false"}},
											&promela_ast.Ident{Name: "break"},
										},
									},
									Guard: m.Fileset.Position(new_call_expr.Pos())}
								async_guard := &promela_ast.GuardStmt{Cond: async_send, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&promela_ast.Ident{Name: "break"}}}, Guard: m.Fileset.Position(new_call_expr.Pos())}

								// true guard
								true_guard := &promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&promela_ast.Ident{Name: "break"}}}}

								select_stmt := &promela_ast.SelectStmt{Guards: []*promela_ast.GuardStmt{async_guard, sync_guard, true_guard}, Select: m.Fileset.Position(name.Pos())}

								stmts.List = append(stmts.List, select_stmt)
							} else {
								return stmts, &ParseError{err: errors.New(UNKNOWN_NOTIFY + m.Fileset.Position(new_call_expr.Pos()).String())}
							}
						}
					}
				}

			}

			var stmts1 *promela_ast.BlockStmt
			stmts1, err = m.ParseFuncArgs(call_expr)
			if len(stmts1.List) > 0 {
				addBlock(stmts, stmts1)
			}
		}
	} else {
		var stmts1 *promela_ast.BlockStmt
		stmts1, err = m.ParseFuncArgs(call_expr)
		if len(stmts1.List) > 0 {
			addBlock(stmts, stmts1)
		}
	}

	return stmts, err
}

func (m *Model) ParseFuncArgs(call_expr *ast.CallExpr) (*promela_ast.BlockStmt, *ParseError) {

	stmts := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	for _, arg := range call_expr.Args {

		expr, e := m.TranslateExpr(arg)

		if e != nil {
			return stmts, e
		}
		stmts.List = append(stmts.List, expr.List...)
	}

	return stmts, nil
}

// take an ident or a selector expr and return the name of the ident or the X of selectorExpr
func getPackName(sel ast.Expr) *ast.Ident {
	var name *ast.Ident
	switch sel := sel.(type) {
	case *ast.Ident:
		name = sel
	case *ast.SelectorExpr:
		name = getPackName(sel.X)
	case *ast.CallExpr:
		name = getPackName(sel.Fun)
	case *ast.UnaryExpr:
		name = getPackName(sel.X)
	case *ast.StarExpr:
		name = getPackName(sel.X)
	case *ast.ParenExpr:
		name = getPackName(sel.X)
	case *ast.KeyValueExpr:
		name = getPackName(sel.Value)
	case *ast.TypeAssertExpr:
		name = getPackName(sel.X)
	case *ast.SliceExpr:
		name = getPackName(sel.X)
	case *ast.IndexExpr:
		name = getPackName(sel.X)
	case *ast.BinaryExpr:
		name = getPackName(sel.X)
	default:
		name = &ast.Ident{Name: "Unknown"}
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
			m.PrintFeature(Feature{
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
		stmts.List = append(stmts.List, &promela_ast.SendStmt{Chan: &promela_ast.Ident{Name: translateIdent(name.X).Name + ".update"}, Rhs: ub})

	} else if name.Sel.Name == "Done" {
		if m.For_counter.In_for {
			m.PrintFeature(Feature{
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
		stmts.List = append(stmts.List, &promela_ast.SendStmt{Chan: &promela_ast.Ident{Name: translateIdent(name.X).Name + ".update"}, Rhs: &promela_ast.Ident{Name: "-1"}})
	} else if name.Sel.Name == "Wait" {
		stmts.List = append(stmts.List, &promela_ast.RcvStmt{Chan: &promela_ast.Ident{Name: translateIdent(name.X).Name + ".wait"}, Rhs: &promela_ast.Ident{Name: "0"}})
	}

	return stmts, err
}
