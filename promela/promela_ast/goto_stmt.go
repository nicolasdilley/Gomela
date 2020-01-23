package promela_ast

import "go/token"

// GotoStmt is a jump statement that goes to the label specified
type GotoStmt struct {
	Goto  token.Position
	Label string
}

func (i *GotoStmt) GoNode() token.Position {
	return i.Goto
}

func (i *GotoStmt) Print(num_tabs int) string {
	return "goto " + i.Label
}
