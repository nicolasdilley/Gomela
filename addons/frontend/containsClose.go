package frontend

import (
	"go/ast"

	"github.com/nicolasdilley/gomela/promela"
)

func ContainsClose(fun *ast.FuncDecl) bool {
	for _, s := range fun.Body.List {

		isClose := false

		ast.Inspect(fun.Body, func(s ast.Node) bool {

			switch call := s.(type) {
			case *ast.CallExpr:
				// is it a close ?
				if isClose(s) {
					isClose = true
					return false
				}

				// check if contains commPar as param
				switch name := call_expr.Fun.(type) {
				case *ast.Ident:
					func_name = filepath.Base(pack_name) + name.Name
				case *ast.SelectorExpr:
					// Check if its a call a Waitgroup call (Add(x), Done or Wait)
					func_name = name.Sel.Name

					pack_name = getPackName(name).Name

					if m.isWaitgroup(&ast.Ident{Name: translateIdent(name.X).Name}) {
						return false
					}

					// Add here ifNotify() -> parseNotifyFunc()

				case *ast.FuncLit:
					panic("Promela_translator.go : Should not have a funclit here")
				}
			}
		})
	}

	return isClose
}

func isClose(call *ast.CallExpr) bool {
	switch call := call.Fun.Name.(type) {
	case *ast.Ident:
		if call.Name == "close" {
			if len(call.Args) == 1 {
				return true
			}
		}
	}
	return false
}
