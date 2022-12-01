package promela_ast

import "go/token"

// Selector expr is an identification of a struct (s.ch1!2) where s is the x and ch1 the selector
type AssertStmt struct {
	Pos token.Position
	Model string
	Expr Expr   // the left operand
}

func (a *AssertStmt) GoNode() token.Position {
	return a.Pos
}

func (a *AssertStmt) Print(num_tabs int) string {

	comment := ""

	if a.Pos.String() != "-" {
		comment = " /* " + a.Model + "\t" + a.Pos.String() + " */"
	}


	return "assert(" + a.Expr.Print(num_tabs) +")" + comment

	
}

func (s *AssertStmt) Clone() Stmt {
	s1 := &AssertStmt{Pos: s.Pos, Expr: s.Expr.Clone()}
	return s1
}
