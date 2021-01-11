package promela

import (
	"errors"
	"go/ast"
	"go/types"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

func (m *Model) translateRangeStmt(s *ast.RangeStmt) (b *promela_ast.BlockStmt, defers *promela_ast.BlockStmt, err *ParseError) {

	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	defers = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	d := &promela_ast.DoStmt{Do: m.Fileset.Position(s.Pos())}

	had_go := m.For_counter.With_go
	was_in_for := m.For_counter.In_for //used to check if this is the outer loop

	// update 'for' counter to generate the appropriate label
	if m.For_counter.In_for {
		m.For_counter.Y++
	} else {
		m.For_counter.X++
		m.For_counter.In_for = true
	}

	isChan := false
	switch m.AstMap[m.Package].TypesInfo.TypeOf(s.X).(type) {
	case *types.Chan:
		isChan = true
	}

	s1, for_label, d1, err1 := m.translateBodyOfForLoop(s.Body)

	if m.containsChan(s.X) {

		Features = append(Features, Feature{
			Proj_name: m.Project_name,
			Model:     m.Name,
			Fun:       m.Fun.Name.String(),
			Name:      "Range over Chan",
			Mandatory: "",
			Line:      0,
			Commit:    m.Commit,
			Filename:  m.Fileset.Position(s.X.Pos()).Filename,
		})
		chan_name := m.getChanStruct(s.X)

		do_guard := &promela_ast.GuardStmt{Cond: &promela_ast.RcvStmt{Chan: &promela_ast.Ident{Name: chan_name.Name.Name + ".is_closed"}, Rhs: &promela_ast.Ident{Name: "state"}}}
		if_closed_guard := &promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "state"}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&promela_ast.Ident{Name: "break"}}}}

		async_rcv := &promela_ast.RcvStmt{Chan: &promela_ast.SelectorExpr{X: chan_name.Name, Sel: &promela_ast.Ident{Name: "async_rcv"}}, Rhs: &promela_ast.Ident{Name: "0"}}

		sync_rcv := &promela_ast.RcvStmt{Chan: &promela_ast.SelectorExpr{X: chan_name.Name, Sel: &promela_ast.Ident{Name: "sync"}}, Rhs: &promela_ast.Ident{Name: "0"}}

		async_guard := &promela_ast.GuardStmt{Cond: async_rcv, Guard: m.Fileset.Position(s.Pos()), Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}

		sync_guard := &promela_ast.GuardStmt{
			Cond: sync_rcv,
			Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}},
		}
		i := &promela_ast.IfStmt{Guards: []*promela_ast.GuardStmt{async_guard, sync_guard}, Init: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}
		if_not_closed_guard := &promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "else"}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{i}}}

		if len(d1.List) > 0 {
			return b, d1, &ParseError{err: errors.New("Defer stmt in range statement at pos : " + m.Fileset.Position(s.Pos()).String())}
		}
		if err1 != nil {
			err = err1
		}

		if_not_closed_guard.Body.List = append(if_not_closed_guard.Body.List, s1.List...)
		do_guard.Body = &promela_ast.BlockStmt{List: []promela_ast.Stmt{&promela_ast.CondStmt{Guards: []*promela_ast.GuardStmt{if_closed_guard, if_not_closed_guard}}}}
		d.Guards = append(d.Guards, do_guard)
		b.List = append(b.List, d, for_label)

	} else if isChan {
		return b, b, &ParseError{err: errors.New("A range on a channel was found but could not parse channel : " + m.Fileset.Position(s.Pos()).String())}
	} else {

		// change into (for i:=0; i < len(x);i++)
		if err1 != nil {
			err = err1
		}

		ub, err1 := m.lookUp(s.X, RANGE_BOUND, m.spawns(s.Body, false))

		if err1 != nil {
			err = err1
		}
		if len(d1.List) > 0 {
			return b, d1, &ParseError{err: errors.New("Defer stmt in range statement at pos : " + m.Fileset.Position(s.Pos()).String())}
		}
		block_stmt := s1

		if m.spawns(s.Body, false) {
			// need to change the for loop into a bounded for loop
			b.List = append(b.List, &promela_ast.ForStmt{For: m.Fileset.Position(s.Pos()), Lb: &promela_ast.Ident{Name: "0"}, Ub: &promela_ast.Ident{Name: ub.Name + "-1"}, Body: block_stmt})
			b.List = append(b.List, for_label)
		} else if containsMSP(s1) {
			ub.Name += "-1"
			// generate the optionnal loop
			// print the for loop  with the if
			if_stmt := &promela_ast.IfStmt{If: m.Fileset.Position(s.Pos()), Init: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}

			ub_not_given := promela_ast.BinaryExpr{Lhs: ub, Rhs: &promela_ast.Ident{Name: "-3"}, Op: "!="}

			then := &promela_ast.GuardStmt{
				Cond: &ub_not_given,
				Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&promela_ast.ForStmt{For: m.Fileset.Position(s.Pos()), Lb: &promela_ast.Ident{Name: "0"}, Ub: ub, Body: block_stmt}, for_label}},
			}

			// else part

			body2, for_label2 := m.UpdateLabels(s1, for_label)

			break_branch := &promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&promela_ast.Ident{Name: "break"}}}}
			d.Guards = append(d.Guards,
				&promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: body2},
				break_branch,
			)

			els := &promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "else"}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{d, for_label2}}}

			if_stmt.Guards = []*promela_ast.GuardStmt{then, els}

			b.List = append(b.List, if_stmt)

		}
	}

	if !was_in_for { // if outer loop set in for to false and reset y
		m.For_counter.In_for = false
		m.For_counter.Y = 0
	}
	m.For_counter.With_go = false

	if had_go {
		m.For_counter.With_go = true
	}

	return b, defers, err
}
