package promela

import (
	"errors"
	"fmt"
	"go/ast"
	"go/token"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

func (m *Model) translateSelectStmt(s *ast.SelectStmt) (b *promela_ast.BlockStmt, defers *promela_ast.BlockStmt, err *ParseError) {
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	defers = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	i := &promela_ast.SelectStmt{Select: m.Fileset.Position(s.Pos())}

	was_in_for := m.For_counter.In_for //used to check if this is the outer loop
	had_go := m.For_counter.With_go
	// update 'for' counter to generate the appropriate label
	m.For_counter.With_go = false

	if was_in_for {
		m.For_counter.Y += 1
	} else {
		m.For_counter.X += 1
	}

	defer func() {
		if !was_in_for { // if outer loop set in for to false and reset y
			m.For_counter.In_for = false
			m.For_counter.Y = 0
		} else {
			m.For_counter.In_for = true
		}

		m.For_counter.With_go = had_go

	}()
	goto_stmt := &promela_ast.GotoStmt{Label: &promela_ast.LabelStmt{Name: fmt.Sprintf("for%d%d_exit", m.For_counter.X, m.For_counter.Y)}}
	goto_end_stmt := &promela_ast.GotoStmt{Label: &promela_ast.LabelStmt{Name: fmt.Sprintf("for%d%d_end", m.For_counter.X, m.For_counter.Y)}}
	for _, comm := range s.Body.List {
		switch comm := comm.(type) {
		case *ast.CommClause: // can only be a commClause
			body, d1, err1 := m.TranslateBlockStmt(&ast.BlockStmt{List: comm.Body})

			if len(d1.List) > 0 {
				return b, d1, &ParseError{err: errors.New(DEFER_IN_SELECT + m.Fileset.Position(s.Pos()).String())}
			}
			if err1 != nil {
				return b, defers, err1
			}
			if comm.Comm != nil { // check if default select

				// turns of the printing for the survey on the second translation of the body
				m.GenerateFeatures = false
				body2, _, _ := m.TranslateBlockStmt(&ast.BlockStmt{List: comm.Body})
				m.GenerateFeatures = true
				switch com := comm.Comm.(type) {
				case *ast.SendStmt: // send
					if m.containsChan(com.Chan) {
						chan_name := m.getChanStruct(com.Chan)

						async_send := &promela_ast.SendStmt{
							Chan: &promela_ast.SelectorExpr{
								X:   chan_name.Name,
								Sel: &promela_ast.Ident{Name: "enq"},
							},
							Rhs: &promela_ast.Ident{Name: "0"}}

						sync_send := &promela_ast.SendStmt{
							Chan: &promela_ast.SelectorExpr{
								X:   chan_name.Name,
								Sel: &promela_ast.Ident{Name: "sync"},
							},
							Rhs: &promela_ast.Ident{Name: "false"}}
						m.checkForBreak(body, goto_stmt)
						async_guard := &promela_ast.GuardStmt{
							Cond:  async_send,
							Guard: m.Fileset.Position(comm.Pos()),
							Body:  body}
						sending_chan := &promela_ast.SelectorExpr{
							X:   chan_name.Name,
							Sel: &promela_ast.Ident{Name: "sending"}}

						m.checkForBreak(body2, goto_stmt)
						sync_guard := &promela_ast.GuardStmt{
							Cond: sync_send,
							Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{
								&promela_ast.SendStmt{
									Chan: sending_chan,
									Rhs:  &promela_ast.Ident{Name: "false"}}}},
							Guard: m.Fileset.Position(s.Pos())}

						sync_guard.Body.List = append(sync_guard.Body.List, body2.List...)

						i.Guards = append(i.Guards, async_guard, sync_guard)
					} else {

						err = &ParseError{err: errors.New(UNKNOWN_SEND + m.Fileset.Position(com.Chan.Pos()).String())}
						return b, defers, err
					}

				case *ast.AssignStmt: //receive
					for _, rh := range com.Rhs {
						var guards []*promela_ast.GuardStmt
						switch com := rh.(type) {
						case *ast.UnaryExpr:
							if com.Op == token.ARROW {
								guards, err = m.translateRcvStmt(com.X, body, body2, goto_stmt)
								i.Guards = append(i.Guards, guards...)
							}
						case *ast.Ident:
							guards, err = m.translateRcvStmt(com, body, body2, goto_stmt)
							i.Guards = append(i.Guards, guards...)
						case *ast.SelectorExpr:
							guards, err = m.translateRcvStmt(com, body, body2, goto_stmt)
							i.Guards = append(i.Guards, guards...)
						}
					}
				case *ast.ExprStmt:
					switch com := com.X.(type) {
					case *ast.UnaryExpr:
						if com.Op == token.ARROW {
							var guards []*promela_ast.GuardStmt
							guards, err = m.translateRcvStmt(com.X, body, body2, goto_stmt)
							i.Guards = append(i.Guards, guards...)
						}
					}
				}
				if err != nil {
					return b, defers, err
				}

			} else { // it is default
				i.Has_default = true
				m.checkForBreak(body, goto_stmt)
				i.Guards = append(i.Guards, &promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Guard: m.Fileset.Position(comm.Pos()), Body: body})
			}
		}
	}

	if len(i.Guards) > 0 {
		b.List = append(b.List, i, goto_stmt.Label, goto_end_stmt.Label)
	} else {
		return nil, nil, &ParseError{err: errors.New(SELECT_WITH_NO_BRANCH + m.Fileset.Position(s.Pos()).String())}

	}

	return b, defers, err
}
