package promela

import (
	"errors"
	"fmt"
	"go/ast"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

// Return if the expr given could be translated to a var or not and if it can its promela expr.
func (m *Model) TranslateArg(expr ast.Expr) (*promela_ast.Ident, *ParseError) {

	if con, num := IsConst(expr, m.AstMap[m.Package]); con {
		return &promela_ast.Ident{Name: fmt.Sprint(num), Ident: m.Fileset.Position(expr.Pos())}, nil
	}

	switch expr := expr.(type) {
	case *ast.Ident:
		return &promela_ast.Ident{Name: VAR_PREFIX + expr.Name, Ident: m.Fileset.Position(expr.Pos())}, nil

	case *ast.SelectorExpr:

		x, err := m.TranslateArg(expr.X)

		if err != nil {
			return nil, err
		}
		return &promela_ast.Ident{Name: x.Name + "_" + expr.Sel.Name,
			Ident: m.Fileset.Position(expr.Pos())}, nil

	case *ast.BinaryExpr:
		lhs, err := m.TranslateArg(expr.X)

		rhs, err1 := m.TranslateArg(expr.Y)

		if err != nil {
			return nil, err
		}
		if err1 != nil {
			return nil, err1
		}
		return &promela_ast.Ident{Name: lhs.Name + expr.Op.String() + rhs.Name}, nil

	case *ast.UnaryExpr:

		return m.TranslateArg(expr.X)

	case *ast.CallExpr:
		call_name := TranslateIdent(expr.Fun, m.Fileset).Name
		if (call_name == "len" || call_name == "int") && len(expr.Args) > 0 {
			return m.TranslateArg(expr.Args[0]) // if its len just return the translation of the first args which is the list
		}

		return m.TranslateArg(expr.Fun)

	case *ast.BasicLit:
		return &promela_ast.Ident{Name: expr.Value}, nil
	case *ast.StarExpr:
		return m.TranslateArg(expr.X)
	case *ast.ParenExpr:
		return m.TranslateArg(expr.X)
	default:
		return nil, &ParseError{err: errors.New(UNPARSABLE_ARG + m.Fileset.Position(expr.Pos()).String())}

	}

}
