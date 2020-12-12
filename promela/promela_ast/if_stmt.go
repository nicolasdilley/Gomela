package promela_ast

import (
	"go/token"

	"github.com/nicolasdilley/gomela/promela/utils"
)

// an if statement is represented as a do statement with true branches that breaks at the end
type IfStmt struct {
	If     token.Position
	Init   *BlockStmt // the condition of an if is usually put outside the if stmt
	Guards []GuardStmt
}

func (s *IfStmt) GoNode() token.Position {
	return s.If
}

func (s *IfStmt) Print(num_tabs int) (stmt string) {
	stmt += "\n"
	if s.Init != nil {
		stmt += s.Init.Print(num_tabs) + "\n"
	}
	stmt += utils.GetTabs(num_tabs) + "if\n"

	for _, guard := range s.Guards {
		// if !length_zero {
		// 	guard.Body.List = append(guard.Body.List, &Ident{Name: "break"})
		// }
		stmt += guard.Print(num_tabs) + "\n"
	}

	stmt += utils.GetTabs(num_tabs) + "fi"
	return
}
