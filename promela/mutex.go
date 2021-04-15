package promela

import (
	"errors"
	"go/ast"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

func (m *Model) TranslateMutexOp(call_expr *ast.CallExpr) (b *promela_ast.BlockStmt, err *ParseError) {
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	switch name := call_expr.Fun.(type) {
	case *ast.SelectorExpr:
		chan_to_use := "Lock"
		switch name.Sel.Name {
		case "Lock", "RLock", "Unlock", "RUnlock":
			chan_to_use = name.Sel.Name
		default:
			return nil, &ParseError{err: errors.New(UNKNOWN_MUTEX_OP + m.Fileset.Position(call_expr.Pos()).String())}
		}

		if m.containsMutex(name.X) {

			b.List = append(b.List,
				&promela_ast.SendStmt{
					Chan: &promela_ast.SelectorExpr{
						X: &promela_ast.Ident{
							Name: translateIdent(name.X).Name},
						Sel: &promela_ast.Ident{Name: chan_to_use}},
					Rhs: &promela_ast.Ident{Name: "false"},
				})
		} else {
			return nil, &ParseError{err: errors.New(UNKNOWN_MUTEX + m.Fileset.Position(call_expr.Pos()).String())}
		}
	default:
		return nil, &ParseError{err: errors.New(MUTEX_OP_ON_NON_SEL + m.Fileset.Position(call_expr.Pos()).String())}
	}

	return b, nil
}

func (m *Model) containsMutex(expr ast.Expr) bool {
	for _, e := range m.Mutexes {
		if IdenticalExpr(&ast.Ident{Name: translateIdent(e).Name}, &ast.Ident{Name: translateIdent(expr).Name}) {
			return true
		}
		if isSubsetOfExpr(expr, e) {
			return true
		}
	}
	return false
}

func (m *Model) isMutex(expr ast.Expr) bool {
	for _, e := range m.Mutexes {
		if IdenticalExpr(&ast.Ident{Name: translateIdent(e).Name}, &ast.Ident{Name: translateIdent(expr).Name}) {
			return true
		}
	}
	return false
}
