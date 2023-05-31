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

func (m *Model) TranslateCallExpr(call_expr *ast.CallExpr) (stmts *promela_ast.BlockStmt, err error) {
	stmts = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}

	// if obj != nil {
	var func_name string // The corresponding promela function name consisting of package + fun + num of param
	var pack_name string = m.Package

	// first check if the call is not the launch of a goroutine

	if m.IsGoroutine(call_expr) {
		var err error
		var b *promela_ast.BlockStmt

		switch f := call_expr.Args[0].(type) {
		case *ast.FuncLit:
			b, err = m.TranslateGoStmt(&ast.GoStmt{Call: &ast.CallExpr{Fun: f, Args: []ast.Expr{}}}, false)
		case *ast.CallExpr:
			b, err = m.TranslateGoStmt(&ast.GoStmt{Call: f}, false)
		}

		if err != nil {
			fmt.Println(err)
		}
		addBlock(stmts, b)
		return stmts, nil
	}

	// It is not a goroutine call

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

		// Add here ifNotify() -> parseNotifyFunc()

	case *ast.FuncLit:
		panic("Promela_translator.go : Should not have a funclit here")
	}

	decl, new_call_expr, pack_name, err1 := m.findFunDecl(call_expr)

	if err1 != nil {
		return stmts, err1
	} else if decl != nil {
		for _, f := range m.RecFuncs {
			if decl.Name.Name == f.Name && m.Package == f.Pkg {
				// check if positions match
				if decl.Pos() == f.Decl.Pos() {
					return stmts, errors.New(RECURSIVE_FUNCTION + m.Props.Fileset.Position(decl.Pos()).String())
				}
			}
		}
		func_name = decl.Name.Name + fmt.Sprint(m.Props.Fileset.Position(decl.Pos()).Line)
		new_mod := m.newModel(pack_name, decl)
		new_mod.RecFuncs = append(new_mod.RecFuncs, RecFunc{Pkg: m.Package, Name: decl.Name.Name, Decl: decl})

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
							var guard promela_ast.GuardStmt

							guard, err = m.generateGenSendStmt(new_call_expr.Args[0],
								&promela_ast.BlockStmt{
									List: []promela_ast.Stmt{
										&promela_ast.Ident{Name: "break"},
									}},
								&promela_ast.BlockStmt{
									List: []promela_ast.Stmt{
										&promela_ast.Ident{Name: "break"},
									}})

							// true guard
							true_guard := &promela_ast.SingleGuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&promela_ast.Ident{Name: "break"}}}}

							select_stmt := &promela_ast.SelectStmt{
								Model:  "Notify",
								Guards: []promela_ast.GuardStmt{guard, true_guard},
								Select: m.Props.Fileset.Position(name.Pos())}

							stmts.List = append(stmts.List, select_stmt)
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

func (m *Model) ParseFuncArgs(call_expr *ast.CallExpr) (*promela_ast.BlockStmt, error) {

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

func (m *Model) IsGoroutine(expr *ast.CallExpr) bool {

	switch expr := expr.Fun.(type) {
	case *ast.Ident:
		for _, g := range m.Go_names {
			if expr.Name == g {
				return true
			}
		}
	default:
		return false
	}

	return false
}
