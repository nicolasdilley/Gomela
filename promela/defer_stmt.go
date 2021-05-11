package promela

import (
	"go/ast"
	"strconv"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

func (m *Model) translateDeferStmt(s *ast.DeferStmt) (*promela_ast.BlockStmt, *ParseError) {
	s1, err := m.TranslateExpr(s.Call)
	if err != nil {
		return s1, err
	}
	if containsMSP(s1) {
		m.defer_counter++
		m.Current_return_label = "defer" + strconv.Itoa(m.defer_counter)
		return s1, err
	} else {
		return &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}, nil
	}

}
