package promela

import (
	"errors"
	"go/ast"
	"go/types"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

func (m *Model) translateRcvStmt(
	e ast.Expr,
	body *promela_ast.BlockStmt,
	body2 *promela_ast.BlockStmt,
	g *promela_ast.GotoStmt) ([]*promela_ast.GuardStmt, *ParseError) {
	guards := []*promela_ast.GuardStmt{}
	var err *ParseError

	if m.containsChan(e) {
		chan_name := m.getChanStruct(e)

		async_rcv := &promela_ast.RcvStmt{
			Chan: &promela_ast.SelectorExpr{
				X:   chan_name.Name,
				Sel: &promela_ast.Ident{Name: "deq"}},
			Rhs: &promela_ast.Ident{Name: "state,num_msgs"}}

		sync_rcv := &promela_ast.RcvStmt{
			Chan: &promela_ast.SelectorExpr{
				X:   chan_name.Name,
				Sel: &promela_ast.Ident{Name: "sync"}},
			Rhs: &promela_ast.Ident{Name: "state"}}

		m.checkForBreak(body, g)
		m.checkForBreak(body2, g)

		async_guard := &promela_ast.GuardStmt{
			Cond:  async_rcv,
			Guard: m.Fileset.Position(e.Pos()),
			Body:  body}

		sync_guard_body := &promela_ast.BlockStmt{List: []promela_ast.Stmt{
			&promela_ast.SendStmt{
				Chan: &promela_ast.SelectorExpr{
					X:   chan_name.Name,
					Sel: &promela_ast.Ident{Name: "rcving"},
				},
				Rhs: &promela_ast.Ident{Name: "false"},
			},
		}}

		sync_guard_body.List = append(sync_guard_body.List, body2.List...)
		sync_guard := &promela_ast.GuardStmt{
			Cond: sync_rcv,
			Body: sync_guard_body,
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
						guards = []*promela_ast.GuardStmt{
							&promela_ast.GuardStmt{
								Cond: &promela_ast.Ident{Name: "true"},
								Body: body}}
						isTimeAfter = true
					}
					if sel.Sel.Name == "Done" {

						// look if the type is context.Context
						isContext := false
						switch t := m.AstMap[m.Package].TypesInfo.TypeOf(ident).(type) {
						case *types.Named:
							if t.String() == "context.Context" {
								isContext = true
							}
						}
						if ident.Name == "ctx" || isContext {
							m.checkForBreak(body, g)
							guards = []*promela_ast.GuardStmt{
								&promela_ast.GuardStmt{
									Cond: &promela_ast.Ident{Name: "true"},
									Body: body}}
							isTimeAfter = true
						}
					}
				}
			}
		}

		if !isTimeAfter {
			err = &ParseError{
				err: errors.New(UNKNOWN_RCV + m.Fileset.Position(e.Pos()).String()),
			}
		}
	}

	return guards, err
}
