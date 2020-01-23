package promela_ast

import (
	"go/token"

	"git.cs.kent.ac.uk/nd315/gopology/promela/promela_types"
)

type Param struct {
	Name  string // the name of the Param
	Pos   token.Position
	Types promela_types.Types
}

func (p *Param) GoNode() token.Position {
	return p.Pos
}

func (p *Param) Print(num_tabs int) (stmt string) {
	stmt += p.Types.Name + " " + p.Name
	return stmt
}
