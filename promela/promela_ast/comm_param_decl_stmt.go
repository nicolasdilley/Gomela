package promela_ast

import (
	"go/token"

	"github.com/nicolasdilley/gomela/promela/promela_types"
)

type CommParamDeclStmt struct {
	Decl      token.Position
	Name      *Ident
	Types     promela_types.Types
	Mandatory bool
	Rhs       Expr // can be null if not assigned
}

func (s *CommParamDeclStmt) GoNode() token.Position {
	return s.Decl
}

func (s *CommParamDeclStmt) Print(num_tabs int) (stmt string) {
	stmt += s.Types.Name + " " + s.Name.Print(num_tabs)

	if s.Rhs != nil {
		stmt += " = " + s.Rhs.Print(num_tabs)
	}
	stmt += "; // "

	if s.Mandatory {
		stmt += "mand "
	} else {
		stmt += "opt "
	}
	stmt += s.Name.Name
	return
}

func (s *CommParamDeclStmt) Clone() Stmt {
	s1 := &CommParamDeclStmt{Decl: s.Decl, Name: s.Name.Clone().(*Ident), Types: s.Types}
	if s.Rhs != nil {
		s1.Rhs = s.Rhs.Clone()
	}
	return s1
}
