package promela

import (
	"errors"
	"go/ast"
	"go/types"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

func (m *Model) translateRcvStmt(
	e ast.Expr,
	body *promela_ast.BlockStmt,
	body2 *promela_ast.BlockStmt) (promela_ast.GuardStmt, error) {

	var guard promela_ast.GuardStmt

	var err error

	if m.containsChan(e) {
		chan_name := m.getChanStruct(e)

		guard = &GenRcvStmt{
			Rcv:        m.Props.Fileset.Position(e.Pos()),
			Chan:       chan_name.Name,
			M:          m.Props,
			Sync_body:  body,
			Async_body: body2,
		}

		return guard, err
	} else {

		if m.IsTimeAfter(e) {
			guard = &promela_ast.SingleGuardStmt{
				Cond: &promela_ast.Ident{Name: "true"},
				Body: body}
		} else {
			err = errors.New(UNKNOWN_RCV + m.Props.Fileset.Position(e.Pos()).String())
		}
	}

	return guard, err
}

func (m *Model) IsTimeAfter(e ast.Expr) bool {

	switch call := e.(type) {
	case *ast.SelectorExpr:
		// Checking if timeout.C channel and change it to a true branche
		if t := m.AstMap[m.Package].TypesInfo.TypeOf(call.X); t != nil {
			t = GetElemIfPointer(t)
			switch t := t.(type) {
			case *types.Named:
				if t.String() == "time.Ticker" || t.String() == "time.Timer" {

					return true
				}
			}
		}
	case *ast.CallExpr:
		switch sel := call.Fun.(type) {
		case *ast.SelectorExpr:
			switch ident := sel.X.(type) {
			case *ast.Ident:
				if ident.Name == "time" && sel.Sel.Name == "After" {
					return true
				}
			}

			if sel.Sel.Name == "Done" {
				// look if the type is context.Context
				isContext := false
				switch ident := sel.X.(type) {
				case *ast.Ident:
					if ident.Name == "ctx" {
						isContext = true
					}
				}

				t := m.AstMap[m.Package].TypesInfo.TypeOf(sel.X)

				if t != nil {
					switch u := t.(type) {
					case *types.Pointer:
						t = u.Elem()
					}
					switch t.(type) {
					case *types.Named:
						if t.String() == "context.Context" {
							isContext = true
						}
					}
				}
				return isContext
			}

		}
	}

	return false
}
