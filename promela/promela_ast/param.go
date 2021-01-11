package promela_ast

import (
	"go/token"

	"github.com/nicolasdilley/gomela/promela/promela_types"
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
	return
}

func (s *Param) Clone() Stmt {
	s1 := &Param{Pos: s.Pos, Name: s.Name, Types: s.Types}
	return s1
}
