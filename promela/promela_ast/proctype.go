package promela_ast

import (
	"go/ast"
	"go/token"

	"github.com/nicolasdilley/gomela/promela/promela_types"
)

type Proctype struct {
	Name   *Ident // the name of the proctype
	Pos    token.Position
	Active bool       // is it an active process ?
	Body   *BlockStmt // the body of the process
	Params []*Param
	Decl   *ast.FuncDecl
}

func (p *Proctype) GoNode() token.Position {
	return p.Pos
}

func (p *Proctype) Print(num_tabs int) (stmt string) {
	if p.Active {
		stmt += "active "
	}
	stmt += "proctype " + p.Name.Print(num_tabs) + "("

	p.DeclAtStart()

	for i, params := range p.Params {
		stmt += params.Print(0)

		if i < len(p.Params)-1 {
			stmt += ";"
		}
	}

	decl := &DeclStmt{Name: &Ident{Name: "i"}, Types: promela_types.Int}
	state := &DeclStmt{Name: &Ident{Name: "state"}, Types: promela_types.Bool}
	num_msgs := &DeclStmt{Name: &Ident{Name: "num_msgs"}, Types: promela_types.Int}
	p.Body.List = append([]Stmt{decl, state, num_msgs}, p.Body.List...)
	stmt += ") {\n"
	stmt += "\tbool closed; \n"
	stmt += p.Body.Print(num_tabs + 1)
	stmt += "\n}\n"

	return
}
func (s *Proctype) Clone() Stmt {
	s1 := &Proctype{Pos: s.Pos, Name: s.Name.Clone().(*Ident), Body: s.Body.Clone().(*BlockStmt), Active: s.Active, Params: []*Param{}}

	for _, p := range s.Params {
		s1.Params = append(s1.Params, p.Clone().(*Param))
	}
	return s1
}

func (p *Proctype) DeclAtStart() {
	decls := DeclInBlock(p.Body)
	p.Body.List = append(decls, p.Body.List...)
}

func DeclInBlock(block *BlockStmt) []Stmt {
	decls := []Stmt{}
	for i := len(block.List) - 1; i >= 0; i-- {
		switch stmt := block.List[i].(type) {
		case *Chandef,
			*DeclStmt:
			// remove decl
			block.List = append(block.List[:i], block.List[i+1:]...)
			decls = append(decls, stmt)
		case *IfStmt:
			for _, guard := range stmt.Guards {
				decls = append(decls, DeclInBlock(guard.Body)...)
			}
		case *ForStmt:

			decls = append(decls, DeclInBlock(stmt.Body)...)

		case *DoStmt:
			for _, guard := range stmt.Guards {
				decls = append(decls, DeclInBlock(guard.Body)...)
			}

		case *SelectStmt:
			for _, guard := range stmt.Guards {
				decls = append(decls, DeclInBlock(guard.Body)...)
			}

		case *CondStmt:
			for _, guard := range stmt.Guards {
				decls = append(decls, DeclInBlock(guard.Body)...)
			}
		case *BlockStmt:
			decls = append(decls, DeclInBlock(stmt)...)
		}
	}

	return decls
}
