package promela_ast

import (
	"go/token"

	"git.cs.kent.ac.uk/nd315/gopology/promela/utils"
)

type Inline struct {
	Name   Ident // the name of the Inline
	Pos    token.Position
	Body   *BlockStmt // the body of the process
	Params []Expr     // the arguments (Params) of the inline function
}

func (p *Inline) GoNode() token.Position {
	return p.Pos
}

func (p *Inline) Print(num_tabs int) (stmt string) {
	stmt += "inline " + p.Name.Print(0) + "("

	for i, arg := range p.Params {
		stmt += arg.Print(0)

		if i < len(p.Params)-1 {
			stmt += ","
		}
	}
	stmt += ") {\n"
	stmt += p.Body.Print(num_tabs + 1)
	stmt += "\n " + utils.GetTabs(num_tabs+1) + "stop_process:"
	stmt += "\n}\n"

	return stmt
}
