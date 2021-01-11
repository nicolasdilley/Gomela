package promela_ast

import "go/token"

// GotoStmt is a jump statement that goes to the label specified
type GotoStmt struct {
	Goto  token.Position
	Label *LabelStmt
}

func (i *GotoStmt) GoNode() token.Position {
	return i.Goto
}

func (i *GotoStmt) Print(num_tabs int) string {
	return "goto " + i.Label.Name
}

func (s *GotoStmt) Clone() Stmt {
	s1 := &GotoStmt{Goto: s.Goto, Label: s.Label.Clone().(*LabelStmt)}
	return s1
}
