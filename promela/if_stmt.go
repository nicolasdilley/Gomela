package promela

import (
	"errors"
	"go/ast"
	"go/token"

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

	// Check if it is a if !closed{doSomething()}
	if isClosed, b1, err1 := m.isIfClosed(s); isClosed {
		return b1, defers, err1
	}

	stmts1, err2 := m.TranslateExpr(s.Cond)

	if err2 != nil {
		err = err2
	}
	addBlock(b, stmts1)

	body, defer_stmts2, err1 := m.TranslateBlockStmt(s.Body)
	if err1 != nil {
		return b, defer_stmts, err1
	}
	if len(defer_stmts2.List) > 0 {
		return b, defer_stmts, &ParseError{err: errors.New(DEFER_IN_IF + m.Fileset.Position(s.Pos()).String())}
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

func (m *Model) isIfClosed(s *ast.IfStmt) (isClosed bool, b *promela_ast.BlockStmt, e *ParseError) {
	isClosed = false
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	var cond promela_ast.Expr
	var found bool = false

	switch expr := s.Cond.(type) {
	case *ast.UnaryExpr:
		if expr.Op == token.NOT {
			if found = m.containsIsClosed(expr.X); found { // check if we have a if !ok {}
				cond = &promela_ast.Ident{Name: "state && num_msgs > 0"}
				isClosed = true
			}
		}
	case *ast.Ident: // check if we have a if ok {}
		if found = m.containsIsClosed(expr); found { // check if we have a if ok {}
			cond = &promela_ast.Ident{Name: "!(state && num_msgs > 0)"}
			isClosed = true
		}
	}

	// if state {}

	if isClosed {
		b1, d1, err1 := m.TranslateBlockStmt(s.Body)
		if err1 != nil {
			return isClosed, b1, err1
		}
		if len(d1.List) > 0 {
			return isClosed, b1, &ParseError{err: errors.New(DEFER_IN_IF + m.Fileset.Position(s.Pos()).String())}
		}
		then_guard := &promela_ast.GuardStmt{Cond: cond, Body: b1}
		else_guard := &promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "else"}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}

		if s.Else != nil {
			stmts := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
			switch els := s.Else.(type) {
			case *ast.BlockStmt:
				s1, defer_stmts3, err1 := m.TranslateBlockStmt(els)
				if len(defer_stmts3.List) > 0 {
					return isClosed, b, &ParseError{err: errors.New(DEFER_IN_IF + m.Fileset.Position(s.Pos()).String())}
				}
				if err1 != nil {
					return isClosed, b, err1
				}
				stmts = s1
			default:
				s1, defers, err1 := m.TranslateBlockStmt(&ast.BlockStmt{List: []ast.Stmt{s.Else}})
				if len(defers.List) > 0 {
					return isClosed, b, &ParseError{err: errors.New(DEFER_IN_IF + m.Fileset.Position(s.Pos()).String())}
				}
				if err1 != nil {
					return isClosed, b, err1
				}
				stmts = s1
			}
			if len(stmts.List) != 0 {
				else_guard = &promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "else"}, Body: stmts}
			}
		}
		b.List = append(b.List, &promela_ast.IfStmt{Guards: []*promela_ast.GuardStmt{then_guard, else_guard}})
	}
	return
}

func (m *Model) containsIsClosed(expr ast.Expr) bool {
	for _, exprs := range m.ClosedVars {
		for _, e := range exprs {
			if IdenticalExpr(expr, e) {
				return true
			}
		}
	}
	return false
}
