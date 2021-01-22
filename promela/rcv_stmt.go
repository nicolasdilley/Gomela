package promela

import (
	"errors"
	"go/ast"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

func (m *Model) translateRcvStmt(e ast.Expr, body *promela_ast.BlockStmt, g *promela_ast.GotoStmt) ([]*promela_ast.GuardStmt, *ParseError) {
	guards := []*promela_ast.GuardStmt{}
	var err *ParseError

	if m.containsChan(e) {
		chan_name := m.getChanStruct(e)
		async_rcv := &promela_ast.RcvStmt{Chan: &promela_ast.SelectorExpr{X: chan_name.Name, Sel: &promela_ast.Ident{Name: "async_rcv"}}, Rhs: &promela_ast.Ident{Name: "state,num_msgs"}}

		sync_rcv := &promela_ast.RcvStmt{Chan: &promela_ast.SelectorExpr{X: chan_name.Name, Sel: &promela_ast.Ident{Name: "sync"}}, Rhs: &promela_ast.Ident{Name: "state,num_msgs"}}
		m.checkForBreak(body, g)
		async_guard := &promela_ast.GuardStmt{Cond: async_rcv, Guard: m.Fileset.Position(e.Pos()), Body: body}

		body_bis, _ := m.UpdateLabels(body, nil)
		sync_guard := &promela_ast.GuardStmt{
			Cond: sync_rcv,
			Body: body_bis,
		}
		guards = []*promela_ast.GuardStmt{async_guard, sync_guard}
	} else {

		isTimeAfter := false
		switch call := e.(type) {
		case *ast.CallExpr:
			switch sel := call.Fun.(type) {
			case *ast.SelectorExpr:
				switch ident := sel.X.(type) {
				case *ast.Ident:
					if ident.Name == "time" && sel.Sel.Name == "After" {
						m.checkForBreak(body, g)
						guards = []*promela_ast.GuardStmt{&promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: body}}
						isTimeAfter = true
					}
				}
			}
		}

		if !isTimeAfter {
			err = &ParseError{err: errors.New(UNKNOWN_RCV + m.Fileset.Position(e.Pos()).String())}
		}
	}

	return guards, err
}
