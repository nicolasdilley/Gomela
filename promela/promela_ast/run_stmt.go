package promela_ast

import (
	"go/token"
)

// a guard statement is a statement that execute the body only when the Cond is executable
// Guard stmt in promela : (cond) -> body
type RunStmt struct {
	Run token.Position
	X   CallExpr
}

func (s *RunStmt) GoNode() token.Position {
	return s.Run
}
func (s *RunStmt) Print(num_tabs int) string {
	return "run " + s.X.Print(num_tabs)
}
