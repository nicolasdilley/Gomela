package promela

import (
	"errors"
	"go/ast"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

func (m *Model) translateSendStmt(s *ast.SendStmt) (b *promela_ast.BlockStmt, err *ParseError) {
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}

	if m.containsChan(s.Chan) {
		chan_name := m.getChanStruct(s.Chan)

		sync_send := &promela_ast.SendStmt{
			Chan: &promela_ast.SelectorExpr{
				X:   chan_name.Name,
				Sel: &promela_ast.Ident{Name: "sync"}},
			Rhs: &promela_ast.Ident{Name: "false"}, // the channel is not closed
			//Send: m.Fileset.Position(s.Pos())
		}
		async_send := &promela_ast.RcvStmt{
			Chan: &promela_ast.SelectorExpr{
				X:   chan_name.Name,
				Sel: &promela_ast.Ident{Name: "enq"}},
			Rhs: &promela_ast.Ident{Name: "ok"},
			//Send: m.Fileset.Position(s.Pos())
		}

		assert := &promela_ast.AssertStmt{Model: "Send", Pos: m.Fileset.Position(s.Pos()), Expr: &promela_ast.Ident{Name: "ok"}}

		sending_chan := &promela_ast.SelectorExpr{X: chan_name.Name, Sel: &promela_ast.Ident{Name: "sending"}}

		sync_guard := &promela_ast.GuardStmt{
			Cond: sync_send,
			Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{
				&promela_ast.RcvStmt{
					Chan: sending_chan,
					Rhs:  &promela_ast.Ident{Name: "ok"}},
				assert}},
			Guard: m.Fileset.Position(s.Pos())}
		async_guard := &promela_ast.GuardStmt{Cond: async_send, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{assert}}, Guard: m.Fileset.Position(s.Pos())}
		if_stmt := &promela_ast.IfStmt{
			If:    m.Fileset.Position(s.Pos()),
			Model: "Send",
			Init: &promela_ast.BlockStmt{
				List: []promela_ast.Stmt{},
			},
			Guards: []*promela_ast.GuardStmt{async_guard, sync_guard},
		}
		expr, err1 := m.TranslateExpr(s.Value)
		if err1 != nil {
			err = err1
		}
		addBlock(b, expr)

		b.List = append(b.List, if_stmt)
	} else {
		err = &ParseError{err: errors.New(UNKNOWN_SEND + m.Fileset.Position(s.Pos()).String())}
	}

	return b, err

}
