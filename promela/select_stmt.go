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
	i := &promela_ast.SelectStmt{Select: m.Fileset.Position(s.Pos()), Model: "Select"}

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

				m.checkForBreak(body, goto_stmt)

				m.checkForBreak(body2, goto_stmt)

				switch com := comm.Comm.(type) {
				case *ast.SendStmt: // send
					if m.containsChan(com.Chan) {

						chan_name := m.getChanStruct(com.Chan)

						gen_send := &GenSendStmt{
							Send:       m.Fileset.Position(s.Pos()),
							Chan:       chan_name.Name,
							M:          m,
							Sync_body:  body,
							Async_body: body2,
						}
						i.Guards = append(i.Guards, gen_send)
					} else {

						err = &ParseError{err: errors.New(UNKNOWN_SEND + m.Fileset.Position(com.Chan.Pos()).String())}
						return b, defers, err
					}

				case *ast.AssignStmt: //receive
					for _, rh := range com.Rhs {
						var guard promela_ast.GuardStmt
						switch com := rh.(type) {
						case *ast.UnaryExpr:
							if com.Op == token.ARROW {
								guard, err = m.translateRcvStmt(com.X, body, body2)
								i.Guards = append(i.Guards, guard)
							}
						case *ast.Ident:
							guard, err = m.translateRcvStmt(com, body, body2)
							i.Guards = append(i.Guards, guard)
						case *ast.SelectorExpr:
							guard, err = m.translateRcvStmt(com, body, body2)
							i.Guards = append(i.Guards, guard)
						}
					}
				case *ast.ExprStmt:
					switch com := com.X.(type) {
					case *ast.UnaryExpr:
						if com.Op == token.ARROW {
							var guard promela_ast.GuardStmt
							guard, err = m.translateRcvStmt(com.X, body, body2)
							i.Guards = append(i.Guards, guard)
						}
					}
				}
				if err != nil {
					return b, defers, err
				}

			} else { // it is default
				i.Has_default = true
				m.checkForBreak(body, goto_stmt)
				i.Guards = append(i.Guards, &promela_ast.SingleGuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Guard: m.Fileset.Position(comm.Pos()), Body: body})
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
