package promela

import (
	"github.com/nicolasdilley/gomela/promela/promela_ast"
	"github.com/nicolasdilley/gomela/promela/promela_types"

	"go/token"
)

// A channel parameter is either of the form "chan c", or "Chandef c", based on M.containsClose.
type GenChanParam struct {
	Pos   token.Position
	Model string
	M     *GlobalProps // a pointer to the model to check whether it containsClose or not
	Name  string       // the chan that we want to send on
}

func (s *GenChanParam) GoNode() token.Position {
	return s.Pos
}

func (s *GenChanParam) Print(num_tabs int) string {

	// if contains close send to monitor
	var p *promela_ast.Param
	if s.M.ContainsClose {
		p = &promela_ast.Param{
			Pos:   s.Pos,
			Name:  s.Name,
			Types: promela_types.Chandef,
		}
		return p.Print(num_tabs)
	} else {
		p = &promela_ast.Param{
			Pos:   s.Pos,
			Name:  s.Name,
			Types: promela_types.Chan,
		}
	}
	return p.Print(num_tabs)
}

func (s *GenChanParam) Clone() promela_ast.Stmt {
	s1 := &GenChanParam{Pos: s.Pos, Name: s.Name, M: s.M, Model: s.Model}
	return s1
}
