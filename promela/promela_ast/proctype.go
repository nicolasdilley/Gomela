package promela_ast

import (
	"go/token"

	"github.com/nicolasdilley/gomela/promela/promela_types"
)

type Proctype struct {
	Name   Ident // the name of the proctype
	Pos    token.Position
	Active bool       // is it an active process ?
	Body   *BlockStmt // the body of the process
	Params []Param
}

func (p *Proctype) GoNode() token.Position {
	return p.Pos
}

func (p *Proctype) Print(num_tabs int) (stmt string) {
	if p.Active {
		stmt += "active "
	}
	stmt += "proctype " + p.Name.Print(num_tabs) + "("

	p.DeclAtStart()

	for i, params := range p.Params {
		stmt += params.Print(0)

		if i < len(p.Params)-1 {
			stmt += ";"
		}
	}

	decl := &DeclStmt{Name: Ident{Name: "i"}, Types: promela_types.Int}
	p.Body.List = append([]Stmt{decl}, p.Body.List...)
	p.Body.List = append(p.Body.List, &LabelStmt{Name: "stop_process"})
	stmt += ") {\n"
	stmt += "\tbool closed; \n"
	stmt += p.Body.Print(num_tabs + 1)
	stmt += "\n}\n"

	return
}

func (p *Proctype) DeclAtStart() {
	for i := len(p.Body.List) - 1; i >= 0; i-- {
		stmt := p.Body.List[i]
		switch stmt.(type) {
		case *Chandef,
			*DeclStmt:
			p.Body.List = append(p.Body.List[:i], p.Body.List[i+1:]...)
			p.Body.List = append([]Stmt{stmt}, p.Body.List...)
		}
	}
}
