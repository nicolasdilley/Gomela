package promela_ast

import "go/token"

// A label usually used for end or progress labels
type LabelStmt struct {
	Label token.Position
	Name  string
}

func (b *LabelStmt) GoNode() token.Position {
	return b.Label
}

func (b *LabelStmt) Print(num_tabs int) string {
	return b.Name + ": skip"
}

func (s *LabelStmt) Clone() Stmt {
	s1 := &LabelStmt{Label: s.Label, Name: s.Name}
	return s1
}
