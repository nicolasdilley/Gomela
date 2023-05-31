package promela_ast

import (
	"go/token"

	"github.com/nicolasdilley/gomela/promela/utils"
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

		stmt += utils.GetTabs(num_tabs)
		stmt += s.Print(num_tabs)
		if i < len(b.List)-1 {
			switch s.(type) {
			case *CommParamDeclStmt:
				stmt += "\n"
			default:
				stmt += ";\n"
			}
		}

	}
	return stmt
}

func (s *BlockStmt) Clone() Stmt {

	s1 := &BlockStmt{Block: s.Block, List: []Stmt{}}

	for _, stmt := range s.List {
		s1.List = append(s1.List, stmt.Clone())
	}
	return s1
}
