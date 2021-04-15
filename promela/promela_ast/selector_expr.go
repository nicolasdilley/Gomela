package promela_ast

import "go/token"

// Selector expr is an identification of a struct (s.ch1!2) where s is the x and ch1 the selector
type SelectorExpr struct {
	Pos token.Position
	X   Expr
	Sel *Ident
}

func (s *SelectorExpr) GoNode() token.Position {
	return s.Pos
}

func (s *SelectorExpr) Print(num_tabs int) string {
	return s.X.Print(num_tabs) + "." + s.Sel.Print(num_tabs)
}
func (s *SelectorExpr) Clone() Stmt {
	s1 := &SelectorExpr{Pos: s.Pos, X: s.X.Clone(), Sel: s.Sel.Clone().(*Ident)}
	return s1
}
