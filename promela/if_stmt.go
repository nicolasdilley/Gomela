package promela

import (
	"errors"
	"go/ast"
	"go/token"
	"strconv"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

func (m *Model) translateIfStmt(s *ast.IfStmt) (b *promela_ast.BlockStmt, defers *promela_ast.BlockStmt, err error) {
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	defers = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	i := &promela_ast.IfStmt{If: m.Props.Fileset.Position(s.Pos()), Init: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}

	stmts, defer_stmts, err1 := m.TranslateBlockStmt(&ast.BlockStmt{List: []ast.Stmt{s.Init}})

	if err1 != nil {
		err = err1
	}
	addBlock(b, stmts)
	addBlock(defers, defer_stmts)

	// only model if statements if they are not used as recover
	if !(containsRecover(s.Init) && containsNotEqual(s.Cond)) {

		// Check if it is a if !closed{doSomething()}
		if isClosed, b1, err1 := m.isIfClosed(s); isClosed {
			return b1, defers, err1
		}

		stmts1, err2 := m.TranslateExpr(s.Cond)
		// add the condition if it contains comm param
		cond, contains_comm_param := m.translateIfCond(s.Cond)

		// if contains_comm_param add the cond to the modelled if statement

		var g promela_ast.Expr = &promela_ast.Ident{Name: "true"}
		if contains_comm_param {
			g = cond
		}

		if err2 != nil {
			err = err2
		}
		addBlock(b, stmts1)

		body, defer_stmts2, err1 := m.TranslateBlockStmt(s.Body)
		if err1 != nil {
			return b, defer_stmts, err1
		}
		if len(defer_stmts2.List) > 0 {
			return b, defer_stmts, errors.New(DEFER_IN_IF + m.Props.Fileset.Position(s.Pos()).String())
		}

		contains := false
		if len(body.List) != 0 {
			contains = true
			i.Guards = append(i.Guards, &promela_ast.SingleGuardStmt{Cond: g, Body: body})
		}

		if s.Else != nil {
			stmts := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
			switch els := s.Else.(type) {
			case *ast.BlockStmt:
				s1, defer_stmts3, err1 := m.TranslateBlockStmt(els)
				if len(defer_stmts3.List) > 0 {
					return b, defer_stmts, errors.New(DEFER_IN_IF + m.Props.Fileset.Position(s.Pos()).String())
				}
				if err1 != nil {
					err = err1
				}
				stmts = s1
			default:
				s1, defers, err1 := m.TranslateBlockStmt(&ast.BlockStmt{List: []ast.Stmt{s.Else}})
				if len(defers.List) > 0 {
					return b, defer_stmts, errors.New(DEFER_IN_IF + m.Props.Fileset.Position(s.Pos()).String())
				}
				if err1 != nil {
					err = err1
				}
				stmts = s1
			}
			if len(stmts.List) != 0 {
				contains = true

				if contains_comm_param {
					i.Guards = append(i.Guards, &promela_ast.SingleGuardStmt{Cond: &promela_ast.Ident{Name: "else"}, Body: stmts})
				} else {
					i.Guards = append(i.Guards, &promela_ast.SingleGuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: stmts})
				}
			}
		} else if contains && !contains_comm_param {
			i.Guards = append(i.Guards, &promela_ast.SingleGuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: &promela_ast.BlockStmt{}})
		} else if contains_comm_param {
			i.Guards = append(i.Guards, &promela_ast.SingleGuardStmt{Cond: &promela_ast.Ident{Name: "else"}, Body: &promela_ast.BlockStmt{}})
		}

		if contains {
			b.List = append(b.List, i)
		}
	}
	return b, defers, err
}

func (m *Model) isIfClosed(s *ast.IfStmt) (isClosed bool, b *promela_ast.BlockStmt, e error) {
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
			return isClosed, b1, errors.New(DEFER_IN_IF + m.Props.Fileset.Position(s.Pos()).String())
		}
		then_guard := &promela_ast.SingleGuardStmt{Cond: cond, Body: b1}
		else_guard := &promela_ast.SingleGuardStmt{Cond: &promela_ast.Ident{Name: "else"}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}

		if s.Else != nil {
			stmts := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
			switch els := s.Else.(type) {
			case *ast.BlockStmt:
				s1, defer_stmts3, err1 := m.TranslateBlockStmt(els)
				if len(defer_stmts3.List) > 0 {
					return isClosed, b, errors.New(DEFER_IN_IF + m.Props.Fileset.Position(s.Pos()).String())
				}
				if err1 != nil {
					return isClosed, b, err1
				}
				stmts = s1
			default:
				s1, defers, err1 := m.TranslateBlockStmt(&ast.BlockStmt{List: []ast.Stmt{s.Else}})
				if len(defers.List) > 0 {
					return isClosed, b, errors.New(DEFER_IN_IF + m.Props.Fileset.Position(s.Pos()).String())
				}
				if err1 != nil {
					return isClosed, b, err1
				}
				stmts = s1
			}
			if len(stmts.List) != 0 {
				else_guard = &promela_ast.SingleGuardStmt{Cond: &promela_ast.Ident{Name: "else"}, Body: stmts}
			}
		}
		b.List = append(b.List, &promela_ast.IfStmt{Guards: []promela_ast.GuardStmt{then_guard, else_guard}})
	}
	return
}

// traverse the ast and see that all are known (if leaf then either comm par or literal)

// then traverse again and translate

func (m *Model) translateIfCond(expr ast.Expr) (promela_ast.Expr, bool) {
	prom_expr := &promela_ast.BinaryExpr{}

	// ast.Inspect() etc
	switch expr := expr.(type) {
	case *ast.BinaryExpr:

		if m.IsExprKnown(expr) {
			lhs, ident := ContainsCommParam(m.CommPars, &CommPar{Name: &ast.Ident{Name: m.getIdent(expr.X).Name}})
			lit, err := strconv.Atoi(m.getIdent(expr.X).Name)

			var x string = ""

			if lhs {
				x = VAR_PREFIX + ident.Name.Name
			}

			if err == nil {
				lhs = true
				x = strconv.Itoa(lit)
			}

			rhs, ident2 := ContainsCommParam(m.CommPars, &CommPar{Name: &ast.Ident{Name: m.getIdent(expr.Y).Name}})

			lit, err = strconv.Atoi(m.getIdent(expr.Y).Name)

			var y string = ""
			if rhs {
				y = VAR_PREFIX + ident2.Name.Name
			}
			if err == nil {
				rhs = true
				y = strconv.Itoa(lit)
			}
			if lhs && rhs {
				return &promela_ast.BinaryExpr{Lhs: &promela_ast.Ident{Name: x}, Rhs: &promela_ast.Ident{Name: y}, Op: expr.Op.String()}, true
			}
		}
	}
	return prom_expr, false

}

func containsRecover(s ast.Stmt) bool {
	if s == nil {
		return false
	}
	contains := false
	ast.Inspect(s, func(n ast.Node) bool {
		switch s := n.(type) {
		case *ast.CallExpr:
			switch fun := s.Fun.(type) {
			case *ast.Ident:
				if fun.Name == "recover" {
					contains = true
				}
			}
		}
		return !contains
	})

	return contains
}

func containsNotEqual(e ast.Expr) bool {
	switch e := e.(type) {
	case *ast.BinaryExpr:
		if e.Op == token.NEQ {
			return true
		}
	}

	return false
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
