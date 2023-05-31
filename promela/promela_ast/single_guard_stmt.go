package promela_ast

import (
	"go/token"

	"github.com/nicolasdilley/gomela/promela/utils"
)

// a guard statement is a statement that execute the body only when the Cond is executable
// Guard stmt in promela : (cond) -> body
type SingleGuardStmt struct {
	Guard token.Position
	Cond  Stmt
	Body  *BlockStmt
}

func (s *SingleGuardStmt) GoNode() token.Position {
	return s.Guard
}

func (s *SingleGuardStmt) Print(num_tabs int) (stmt string) {
	stmt += utils.GetTabs(num_tabs) + ":: " + s.Cond.Print(num_tabs)
	if len(s.Body.List) >= 1 {
		stmt += " -> \n"
		stmt += s.Body.Print(num_tabs + 1)
	} else {
		stmt += ";"
	}
	return
}

func (s *SingleGuardStmt) Clone() Stmt {
	s1 := &SingleGuardStmt{Guard: s.Guard, Cond: s.Cond.Clone(), Body: s.Body.Clone().(*BlockStmt)}
	return s1
}

func (s *SingleGuardStmt) GetBody() *BlockStmt {
	return s.Body
}
