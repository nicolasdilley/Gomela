package promela

import (
	"errors"
	"fmt"
	"go/ast"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

func (m *Model) translateSwitchStmt(s *ast.SwitchStmt) (b *promela_ast.BlockStmt, defers *promela_ast.BlockStmt, err *ParseError) {
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	defers = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	i := &promela_ast.IfStmt{If: m.Fileset.Position(s.Pos()), Init: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}

	tag, err1 := m.TranslateExpr(s.Tag)
	if err1 != nil {
		err = err1
	}
	i.Init = tag

	init, d1, err1 := m.TranslateBlockStmt(&ast.BlockStmt{List: []ast.Stmt{s.Init}})

	if err1 != nil {
		err = err1
	}
	addBlock(i.Init, init)
	addBlock(defers, d1)

	for _, stmt := range s.Body.List {
		switch stmt := stmt.(type) {
		case *ast.CaseClause:
			for _, e := range stmt.List {

				expr, err1 := m.TranslateExpr(e)

				if err1 != nil {
					err = err1
				}
				addBlock(b, expr)
			}
			for _, stmt := range stmt.Body {
				switch stmt := stmt.(type) {
				case *ast.BlockStmt:
					body, d2, err1 := m.TranslateBlockStmt(stmt)

					if len(d2.List) > 0 {
						return b, d2, &ParseError{err: errors.New("Defer stmt in switch statement at pos : " + m.Fileset.Position(s.Pos()).String())}
					}
					if err1 != nil {
						err = err1
					}
					guard := &promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: body}
					i.Guards = append(i.Guards, guard)
				}
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
