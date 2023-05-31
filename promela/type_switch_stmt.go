package promela

import (
	"errors"
	"fmt"
	"go/ast"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

func (m *Model) translateTypeSwitchStmt(s *ast.TypeSwitchStmt) (b *promela_ast.BlockStmt, defers *promela_ast.BlockStmt, err error) {
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	defers = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	i := &promela_ast.IfStmt{If: m.Props.Fileset.Position(s.Pos()), Init: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}

	for _, stmt := range s.Body.List {
		switch c := stmt.(type) {
		case *ast.CaseClause:
			var body *promela_ast.BlockStmt
			var d2 *promela_ast.BlockStmt
			var err1 error

			if len(c.Body) > 0 {

				switch stmt := c.Body[0].(type) {

				case *ast.BlockStmt:
					body, d2, err1 = m.TranslateBlockStmt(stmt)

				default:
					body, d2, err1 = m.TranslateBlockStmt(&ast.BlockStmt{List: c.Body})

				}

				if len(d2.List) > 0 {
					return b, d2, errors.New(DEFER_IN_SWITCH + m.Props.Fileset.Position(s.Pos()).String())
				}
				if err1 != nil {
					return b, defers, err1
				}
				guard := &promela_ast.SingleGuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: body}
				i.Guards = append(i.Guards, guard)
			}
		default:
			fmt.Println("Promela_translator.go: in a switch and its not a case clause or a default")
		}
	}

	if len(i.Guards) > 0 {
		b.List = append(b.List, i)
	}
	return b, defers, err
}
