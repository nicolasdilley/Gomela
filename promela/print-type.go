package promela

import (
	"fmt"
	"go/ast"
	"go/token"
	"go/types"
)

// print the type of the communication parameter
func (m *Model) PrintCommParFeature(expr ast.Expr, bound string, mandatory string) {
	switch expr := expr.(type) {
	case *ast.BinaryExpr:
		m.PrintCommParFeature(expr.X, bound, mandatory)
		m.PrintCommParFeature(expr.Y, bound, mandatory)
	case *ast.UnaryExpr:

		if expr.Op == token.ARROW {
			m.PrintFeature(Feature{
				Proj_name: m.Project_name,
				Model:     m.Name,
				Fun:       m.Fun.Name.String(),
				Name:      "Receive as a " + bound,
				Mandatory: mandatory,
				Info:      prettyPrint(expr) + " Mandatory : " + mandatory,
				Line:      m.Fileset.Position(expr.Pos()).Line,
				Commit:    m.Commit,
				Filename:  m.Fileset.Position(expr.Pos()).Filename,
			})
		} else if expr.Op == token.AND {
			m.PrintFeature(Feature{
				Proj_name: m.Project_name,
				Model:     m.Name,
				Fun:       m.Fun.Name.String(),
				Name:      "Pointer as a " + bound,
				Mandatory: mandatory,
				Info:      prettyPrint(expr.X),
				Line:      m.Fileset.Position(expr.Pos()).Line,
				Commit:    m.Commit,
				Filename:  m.Fileset.Position(expr.Pos()).Filename,
			})
		}

	case *ast.CallExpr:
		// Function as a comm param
		m.PrintFeature(Feature{
			Proj_name: m.Project_name,
			Model:     m.Name,
			Fun:       m.Fun.Name.String(),
			Name:      "Func as a " + bound,
			Mandatory: mandatory,
			Info:      prettyPrint(expr),
			Line:      m.Fileset.Position(expr.Pos()).Line,
			Commit:    m.Commit,
			Filename:  m.Fileset.Position(expr.Pos()).Filename,
		})
		if m.getIdent(expr.Fun).Name == "len" {
			m.PrintFeature(Feature{
				Proj_name: m.Project_name,
				Model:     m.Name,
				Fun:       m.Fun.Name.String(),
				Name:      "len() as a " + bound,
				Mandatory: mandatory,
				Info:      prettyPrint(expr),
				Line:      m.Fileset.Position(expr.Pos()).Line,
				Commit:    m.Commit,
				Filename:  m.Fileset.Position(expr.Pos()).Filename,
			})

		}
	case *ast.SelectorExpr:

		// Struct as a bound
		m.PrintFeature(Feature{
			Proj_name: m.Project_name,
			Model:     m.Name,
			Fun:       m.Fun.Name.String(),
			Name:      "Struct as a " + bound,
			Mandatory: mandatory,
			Info:      "UNSUPPORTED",
			Line:      m.Fileset.Position(expr.Pos()).Line,
			Commit:    m.Commit,
			Filename:  m.Fileset.Position(expr.Pos()).Filename,
		})
	case *ast.IndexExpr:
		m.PrintFeature(Feature{
			Name:      "Uses an item of a list as a " + bound,
			Mandatory: mandatory,
			Info:      "UNSUPPORTED",
			Fun:       m.Fun.Name.Name,
			Proj_name: m.Project_name,
			Model:     m.Name,
			Line:      m.Fileset.Position(expr.Pos()).Line,
			Filename:  m.Fileset.Position(expr.Pos()).String(),
			Commit:    m.Commit,
		})

	case *ast.CompositeLit:
		m.PrintFeature(Feature{
			Name:      "List as a " + bound,
			Info:      "Name :" + fmt.Sprint(expr.Type),
			Mandatory: mandatory,
			Fun:       m.Fun.Name.Name,
			Proj_name: m.Project_name,
			Model:     m.Name,
			Line:      m.Fileset.Position(expr.Pos()).Line,
			Filename:  m.Fileset.Position(expr.Pos()).String(),
			Commit:    m.Commit,
		})
	default:
		Types := m.AstMap[m.Package].TypesInfo.TypeOf(expr)
		if Types == nil {
			fmt.Println("Could not find type of expr : ", expr, " in package :", m.Package, "at pos : ", m.Fileset.Position(expr.Pos()))
		} else {
			switch Types := Types.(type) {
			case *types.Struct:
				// Struct as a bound
				m.PrintFeature(Feature{
					Proj_name: m.Project_name,
					Model:     m.Name,
					Fun:       m.Fun.Name.String(),
					Name:      "Field of a struct as a " + bound,
					Mandatory: mandatory,
					Info:      "UNSUPPORTED",
					Line:      m.Fileset.Position(expr.Pos()).Line,
					Commit:    m.Commit,
					Filename:  m.Fileset.Position(expr.Pos()).Filename,
				})

			case *types.Basic:

				if isConstant(expr) != "not found" {
					m.PrintFeature(Feature{
						Proj_name: m.Project_name,
						Model:     m.Name,
						Fun:       m.Fun.Name.String(),
						Name:      "Integer as a " + bound,
						Mandatory: mandatory,
						Info:      isConstant(expr),
						Line:      m.Fileset.Position(expr.Pos()).Line,
						Commit:    m.Commit,
						Filename:  m.Fileset.Position(expr.Pos()).Filename,
					})
				} else {
					m.PrintFeature(Feature{
						Proj_name: m.Project_name,
						Model:     m.Name,
						Fun:       m.Fun.Name.String(),
						Name:      "Var as a " + bound,
						Mandatory: mandatory,
						Info:      "Name :" + fmt.Sprint(expr),
						Line:      m.Fileset.Position(expr.Pos()).Line,
						Commit:    m.Commit,
						Filename:  m.Fileset.Position(expr.Pos()).Filename,
					})
				}

			case *types.Slice:
				m.PrintFeature(Feature{
					Proj_name: m.Project_name,
					Model:     m.Name,
					Fun:       m.Fun.Name.String(),
					Name:      "Slice as a " + bound,
					Mandatory: mandatory,
					Info:      prettyPrint(expr),
					Line:      m.Fileset.Position(expr.Pos()).Line,
					Commit:    m.Commit,
					Filename:  m.Fileset.Position(expr.Pos()).Filename,
				})
			case *types.Map:
				m.PrintFeature(Feature{
					Proj_name: m.Project_name,
					Model:     m.Name,
					Fun:       m.Fun.Name.String(),
					Name:      "Map as a " + bound,
					Mandatory: mandatory,
					Info:      Types.String(),
					Line:      m.Fileset.Position(expr.Pos()).Line,
					Commit:    m.Commit,
					Filename:  m.Fileset.Position(expr.Pos()).Filename,
				})
			case *types.Named:
				m.PrintFeature(Feature{
					Proj_name: m.Project_name,
					Model:     m.Name,
					Fun:       m.Fun.Name.String(),
					Name:      "Var as a " + bound,
					Mandatory: mandatory,
					Info:      Types.String(),
					Line:      m.Fileset.Position(expr.Pos()).Line,
					Commit:    m.Commit,
					Filename:  m.Fileset.Position(expr.Pos()).Filename,
				})
			}
		}
	}

}
