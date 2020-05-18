package promela_ast

import (
	"go/token"
)

// a guard statement is a statement that execute the body only when the Cond is executable
// Guard stmt in promela : (cond) -> body
type DefineStmt struct {
	Define token.Position
	Name   Ident
	Rhs    Expr
}

func (s *DefineStmt) GoNode() token.Position {
	return s.Define
}
func (s *DefineStmt) Print(num_tabs int) string {
	toPrint := "#define " + s.Name.Print(num_tabs) + "  "
	toPrint += s.Rhs.Print(num_tabs)
	return toPrint
}
