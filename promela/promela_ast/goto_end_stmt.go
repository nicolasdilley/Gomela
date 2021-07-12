package promela_ast

import "go/token"

// GotoStmt is a jump statement that goes to the label specified
type GotoEndStmt struct {
	Goto token.Position
	Name string
}

func (i *GotoEndStmt) GoNode() token.Position {
	return i.Goto
}

func (i *GotoEndStmt) Print(num_tabs int) string {
	return "goto " + i.Name
}
func (s *GotoEndStmt) Clone() Stmt {
	s1 := &GotoEndStmt{Goto: s.Goto, Name: s.Name}
	return s1
}
