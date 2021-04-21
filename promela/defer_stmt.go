package promela

import (
	"go/ast"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

func (m *Model) translateDeferStmt(s *ast.DeferStmt) (*promela_ast.BlockStmt, *ParseError) {
	s1, err := m.TranslateExpr(s.Call)
	if err != nil {
		return s1, err
	}
	if containsMSP(s1) {
		return s1, err
	} else {
		return &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}, nil
	}

}
