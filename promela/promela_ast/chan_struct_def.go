package promela_ast

import (
	"go/token"

	"github.com/nicolasdilley/gomela/promela/utils"
)

type ChanStructDef struct {
	Name  *Ident
	Def   token.Position
	Defs  []*Chandef
	Decls []*DeclStmt
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

	for _, decl := range c.Decls {
		stmt += utils.GetTabs(num_tabs+1) + decl.Print(num_tabs)
		stmt += ";\n"
	}
	stmt += "}\n"
	return
}

func (s *ChanStructDef) Clone() Stmt {
	s1 := &ChanStructDef{Def: s.Def, Name: s.Name.Clone().(*Ident), Defs: []*Chandef{}, Decls: []*DeclStmt{}}

	for _, d := range s.Defs {
		s1.Defs = append(s1.Defs, d.Clone().(*Chandef))
	}
	for _, d := range s.Decls {
		s1.Decls = append(s1.Decls, d.Clone().(*DeclStmt))
	}
	return s1
}
