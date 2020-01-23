package promela_ast

import (
	"go/token"

	"git.cs.kent.ac.uk/nd315/gopology/promela/utils"
)

// a do statement is a repetition construct that is used to repete certain action that might or might not be executable.
// If non of the guards are executable, the doStmt blocks until one is ready. (Like a for{select}) in go
type BlockStmt struct {
	Block token.Position
	List  []Stmt
}

func (b *BlockStmt) GoNode() token.Position {
	return b.Block
}

func (b *BlockStmt) Print(num_tabs int) (stmt string) {
	for i, s := range b.List {
		switch node := s.(type) {
		case *LabelStmt:
			stmt += s.Print(0)
		case *SelectStmt:
			stmt += utils.GetTabs(num_tabs) + s.Print(num_tabs)
			if !(node.Goto != nil) {
				if i < len(b.List)-1 {
					stmt += ";\n"
				}
			}
		default:
			stmt += utils.GetTabs(num_tabs)
			stmt += s.Print(num_tabs)
			if i < len(b.List)-1 {
				stmt += ";\n"
			}
		}

	}
	return stmt
}
