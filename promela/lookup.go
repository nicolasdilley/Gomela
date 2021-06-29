package promela

import (
	"fmt"
	"go/ast"
	"go/token"
	"strconv"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
	"golang.org/x/tools/go/packages"
)

// take a for or range loop and return if its const, the bound of the for loop and the name in Go of the bound
func (m *Model) lookUpFor(s *ast.ForStmt, spawns bool, pack *packages.Package) (lb *promela_ast.Ident, ub *promela_ast.Ident, err *ParseError) {

	well_formed := false
	lb = &promela_ast.Ident{}
	ub = &promela_ast.Ident{}
	switch cond := s.Cond.(type) {
	case *ast.BinaryExpr:
		if cond.Op == token.GEQ || cond.Op == token.GTR {
			switch inc := s.Post.(type) {
			case *ast.IncDecStmt:
				if inc.Tok == token.DEC {
					ident, err1 := m.lookUp(cond.Y, LOWER_FOR_BOUND, spawns)
					if err1 != nil {
						err = err1
					}
					lb.Name = ident.Print(0)

					// look for upper bound
					switch stmt := s.Init.(type) {
					case *ast.AssignStmt:
						for _, rh := range stmt.Rhs {
							ident, err1 := m.lookUp(rh, UPPER_FOR_BOUND, spawns)
							if err1 != nil {
								err = err1
							}
							ub.Name = ident.Print(0)

							if cond.Op == token.GTR {
								ub.Name += "-1"
							}
							well_formed = true
						}
					}
				}
			}

		} else if cond.Op == token.LSS || cond.Op == token.LEQ {
			switch inc := s.Post.(type) {
			case *ast.IncDecStmt:
				if inc.Tok == token.INC {
					ident, err1 := m.lookUp(cond.Y, UPPER_FOR_BOUND, spawns)
					if err1 != nil {
						err = err1
					}
					ub.Name = ident.Print(0)

					// look for lower bound
					switch s.Init.(type) {
					case *ast.AssignStmt:

						lb.Name = "0"

						if cond.Op == token.LSS {

							ub.Name += "-1"
						}
						well_formed = true
					}
				}
			}
		}

	}

	if !well_formed {
		ub_decl := promela_ast.DefineStmt{Name: &promela_ast.Ident{Name: fmt.Sprintf("ub_for%d_%d", m.Fileset.Position(s.Pos()).Line, m.Fileset.Position(s.Pos()).Column)}, Rhs: &promela_ast.Ident{Name: OPTIONAL_BOUND}}
		mandatory := "false"
		if spawns {
			mandatory = "true"
			ub_decl.Rhs = &promela_ast.Ident{Name: DEFAULT_BOUND}
		}

		if !m.inDefine(ub_decl.Name.Name) {
			m.Defines = append(m.Defines, ub_decl) // adding ub
		}
		m.PrintFeature(Feature{
			Proj_name: m.Project_name,
			Model:     m.Name,
			Fun:       m.Fun.Name.String(),
			Name:      "Candidate Param",
			Info:      ub_decl.Name.Name,
			Mandatory: mandatory,
			Line:      0,
			Commit:    m.Commit,
			Filename:  m.Fileset.Position(m.Fun.Pos()).Filename,
		})
		lb = &promela_ast.Ident{Name: "0"} // returning the fresh vars
		ub = ub_decl.Name

		if !(s.Init == nil && s.Cond == nil && s.Post == nil) {
			m.PrintFeature(Feature{
				Proj_name: m.Project_name,
				Model:     m.Name,
				Fun:       m.Fun.Name.String(),
				Name:      "For loop not well formed",
				Mandatory: "false",
				Info:      fmt.Sprint("Init : ", s.Init, " Cond : ", s.Cond, " Post : ", s.Post),
				Line:      m.Fileset.Position(s.Pos()).Line,
				Commit:    m.Commit,
				Filename:  m.Fileset.Position(s.Pos()).Filename,
			})
		}
	}
	return

}

// take a for or range loop and return if its const, the bound of the for loop and the name in Go of the bound
func (m *Model) lookUp(expr ast.Expr, bound_type int, spawning_for_loop bool) (*promela_ast.Ident, *ParseError) {

	var ident promela_ast.Expr
	var err *ParseError
	var bound string = "for bound"
	var mandatory string = "false"
	switch bound_type {
	case CHAN_BOUND:
		bound = "chan bound"
		mandatory = "true"
	case LOWER_FOR_BOUND:
		bound = "for lower bound"
		if spawning_for_loop {
			mandatory = "true"
			bound = "spawning for lower bound"
		}
	case RANGE_BOUND:
		bound = "range bound"
		if spawning_for_loop {
			mandatory = "true"
			bound = "spawning range bound"
		}
	case UPPER_FOR_BOUND:
		bound = "for upper bound"
		if spawning_for_loop {
			mandatory = "true"
			bound = "spawning for upper bound"
		}
	case ADD_BOUND:
		mandatory = "true"
		bound = "add bound"
	}
	i1, err1 := m.TranslateArg(expr)

	if err1 != nil { // the arguments could not be parsed properly

		name := &promela_ast.Ident{Name: "not_found_" + m.getIdent(expr).Name + strconv.Itoa(m.Fileset.Position(expr.Pos()).Line) + strconv.Itoa(m.Fileset.Position(expr.Pos()).Column)}

		ident = name

		m.PrintFeature(Feature{
			Proj_name: m.Project_name,
			Model:     m.Name,
			Fun:       m.Fun.Name.String(),
			Name:      "Candidate Param",
			Info:      name.Name,
			Mandatory: mandatory,
			Line:      0,
			Commit:    m.Commit,
			Filename:  m.Fileset.Position(m.Fun.Pos()).Filename,
		})

		if spawning_for_loop {
			m.Defines = append(m.Defines, promela_ast.DefineStmt{Name: name, Rhs: &promela_ast.Ident{Name: DEFAULT_BOUND}})
		} else {
			m.Defines = append(m.Defines, promela_ast.DefineStmt{Name: name, Rhs: &promela_ast.Ident{Name: OPTIONAL_BOUND}})
		}
	} else {
		var_name := i1.Print(0)

		if _, err := strconv.Atoi(var_name); err != nil {
			var_name = "var_" + var_name
		}
		i1 = &promela_ast.Ident{Name: var_name}
		ident = i1
	}

	promela_ast.Inspect(i1, func(n promela_ast.Stmt) bool {
		switch name := n.(type) {
		case *promela_ast.Ident:
			m.PrintFeature(Feature{
				Proj_name: m.Project_name,
				Model:     m.Name,
				Fun:       m.Fun.Name.String(),
				Name:      "Comm Param",
				Mandatory: mandatory,
				Info:      name.Name,
				Line:      m.Fileset.Position(expr.Pos()).Line,
				Commit:    m.Commit,
				Filename:  m.Fileset.Position(expr.Pos()).Filename,
			})
		}

		return true
	})

	m.PrintCommParFeature(expr, bound, mandatory)

	if err != nil {
		return &promela_ast.Ident{Name: "null"}, err
	}
	return &promela_ast.Ident{Name: ident.Print(0)}, nil
}
