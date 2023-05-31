package promela

import (
	"go/ast"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

func (m *Model) parseWgFunc(call_expr *ast.CallExpr, name *ast.SelectorExpr) (stmts *promela_ast.BlockStmt, err error) {
	stmts = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	if name.Sel.Name == "Add" {

		ub, err1 := m.lookUp(call_expr.Args[0], ADD_BOUND, m.For_counter.In_for)

		if err1 != nil {
			err = err1
		}

		if m.For_counter.In_for {
			m.PrintFeature(Feature{
				Proj_name: m.Project_name,
				Model:     m.Name,
				Fun:       m.Fun.Name.String(),
				Name:      "Add in for",
				Mandatory: "true",
				Line:      m.Props.Fileset.Position(name.Pos()).Line,
				Info:      "",
				Commit:    m.Commit,
				Filename:  m.Props.Fileset.Position(name.Pos()).Filename,
			})
		}
		stmts.List = append(stmts.List, &promela_ast.SendStmt{
			Send:  m.Props.Fileset.Position(name.Pos()),
			Model: "Add(" + ub.Name + ")",
			Chan:  &promela_ast.Ident{Name: translateIdent(name.X).Name + ".update"},
			Rhs:   ub},

			&promela_ast.RcvStmt{ // wait to receive the ack from the monitor
				Chan: &promela_ast.Ident{Name: translateIdent(name.X).Name + ".update_ack"},
				Rhs:  &promela_ast.Ident{Name: "ok"}},

			// Check that the monitor says its ok
			&promela_ast.AssertStmt{
				Pos:   m.Props.Fileset.Position(call_expr.Pos()),
				Model: "Add(" + ub.Name + ")",
				Expr:  &promela_ast.Ident{Name: "ok"}},
		)

	} else if name.Sel.Name == "Done" {
		if m.For_counter.In_for {
			m.PrintFeature(Feature{
				Proj_name: m.Project_name,
				Model:     m.Name,
				Fun:       m.Fun.Name.String(),
				Name:      "Done in for",
				Mandatory: "false",
				Line:      m.Props.Fileset.Position(name.Pos()).Line,
				Info:      "",
				Commit:    m.Commit,
				Filename:  m.Props.Fileset.Position(name.Pos()).Filename,
			})
		}
		stmts.List = append(stmts.List, &promela_ast.SendStmt{
			Send:  m.Props.Fileset.Position(name.Pos()),
			Model: "Done",
			Chan:  &promela_ast.Ident{Name: translateIdent(name.X).Name + ".update"},
			Rhs:   &promela_ast.Ident{Name: "-1"}},

			&promela_ast.RcvStmt{ // wait to receive the ack from the monitor
				Chan: &promela_ast.Ident{Name: translateIdent(name.X).Name + ".update_ack"},
				Rhs:  &promela_ast.Ident{Name: "ok"}},

			// Check that the monitor says its ok
			&promela_ast.AssertStmt{
				Pos:   m.Props.Fileset.Position(call_expr.Pos()),
				Model: "Done()",
				Expr:  &promela_ast.Ident{Name: "ok"}},
		)
	} else if name.Sel.Name == "Wait" {
		stmts.List = append(stmts.List, &promela_ast.RcvStmt{
			Rcv:   m.Props.Fileset.Position(name.Pos()),
			Model: "Wait()",
			Chan:  &promela_ast.Ident{Name: translateIdent(name.X).Name + ".wait"},
			Rhs:   &promela_ast.Ident{Name: "0"}})
	}

	return stmts, err
}
