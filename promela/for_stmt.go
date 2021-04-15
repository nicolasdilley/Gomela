package promela

import (
	"errors"
	"fmt"
	"go/ast"
	"strings"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

var (
	LABEL_COUNTER int = 0
)

func (m *Model) translateForStmt(s *ast.ForStmt) (b *promela_ast.BlockStmt, defers *promela_ast.BlockStmt, err *ParseError) {
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	defers = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}

	was_in_for := m.For_counter.In_for //used to check if this is the outer loop
	had_go := m.For_counter.With_go
	// update 'for' counter to generate the appropriate label
	m.For_counter.With_go = false

	if was_in_for {
		m.For_counter.Y += 1
	} else {
		m.For_counter.X += 1
	}

	cond, err1 := m.TranslateExpr(s.Cond)

	if err1 != nil {
		err = err1
	}
	addBlock(b, cond) // translating the condition in case there is a <-a
	init, d1, err1 := m.TranslateBlockStmt(&ast.BlockStmt{List: []ast.Stmt{s.Init}})
	if err1 != nil {
		err = err1
	}
	addBlock(b, init)
	addBlock(defers, d1)

	post, d2, err1 := m.TranslateBlockStmt(&ast.BlockStmt{List: []ast.Stmt{s.Post}})
	addBlock(b, post)
	addBlock(defers, d2)

	m.For_counter.In_for = true

	if err1 != nil {
		err = err1
	}

	stmts, for_label, d3, err1 := m.translateBodyOfForLoop(s.Body)

	m.For_counter.Y += 1
	// turns of the printing for the survey on the second translation of the body
	m.GenerateFeatures = false
	body2, for_label2, _, _ := m.translateBodyOfForLoop(s.Body)
	m.GenerateFeatures = true

	if err1 != nil {
		err = err1
	}
	if len(d3.List) > 0 {
		return b, d3, &ParseError{err: errors.New(DEFER_IN_FOR + m.Fileset.Position(s.Pos()).String())}
	}
	spawns := m.spawns(s.Body, false)
	if spawns || containsMSP(stmts) {

		lb, ub, err1 := m.lookUpFor(s, spawns, m.AstMap[m.Package])

		// Translated body of for loop
		if err1 != nil {
			err = err1
		}
		if spawns {

			// need to change the for loop into a bounded for loop
			b.List = append(b.List, &promela_ast.ForStmt{
				For:  m.Fileset.Position(s.Pos()),
				Lb:   lb,
				Ub:   ub,
				Body: stmts,
			}, for_label)

		} else if len(stmts.List) > 0 {
			d := &promela_ast.DoStmt{Do: m.Fileset.Position(s.Pos())}
			d.Guards = append(
				d.Guards,
				&promela_ast.GuardStmt{
					Cond: &promela_ast.Ident{Name: "true"},
					Body: stmts},
			)
			if s.Cond == nil && s.Post == nil && s.Init == nil {
				// infinite for loop
				// Dont add the if statement just the guard just translate it as an infinite for loop
				b.List = append(b.List, d, for_label)
			} else {
				// print the for loop  with the if
				if_stmt := promela_ast.IfStmt{If: m.Fileset.Position(s.Pos()), Init: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}

				lb_not_given := promela_ast.BinaryExpr{Lhs: lb, Rhs: &promela_ast.Ident{Name: OPTIONAL_BOUND}, Op: "!="}
				ub_not_given := promela_ast.BinaryExpr{Lhs: ub, Rhs: &promela_ast.Ident{Name: OPTIONAL_BOUND}, Op: "!="}

				if strings.Contains(lb.Name, "-1") {
					lb_not_given = promela_ast.BinaryExpr{Lhs: lb, Rhs: &promela_ast.Ident{Name: "-3"}, Op: "!="}
				}
				if strings.Contains(ub.Name, "-1") {
					ub_not_given = promela_ast.BinaryExpr{Lhs: ub, Rhs: &promela_ast.Ident{Name: "-3"}, Op: "!="}
				}

				then := &promela_ast.GuardStmt{
					Cond: &promela_ast.BinaryExpr{Lhs: &lb_not_given,
						Rhs: &ub_not_given, Op: "&&"},
					Body: &promela_ast.BlockStmt{
						List: []promela_ast.Stmt{
							&promela_ast.ForStmt{
								For:  m.Fileset.Position(s.Pos()),
								Lb:   lb,
								Ub:   ub,
								Body: body2,
							},
							for_label2}},
				}
				// the else part

				// adding the option to break of the for loop
				d.Guards = append(d.Guards, &promela_ast.GuardStmt{
					Cond: &promela_ast.Ident{Name: "true"},
					Body: &promela_ast.BlockStmt{
						List: []promela_ast.Stmt{&promela_ast.Ident{Name: "break"}}}})

				els := &promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "else"}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{d, for_label}}}

				if_stmt.Guards = []*promela_ast.GuardStmt{then, els}

				b.List = append(b.List, &if_stmt)
			}
		}

	}
	if !was_in_for { // if outer loop set in for to false and reset y
		m.For_counter.In_for = false
		m.For_counter.Y = 0
	} else {
		m.For_counter.In_for = true
	}

	m.For_counter.With_go = had_go

	return b, defers, err
}

func (m *Model) translateBodyOfForLoop(s *ast.BlockStmt) (*promela_ast.BlockStmt, *promela_ast.LabelStmt, *promela_ast.BlockStmt, *ParseError) {
	label_name := fmt.Sprintf("for%d%d", m.For_counter.X, m.For_counter.Y)
	for_label := &promela_ast.LabelStmt{Name: label_name + "_exit"}
	for_end_label2 := &promela_ast.LabelStmt{Name: label_name + "_end"}

	stmts, d, err := m.TranslateBlockStmt(s)
	body := &promela_ast.BlockStmt{List: append(
		[]promela_ast.Stmt{&promela_ast.LabelStmt{Name: label_name}},
		stmts.List...)}
	body.List = append(body.List, for_end_label2)

	return body, for_label, d, err
}
