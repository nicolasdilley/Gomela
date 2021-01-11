package promela_ast

import (
	"go/token"
)

type InitDef struct {
	Def  token.Position
	Body *BlockStmt
}

func (c *InitDef) GoNode() token.Position {
	return c.Def
}

func (c *InitDef) Print(num_tabs int) (stmt string) {
	stmt += "init { \n"

	c.DeclAtStart()
	stmt += c.Body.Print(num_tabs + 1)
	stmt += "\nstop_process:skip\n}\n"
	return stmt
}

func (d *InitDef) DeclAtStart() {
	d.Body.List = append(DeclInBlock(d.Body), d.Body.List...)
}

func (s *InitDef) Clone() Stmt {
	s1 := &InitDef{Def: s.Def, Body: s.Body.Clone().(*BlockStmt)}
	return s1
}
