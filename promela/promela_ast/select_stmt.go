package promela_ast

import (
	"go/token"

	"github.com/nicolasdilley/gomela/promela/utils"
)

type SelectStmt struct {
	Select      token.Position
	Guards      []GuardStmt
	Goto        *GotoStmt
	Has_default bool
}

func (s *SelectStmt) GoNode() token.Position {
	return s.Select
}

func (s *SelectStmt) Print(num_tabs int) (stmt string) {

	stmt = "do\n"
	for _, guard := range s.Guards {
		stmt += guard.Print(num_tabs) + "\n"
	}
	stmt += utils.GetTabs(num_tabs) + "od"
	if s.Goto != nil {
		stmt += "\n " + utils.GetTabs(num_tabs) + s.Goto.Label + " : \n"
	}
	return stmt
}
