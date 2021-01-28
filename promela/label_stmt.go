package promela

import (
	"go/ast"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

func (m *Model) translateLabeledStmt(s *ast.LabeledStmt) (b *promela_ast.BlockStmt, defers *promela_ast.BlockStmt, err *ParseError) {
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	defers = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	label := &promela_ast.LabelStmt{Label: m.Fileset.Position(s.Pos()), Name: s.Label.Name}

	stmts, d1, err1 := m.TranslateBlockStmt(&ast.BlockStmt{List: []ast.Stmt{s.Stmt}})
	addBlock(defers, d1)
	if err1 != nil {
		err = err1
	}
	b.List = append(b.List, label, stmts)

	return b, defers, err
}