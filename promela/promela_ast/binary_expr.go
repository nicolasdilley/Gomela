package promela_ast

import "go/token"

// Selector expr is an identification of a struct (s.ch1!2) where s is the x and ch1 the selector
type BinaryExpr struct {
	Pos token.Position
	Lhs Expr   // the left operand
	Op  string // the operand (==,<=.>, etc)
	Rhs Expr   // the right operand
}

func (b *BinaryExpr) GoNode() token.Position {
	return b.Pos
}

func (b *BinaryExpr) Print(num_tabs int) string {
	return b.Lhs.Print(num_tabs) + " " +
		b.Op + " " + b.Rhs.Print(num_tabs)
}

func (s *BinaryExpr) Clone() Stmt {
	s1 := &BinaryExpr{Pos: s.Pos, Lhs: s.Lhs.Clone(), Rhs: s.Rhs.Clone(), Op: s.Op}
	return s1
}
