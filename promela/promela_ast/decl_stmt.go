package promela_ast

import (
	"go/token"

	"github.com/nicolasdilley/gomela/promela/promela_types"
)

type DeclStmt struct {
	Decl  token.Position
	Name  *Ident
	Types promela_types.Types
	Rhs   Expr // can be null if not assigned
}

func (s *DeclStmt) GoNode() token.Position {
	return s.Decl
}

func (s *DeclStmt) Print(num_tabs int) (stmt string) {
	stmt += s.Types.Name + " " + s.Name.Print(num_tabs)

	if s.Rhs != nil {
		stmt += " = " + s.Rhs.Print(num_tabs)
	}
	return
}

func (s *DeclStmt) Clone() Stmt {
	s1 := &DeclStmt{Decl: s.Decl, Name: s.Name.Clone().(*Ident), Types: s.Types}
	if s.Rhs != nil {
		s1.Rhs = s.Rhs.Clone()
	}
	return s1
}
