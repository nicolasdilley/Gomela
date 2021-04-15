package promela_ast

import (
	"go/token"
)

// a guard statement is a statement that execute the body only when the Cond is executable
// Guard stmt in promela : (cond) -> body
type AssignStmt struct {
	Assign token.Position
	Lhs    Expr
	Rhs    Expr
}

func (s *AssignStmt) GoNode() token.Position {
	return s.Assign
}
func (s *AssignStmt) Print(num_tabs int) string {
	return s.Lhs.Print(num_tabs) + " = " + s.Rhs.Print(num_tabs)
}
func (s *AssignStmt) Clone() Stmt {
	s1 := &AssignStmt{Assign: s.Assign, Lhs: s.Lhs.Clone(), Rhs: s.Rhs.Clone()}
	return s1
}
