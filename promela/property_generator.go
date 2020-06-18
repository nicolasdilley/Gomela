package promela

import (
	"fmt"
	"strings"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
	"github.com/nicolasdilley/gomela/promela/promela_types"
)

type PropertyGenerator struct {
	Properties     []promela_ast.LTL_property
	Model          *Model
	counter        int
	Select_counter int
}

// Add the LTL properties to the model
func (gen *PropertyGenerator) GenerateProperties() {
	for _, proc := range gen.Model.Proctypes {
		proc.Body = gen.parseBlockStmt(proc.Body)
	}

	gen.Model.Init.Body = gen.parseBlockStmt(gen.Model.Init.Body)

	// gen.Model.LTL_Properties = gen.Properties

}

// Take a BlockStmt, add the LTL properties and return the blockStmt with the LTL properties added
func (gen *PropertyGenerator) parseBlockStmt(b *promela_ast.BlockStmt) *promela_ast.BlockStmt {

	new_b := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}

	if b != nil {
		for _, stmt := range b.List {
			switch stmt := stmt.(type) {
			case *promela_ast.SelectStmt:
				new_b.List = append(new_b.List, gen.parseSelectStmt(stmt).List...)
			case *promela_ast.SendStmt:
				new_b.List = append(new_b.List, gen.parseSendStmt(stmt).List...)
			case *promela_ast.RcvStmt:
				new_b.List = append(new_b.List, gen.parseRcvStmt(stmt).List...)
			case *promela_ast.CondStmt:
				new_cond := *stmt
				new_cond.Guards = []promela_ast.GuardStmt{}

				for _, g := range stmt.Guards {
					body := gen.parseBlockStmt(g.Body)
					g.Body = body
					new_cond.Guards = append(new_cond.Guards, g)
				}
				new_b.List = append(new_b.List, &new_cond)

			case *promela_ast.DoStmt:
				new_do := *stmt
				new_do.Guards = []promela_ast.GuardStmt{}

				for _, g := range stmt.Guards {
					g.Body = gen.parseBlockStmt(g.Body)
					new_do.Guards = append(new_do.Guards, g)

				}
				new_b.List = append(new_b.List, &new_do)
			case *promela_ast.ForStmt:

				new_body := gen.parseBlockStmt(&stmt.Body)
				stmt.Body = *new_body

				new_b.List = append(new_b.List, stmt)

			case *promela_ast.IfStmt:
				new_if := *stmt
				new_if.Guards = []promela_ast.GuardStmt{}
				for _, g := range stmt.Guards {
					body := gen.parseBlockStmt(g.Body)
					g.Body = body
					new_if.Guards = append(new_if.Guards, g)

				}
				init := gen.parseBlockStmt(stmt.Init)
				new_if.Init = init
				new_b.List = append(new_b.List, &new_if)
			case *promela_ast.ExprStmt:
				new_expr := gen.parseBlockStmt(&promela_ast.BlockStmt{List: []promela_ast.Stmt{stmt.X}})
				new_b.List = append(new_b.List, new_expr.List...)
			default:
				if stmt != nil {
					new_b.List = append(new_b.List, stmt)
				}
			}
		}
	}
	return new_b
}

func (gen *PropertyGenerator) parseSelectStmt(s *promela_ast.SelectStmt) *promela_ast.BlockStmt {

	b := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	if !s.Has_default {
		gen.Select_counter++
		select_number := gen.Select_counter
		// check that the select is running

		var_name := fmt.Sprintf("select%d", select_number)
		b.List = append(b.List, &promela_ast.AssignStmt{Lhs: &promela_ast.Ident{Name: var_name}, Rhs: &promela_ast.Ident{Name: "true"}})
		glob_var := &promela_ast.DeclStmt{Name: promela_ast.Ident{Name: var_name}, Rhs: &promela_ast.Ident{Name: "false"}, Types: promela_types.Bool}

		new_prop := promela_ast.LTL_property{Name: fmt.Sprintf("select%d", select_number), Property: "(" + var_name + " U !" + var_name + ")"}
		gen.Properties = append(gen.Properties, new_prop)
		gen.Model.Global_vars = append(gen.Model.Global_vars, glob_var)

		for _, guard := range s.Guards {
			// prepend the properties to the body of the guard and translate the body of the cases
			guard.Body.List = append([]promela_ast.Stmt{&promela_ast.AssignStmt{Lhs: &promela_ast.Ident{Name: var_name}, Rhs: &promela_ast.Ident{Name: "false"}}}, gen.parseBlockStmt(guard.Body).List...)
		}
	} else {
		for _, guard := range s.Guards {
			guard.Body = gen.parseBlockStmt(guard.Body)
		}
	}

	b.List = append(b.List, s)
	return b
}

func (gen *PropertyGenerator) parseSendStmt(s *promela_ast.SendStmt) *promela_ast.BlockStmt {
	b := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}

	if strings.Contains(s.Chan.Print(0), ".in") {
		// gen global var
		gen.counter++
		var_name := fmt.Sprintf("%s_%d", strings.Replace(s.Chan.Print(0), ".", "_", -1), gen.counter)
		// the variable used to check the ltl property
		glob_var := &promela_ast.DeclStmt{Name: promela_ast.Ident{Name: var_name}, Rhs: &promela_ast.Ident{Name: "false"}, Types: promela_types.Bool}

		gen.Model.Global_vars = append(gen.Model.Global_vars, glob_var) // adding the declaration of the var to the topo

		// gen the bool properties
		b.List = append(b.List, &promela_ast.AssignStmt{Lhs: &promela_ast.Ident{Name: var_name}, Rhs: &promela_ast.Ident{Name: "true"}})
		b.List = append(b.List, s)
		b.List = append(b.List, &promela_ast.AssignStmt{Lhs: &promela_ast.Ident{Name: var_name}, Rhs: &promela_ast.Ident{Name: "false"}})

		// gen the ltl property
		new_prop := promela_ast.LTL_property{Name: var_name, Property: "(" + var_name + " U !" + var_name + ")"}
		gen.Properties = append(gen.Properties, new_prop)
	} else {
		b.List = append(b.List, s) // if its not a send on .in don't do anything just return it back
	}
	return b
}

func (gen *PropertyGenerator) parseRcvStmt(s *promela_ast.RcvStmt) *promela_ast.BlockStmt {
	b := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	if strings.Contains(s.Chan.Print(0), ".in") {
		// gen global var
		gen.counter++
		var_name := fmt.Sprintf("%s_%d", strings.Replace(s.Chan.Print(0), ".", "_", -1), gen.counter)
		glob_var := &promela_ast.DeclStmt{Name: promela_ast.Ident{Name: var_name}, Rhs: &promela_ast.Ident{Name: "false"}, Types: promela_types.Bool} // the variable used to check the ltl property

		gen.Model.Global_vars = append(gen.Model.Global_vars, glob_var) // adding the declaration of the var to the topo

		// gen the bool properties
		b.List = append(b.List, &promela_ast.AssignStmt{Lhs: &promela_ast.Ident{Name: var_name}, Rhs: &promela_ast.Ident{Name: "true"}})
		b.List = append(b.List, s)
		b.List = append(b.List, &promela_ast.AssignStmt{Lhs: &promela_ast.Ident{Name: var_name}, Rhs: &promela_ast.Ident{Name: "false"}})

		// gen the ltl property
		new_prop := promela_ast.LTL_property{Name: var_name, Property: "(" + var_name + " U !" + var_name + ")"}
		gen.Properties = append(gen.Properties, new_prop)

	} else {
		b.List = append(b.List, s) // if its not a send on .in don't do anything just return it back
	}
	return b
}
