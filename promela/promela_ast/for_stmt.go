package promela_ast

import (
	"fmt"
	"go/token"

	"github.com/nicolasdilley/gomela/promela/utils"
)

// a for statement is a like a for loop in Go

type ForStmt struct {
	For   token.Position
	Bound Ident // the number of reps
	Body  BlockStmt
}

func (s *ForStmt) GoNode() token.Position {
	return s.For
}

func (s *ForStmt) Print(num_tabs int) (stmt string) {
	stmt += utils.GetTabs(num_tabs) + fmt.Sprintf("for(i : 1.. %s) {\n", s.Bound.Name)
	stmt += s.Body.Print(num_tabs+1) + "\n"
	stmt += utils.GetTabs(num_tabs) + "}"
	return stmt
}
