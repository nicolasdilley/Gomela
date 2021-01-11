package promela_ast

import (
	"go/token"
)

// a send statement where chan is the channel that we want to send to and Rhs the expression we want to sent
type ExprStmt struct {
	Pos token.Position
	X   Expr // the chan that we want to send on
}

func (s *ExprStmt) GoNode() token.Position {
	return s.Pos
}

func (s *ExprStmt) Print(num_tabs int) string {
	return s.X.Print(num_tabs)
}
func (s *ExprStmt) Clone() Stmt {
	s1 := &ExprStmt{Pos: s.Pos, X: s.X.Clone()}
	return s1
}
