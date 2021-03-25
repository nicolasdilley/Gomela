package promela

import (
	"go/ast"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

func (m *Model) translateExprStmt(s *ast.ExprStmt) (b *promela_ast.BlockStmt, defers *promela_ast.BlockStmt, err *ParseError) {
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	defers = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}

	expr, err1 := m.TranslateExpr(s.X)

	if err1 != nil {

		return b, defers, err1
	}
	addBlock(b, expr)
	return b, defers, err
}
