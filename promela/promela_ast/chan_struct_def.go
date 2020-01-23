package promela_ast

import (
	"go/token"

	"git.cs.kent.ac.uk/nd315/gopology/promela/utils"
)

type ChanStructDef struct {
	Name Ident
	Def  token.Position
	Defs []Chandef
}

func (c *ChanStructDef) GoNode() token.Position {
	return c.Def
}

func (c *ChanStructDef) Print(num_tabs int) (stmt string) {
	stmt += "typedef " + c.Name.Print(num_tabs) + " {\n"
	for _, channel := range c.Defs {
		stmt += utils.GetTabs(num_tabs+1) + channel.Print(num_tabs)
		stmt += ";\n"
	}
	stmt += "}\n"
	return stmt
}
