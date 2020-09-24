package promela_ast

import (
	"go/token"

	"github.com/nicolasdilley/gomela/promela/utils"
)

type WgStructDef struct {
	Name Ident
	Def  token.Position
	Defs []Chandef
}

func (c *WgStructDef) GoNode() token.Position {
	return c.Def
}

func (c *WgStructDef) Print(num_tabs int) (stmt string) {
	stmt += "typedef " + c.Name.Print(num_tabs) + " {\n"
	for _, channel := range c.Defs {
		stmt += utils.GetTabs(num_tabs+1) + channel.Print(num_tabs)
		stmt += ";\n"
	}
	stmt += utils.GetTabs(num_tabs+1) + "int Counter = 0;"
	stmt += "}\n"
	return
}
