package promela

import (
	"errors"
	"go/ast"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

func (m *Model) translateAssignStmt(s *ast.AssignStmt) (b *promela_ast.BlockStmt, defers *promela_ast.BlockStmt, err *ParseError) {
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	defers = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	for _, spec := range s.Rhs {
		switch spec := spec.(type) {
		case *ast.FuncLit:
			return b, defers, &ParseError{err: errors.New(FUNC_DECLARED_AS_VAR + m.Fileset.Position(spec.Pos()).String())}
		}

		expr, err1 := m.TranslateExpr(spec)

		if err1 != nil {
			err = err1
		}
		addBlock(b, expr)
	}

	return b, defers, err
}
