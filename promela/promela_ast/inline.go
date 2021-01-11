package promela_ast

import (
	"go/token"
)

type Inline struct {
	Name   *Ident // the name of the Inline
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
	stmt += "\n}\n"

	return
}

func (s *Inline) Clone() Stmt {
	s1 := &Inline{Pos: s.Pos, Name: s.Name.Clone().(*Ident), Body: s.Body.Clone().(*BlockStmt), Params: []Expr{}}

	for _, e := range s.Params {
		s1.Params = append(s1.Params, e.Clone())
	}
	return s1
}
