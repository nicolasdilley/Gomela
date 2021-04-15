package promela_ast

import (
	"go/token"

	"github.com/nicolasdilley/gomela/promela/utils"
)

// a do statement is a repetition construct that is used to repete certain action that might or might not be executable.
// If non of the guards are executable, the doStmt blocks until one is ready. (Like a for{select}) in go
type DoStmt struct {
	Do     token.Position
	Guards []*GuardStmt
}

func (s *DoStmt) GoNode() token.Position {
	return s.Do
}

func (s *DoStmt) Print(num_tabs int) (stmt string) {
	stmt += "do\n"
	for _, guard := range s.Guards {
		stmt += guard.Print(num_tabs) + "\n"
	}
	stmt += utils.GetTabs(num_tabs) + "od"
	return
}

func (s *DoStmt) Clone() Stmt {
	s1 := &DoStmt{Do: s.Do, Guards: []*GuardStmt{}}

	for _, g := range s.Guards {
		s1.Guards = append(s1.Guards, g.Clone().(*GuardStmt))
	}
	return s1
}
