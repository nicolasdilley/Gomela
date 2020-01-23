package promela_ast

import (
	"go/token"
)

type CallExpr struct {
	Fun  Ident
	Call token.Position
	Args []Expr
}

func (c *CallExpr) GoNode() token.Position {
	return c.Call
}

func (c *CallExpr) Print(num_tabs int) (stmt string) {
	stmt += c.Fun.Print(num_tabs) + "("
	for i, arg := range c.Args {
		stmt += arg.Print(0)
		if i < len(c.Args)-1 {
			stmt += ","
		}
	}
	stmt += ")"
	return stmt
}
