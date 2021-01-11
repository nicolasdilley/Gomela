package promela_ast

import "go/token"

// GotoStmt is a jump statement that goes to the label specified
type GotoEndStmt struct {
	Goto token.Position
}

func (i *GotoEndStmt) GoNode() token.Position {
	return i.Goto
}

func (i *GotoEndStmt) Print(num_tabs int) string {
	return "goto stop_process"
}

func (s *GotoEndStmt) Clone() Stmt {
	s1 := &GotoEndStmt{Goto: s.Goto}
	return s1
}
