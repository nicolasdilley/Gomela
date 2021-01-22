package promela

import (
	"go/ast"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

func (m *Model) translateDeclStmt(s *ast.DeclStmt) (b *promela_ast.BlockStmt, defers *promela_ast.BlockStmt, err *ParseError) {
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	defers = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	switch d := s.Decl.(type) {
	case *ast.FuncDecl:

	case *ast.GenDecl:
		for _, spec := range d.Specs {
			switch spec := spec.(type) {
			case *ast.ValueSpec:
				for _, val := range spec.Values {
					expr, err1 := m.TranslateExpr(val)
					if err1 != nil {
						err = err1
					}
					addBlock(b, expr)
				}
			}

		}
	}
	return b, defers, err
}
