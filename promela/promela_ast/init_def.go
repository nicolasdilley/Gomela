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
	stmt += "\nstop_process:}\n"
	return stmt
}

func (d *InitDef) DeclAtStart() {

	for i := len(d.Body.List) - 1; i >= 0; i-- {
		stmt := d.Body.List[i]
		switch stmt.(type) {
		case *Chandef,
			*DeclStmt:
			d.Body.List = append(d.Body.List[:i], d.Body.List[i+1:]...)
			d.Body.List = append([]Stmt{stmt}, d.Body.List...)
		}
	}
}
