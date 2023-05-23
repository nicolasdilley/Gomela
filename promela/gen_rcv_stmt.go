package promela

import (
	"github.com/nicolasdilley/gomela/promela/promela_ast"

	"go/token"
)

// a Promela send statement is a *guard* statement which either sends its respective monitor or promela channel based on containsClose
type GenRcvStmt struct {
	Rcv        token.Position
	Model      string
	M          *Model           // a pointer to the model to check whether it containsClose or not
	Chan       promela_ast.Expr // the chan that we want to send on
	Sync_body  *promela_ast.BlockStmt
	Async_body *promela_ast.BlockStmt
}

func (s *GenRcvStmt) GoNode() token.Position {
	return s.Rcv
}

func (s *GenRcvStmt) Print(num_tabs int) string {

	// if contains close send to monitor

	if s.M.ContainsClose {

		async_rcv := &promela_ast.RcvStmt{
			Chan: &promela_ast.SelectorExpr{
				X:   s.Chan,
				Sel: &promela_ast.Ident{Name: "deq"}},
			Rhs: &promela_ast.Ident{Name: "state,num_msgs"}}

		sync_rcv := &promela_ast.RcvStmt{
			Chan: &promela_ast.SelectorExpr{
				X:   s.Chan,
				Sel: &promela_ast.Ident{Name: "sync"}},
			Rhs: &promela_ast.Ident{Name: "state"}}

		async_guard := &promela_ast.SingleGuardStmt{
			Cond:  async_rcv,
			Guard: s.Rcv,
			Body:  s.Async_body}

		sync_guard_body := &promela_ast.BlockStmt{List: []promela_ast.Stmt{
			&promela_ast.SendStmt{
				Chan: &promela_ast.SelectorExpr{
					X:   s.Chan,
					Sel: &promela_ast.Ident{Name: "rcving"},
				},
				Rhs: &promela_ast.Ident{Name: "false"},
			},
		}}

		sync_guard_body.List = append(sync_guard_body.List, s.Sync_body.List...)
		sync_guard := &promela_ast.SingleGuardStmt{
			Cond: sync_rcv,
			Body: sync_guard_body,
		}

		return async_guard.Print(num_tabs) + "\n" + sync_guard.Print(num_tabs)

	} else {

		send_guard := &promela_ast.SingleGuardStmt{
			Cond: &promela_ast.SendStmt{
				Chan:  s.Chan,
				Model: "Send",
				Rhs:   &promela_ast.Ident{Name: "0"}},
			Body: s.Sync_body}

		return send_guard.Print(num_tabs)
	}

}

func (s *GenRcvStmt) Clone() promela_ast.Stmt {
	s1 := &GenRcvStmt{Rcv: s.Rcv, Chan: s.Chan.Clone(), M: s.M, Model: s.Model}
	return s1
}

func (s *GenRcvStmt) GetBody() *promela_ast.BlockStmt {

	body := append(s.Sync_body.List, s.Async_body.List...)

	return &promela_ast.BlockStmt{
		List: body,
	}
}
