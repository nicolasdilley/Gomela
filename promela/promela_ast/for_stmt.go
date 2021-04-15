package promela_ast

import (
	"fmt"
	"go/token"

	"github.com/nicolasdilley/gomela/promela/utils"
)

// a for statement is a like a for loop in Go

type ForStmt struct {
	For  token.Position
	Lb   *Ident // the lower bound
	Ub   *Ident // the upper bound of the for loop
	Body *BlockStmt
}

func (s *ForStmt) GoNode() token.Position {
	return s.For
}

func (s *ForStmt) Print(num_tabs int) (stmt string) {
	stmt += utils.GetTabs(num_tabs) + fmt.Sprintf("for(i : %s.. %s) {\n", s.Lb.Name, s.Ub.Name)
	stmt += s.Body.Print(num_tabs+1) + "\n"
	stmt += utils.GetTabs(num_tabs) + "}"
	return
}
func (s *ForStmt) Clone() Stmt {
	s1 := &ForStmt{For: s.For, Lb: s.Lb.Clone().(*Ident), Ub: s.Ub.Clone().(*Ident), Body: s.Body.Clone().(*BlockStmt)}
	return s1
}
