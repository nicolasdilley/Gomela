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

	goto_stmt := &promela_ast.GotoStmt{Label: &promela_ast.LabelStmt{Name: fmt.Sprintf("for%d%d_exit", m.For_counter.X, m.For_counter.Y)}}
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
				switch com := comm.Comm.(type) {
				case *ast.SendStmt: // send
					if m.containsChan(com.Chan) {
						chan_name := m.getChanStruct(com.Chan)

						async_send := &promela_ast.SendStmt{Chan: &promela_ast.SelectorExpr{X: chan_name.Name, Sel: &promela_ast.Ident{Name: "async_send"}}, Rhs: &promela_ast.Ident{Name: "0"}}

						sync_send := &promela_ast.SendStmt{Chan: &promela_ast.SelectorExpr{X: chan_name.Name, Sel: &promela_ast.Ident{Name: "sync"}}, Rhs: &promela_ast.Ident{Name: "false,0"}}
						m.checkForBreak(body, goto_stmt)
						async_guard := &promela_ast.GuardStmt{Cond: async_send, Guard: m.Fileset.Position(comm.Pos()), Body: body}
						sending_chan := &promela_ast.SelectorExpr{X: chan_name.Name, Sel: &promela_ast.Ident{Name: "sending"}}

						sync_guard := &promela_ast.GuardStmt{
							Cond: sync_send,
							Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{
								&promela_ast.RcvStmt{
									Chan: sending_chan,
									Rhs:  &promela_ast.Ident{Name: "state"}}}},
							Guard: m.Fileset.Position(s.Pos())}

						new_body, _ := m.UpdateLabels(body, nil)
						sync_guard.Body.List = append(sync_guard.Body.List, new_body.List...)

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
								guards, err = m.translateRcvStmt(com.X, body, goto_stmt)
								i.Guards = append(i.Guards, guards...)
							}
						case *ast.Ident:
							guards, err = m.translateRcvStmt(com, body, goto_stmt)
							i.Guards = append(i.Guards, guards...)
						case *ast.SelectorExpr:
							guards, err = m.translateRcvStmt(com, body, goto_stmt)
							i.Guards = append(i.Guards, guards...)
						}
					}
				case *ast.ExprStmt:
					switch com := com.X.(type) {
					case *ast.UnaryExpr:
						if com.Op == token.ARROW {
							var guards []*promela_ast.GuardStmt
							guards, err = m.translateRcvStmt(com.X, body, goto_stmt)
							i.Guards = append(i.Guards, guards...)
						}
					}
				}
				if err != nil {
					return b, defers, err
				}

			} else { // it is default
				i.Has_default = true
				i.Guards = append(i.Guards, &promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Guard: m.Fileset.Position(comm.Pos()), Body: body})
			}

		}
	}

	if len(i.Guards) > 0 {
		b.List = append(b.List, i)
	} else {
		return nil, nil, &ParseError{err: errors.New(SELECT_WITH_NO_BRANCH + m.Fileset.Position(s.Pos()).String())}

	}

	return b, defers, err
}