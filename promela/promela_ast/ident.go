package promela_ast

import "go/token"

// Ident is an identification to identify the name of variables and functions
type Ident struct {
	Ident token.Position
	Name  string
}

func (i *Ident) GoNode() token.Position {
	return i.Ident
}

func (i *Ident) Print(num_tabs int) string {
	return i.Name
}

func (s *Ident) Clone() Stmt {
	s1 := &Ident{Ident: s.Ident, Name: s.Name}
	return s1
}
