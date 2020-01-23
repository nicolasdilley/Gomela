package promela_ast

import "go/token"

type Typedef struct {
	Def    token.Position
	Name   Ident
	Fields []DeclStmt
}

func (s *Typedef) GoNode() token.Position {
	return s.Def
}
