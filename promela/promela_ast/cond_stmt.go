package promela_ast

import (
	"go/token"

	"github.com/nicolasdilley/gomela/promela/utils"
)

// a cond statement is the real representation of an if statement in promela
// Primarly used for the async and sync proctypes
type CondStmt struct {
	Cond   token.Position
	Guards []*GuardStmt
}

func (c *CondStmt) GoNode() token.Position {
	return c.Cond
}

func (c *CondStmt) Print(num_tabs int) (stmt string) {
	stmt = "if\n"
	for _, guard := range c.Guards {
		stmt += guard.Print(num_tabs) + "\n"
	}
	stmt += utils.GetTabs(num_tabs) + "fi"

	return
}
func (s *CondStmt) Clone() Stmt {
	s1 := &CondStmt{Cond: s.Cond, Guards: []*GuardStmt{}}

	for _, g := range s.Guards {
		s1.Guards = append(s1.Guards, g.Clone().(*GuardStmt))
	}
	return s1
}
