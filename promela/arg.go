package promela

import (
	"errors"
	"fmt"
	"go/ast"
	"go/token"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

// Return if the expr given could be translated to a var or not and if it can its promela expr.
// Also returns a list of the commpar found
func (m *Model) TranslateArg(expr ast.Expr) (*promela_ast.Ident, []ast.Expr, error) {

	exprs := []ast.Expr{}
	if con, num := IsConst(expr, m.AstMap[m.Package]); con {
		return &promela_ast.Ident{Name: fmt.Sprint(num), Ident: m.Props.Fileset.Position(expr.Pos())}, exprs, nil
	}

	switch expr := expr.(type) {
	case *ast.Ident:
		exprs = append(exprs, expr)
		return &promela_ast.Ident{Name: VAR_PREFIX + expr.Name, Ident: m.Props.Fileset.Position(expr.Pos())}, exprs, nil

	case *ast.SelectorExpr:

		x, _, err := m.TranslateArg(expr.X)

		if err != nil {
			return nil, exprs, err
		}
		exprs = append(exprs, expr)
		return &promela_ast.Ident{Name: x.Name + "_" + expr.Sel.Name,
			Ident: m.Props.Fileset.Position(expr.Pos())}, exprs, nil

	case *ast.BinaryExpr:
		lhs, new_exprs1, err := m.TranslateArg(expr.X)

		rhs, new_exprs2, err1 := m.TranslateArg(expr.Y)

		if err != nil {
			return nil, exprs, err
		}
		if err1 != nil {
			return nil, exprs, err1
		}
		return &promela_ast.Ident{Name: lhs.Name + expr.Op.String() + rhs.Name}, append(new_exprs1, new_exprs2...), nil

	case *ast.UnaryExpr:
		switch expr.Op {
		case token.SUB:
			x, new_exprs1, err := m.TranslateArg(expr.X)

			if err != nil {
				return nil, new_exprs1, err
			}
			return &promela_ast.Ident{Name: "-" + x.Name}, new_exprs1, nil
		}
		return m.TranslateArg(expr.X)

	case *ast.CallExpr:
		call_name := TranslateIdent(expr.Fun, m.Props.Fileset).Name
		if (call_name == "len" || call_name == "int") && len(expr.Args) > 0 {
			return m.TranslateArg(expr.Args[0]) // if its len just return the translation of the first args which is the list
		}

		return m.TranslateArg(expr.Fun)

	case *ast.BasicLit:
		return &promela_ast.Ident{Name: expr.Value}, exprs, nil
	case *ast.StarExpr:
		return m.TranslateArg(expr.X)
	case *ast.ParenExpr:
		return m.TranslateArg(expr.X)
	default:
		return nil, exprs, errors.New(UNPARSABLE_ARG + m.Props.Fileset.Position(expr.Pos()).String())

	}

}
