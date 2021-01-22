package promela

import (
	"errors"
	"go/ast"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

func (m *Model) translateIfStmt(s *ast.IfStmt) (b *promela_ast.BlockStmt, defers *promela_ast.BlockStmt, err *ParseError) {
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	defers = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	i := &promela_ast.IfStmt{If: m.Fileset.Position(s.Pos()), Init: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}

	stmts, defer_stmts, err1 := m.TranslateBlockStmt(&ast.BlockStmt{List: []ast.Stmt{s.Init}})

	if err1 != nil {
		err = err1
	}
	addBlock(b, stmts)
	addBlock(defers, defer_stmts)

	stmts1, err2 := m.TranslateExpr(s.Cond)

	if err2 != nil {
		err = err2
	}
	addBlock(b, stmts1)

	body, defer_stmts2, err1 := m.TranslateBlockStmt(s.Body)

	if len(defer_stmts2.List) > 0 {
		return b, defer_stmts, &ParseError{err: errors.New(DEFER_IN_IF + m.Fileset.Position(s.Pos()).String())}
	}
	if err1 != nil {
		err = err1
	}
	contains := false
	if len(body.List) != 0 {
		contains = true
		i.Guards = append(i.Guards, &promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: body})
	}

	if s.Else != nil {
		stmts := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
		switch els := s.Else.(type) {
		case *ast.BlockStmt:
			s1, defer_stmts3, err1 := m.TranslateBlockStmt(els)
			if len(defer_stmts3.List) > 0 {
				return b, defer_stmts, &ParseError{err: errors.New(DEFER_IN_IF + m.Fileset.Position(s.Pos()).String())}
			}
			if err1 != nil {
				err = err1
			}
			stmts = s1
		default:
			s1, defers, err1 := m.TranslateBlockStmt(&ast.BlockStmt{List: []ast.Stmt{s.Else}})
			if len(defers.List) > 0 {
				return b, defer_stmts, &ParseError{err: errors.New(DEFER_IN_IF + m.Fileset.Position(s.Pos()).String())}
			}
			if err1 != nil {
				err = err1
			}
			stmts = s1
		}
		if len(stmts.List) != 0 {
			contains = true
			i.Guards = append(i.Guards, &promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: stmts})
		}
	} else if contains {
		i.Guards = append(i.Guards, &promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: &promela_ast.BlockStmt{}})
	}

	if contains {
		b.List = append(b.List, i)
	}
	return b, defers, err
}
