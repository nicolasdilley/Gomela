package promela

import (
	"go/token"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
	"github.com/nicolasdilley/gomela/promela/promela_types"
)

type ChanDefDeclStmt struct {
	Decl token.Position
	M    *Model
	Name *promela_ast.Ident
	Size *promela_ast.Ident
}

func (s *ChanDefDeclStmt) GoNode() token.Position {
	return s.Decl
}

func (s *ChanDefDeclStmt) Print(num_tabs int) (stmt string) {

	if s.M.ContainsClose {

		stmt += "Chandef " + s.Name.Print(num_tabs)

		if_stmt := &promela_ast.IfStmt{Init: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}, Guards: []promela_ast.GuardStmt{}}
		sync_monitor := &promela_ast.RunStmt{X: &promela_ast.CallExpr{Fun: &promela_ast.Ident{Name: "sync_monitor"}, Args: []promela_ast.Expr{s.Name}}}

		async_guard := &promela_ast.SingleGuardStmt{
			Cond: &promela_ast.Ident{Name: s.Name.Name + " > 0"},
			Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{
				&promela_ast.AssignStmt{Lhs: &promela_ast.SelectorExpr{X: s.Name, Sel: &promela_ast.Ident{Name: "size"}}, Rhs: s.Size},
				&promela_ast.RunStmt{X: &promela_ast.CallExpr{Fun: &promela_ast.Ident{Name: "async_monitor"}, Args: []promela_ast.Expr{s.Name}}},
			}}}
		sync_guard := &promela_ast.SingleGuardStmt{Cond: &promela_ast.Ident{Name: "else"},
			Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{sync_monitor}}}

		if_stmt.Guards = append(if_stmt.Guards, async_guard, sync_guard)
		stmt += "\n " + if_stmt.Print(num_tabs)

	} else {
		// just print a generic channel
		chan_def := &promela_ast.Chandef{
			Def:   s.Decl,
			Name:  s.Name,
			Types: []promela_types.Types{promela_types.Int},
			Size:  s.Size,
		}
		stmt = chan_def.Print(num_tabs)
	}

	return
}

func (s *ChanDefDeclStmt) Clone() promela_ast.Stmt {
	s1 := &ChanDefDeclStmt{Decl: s.Decl, Name: s.Name.Clone().(*promela_ast.Ident), M: s.M, Size: s.Size}
	return s1
}
