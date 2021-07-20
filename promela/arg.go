package promela

import (
	"errors"
	"fmt"
	"go/ast"
	"go/token"
	"strconv"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

// Return if the expr given could be translated to a var or not and if it can its promela expr.
func (m *Model) TranslateArg(expr ast.Expr) (e promela_ast.Expr, err *ParseError) {

	var e1 promela_ast.Expr = nil
	if con, num := IsConst(expr, m.AstMap[m.Package]); con {
		name := promela_ast.Ident{Name: fmt.Sprint(num), Ident: m.Fileset.Position(expr.Pos())}
		e1 = &name
		return e1, nil
	}

	switch expr := expr.(type) {
	case *ast.Ident:
		name := promela_ast.Ident{Name: expr.Name, Ident: m.Fileset.Position(expr.Pos())}
		e1 = &name
	case *ast.SelectorExpr:
		name := promela_ast.Ident{Name: m.getIdent(expr.X).Name + "_" + expr.Sel.Name,
			Ident: m.Fileset.Position(expr.Pos())}
		e1 = &name

	case *ast.BinaryExpr:
		lhs, err1 := m.TranslateArg(expr.X)

		if err1 != nil {
			err = err1
		}
		rhs, err2 := m.TranslateArg(expr.Y)

		if err2 != nil {
			err = err2
		}
		if err == nil {

			e1 = &promela_ast.BinaryExpr{Lhs: lhs, Op: expr.Op.String(), Rhs: rhs}
		}
	case *ast.CompositeLit:
		name := promela_ast.Ident{Name: strconv.Itoa(len(expr.Elts)), Ident: m.Fileset.Position(expr.Pos())}
		e1 = &name

	case *ast.UnaryExpr:

		unary, err1 := m.TranslateArg(expr.X)
		switch expr.Op {
		case token.SUB:
		case token.ADD:

		}
		if err1 != nil {
			err = err1
		} else {
			e1 = &promela_ast.ExprStmt{X: unary}
		}

	case *ast.CallExpr:
		call_name := TranslateIdent(expr.Fun, m.Fileset).Name
		if (call_name == "len" || call_name == "int") && len(expr.Args) > 0 {
			return m.TranslateArg(expr.Args[0]) // if its len just return the translation of the first args which is the list
		}

		arg, err1 := m.TranslateArg(expr.Fun)

		if err1 == nil {

			err = err1

			name := TranslateIdent(expr, m.Fileset)

			e1 = &name

		} else {
			return arg, &ParseError{err: errors.New(UNPARSABLE_FUNCTION_NAME + m.Fileset.Position(expr.Pos()).String())}
		}
	case *ast.BasicLit:
		name := promela_ast.Ident{Name: expr.Value}
		e1 = &name

	case *ast.StarExpr:
		return m.TranslateArg(expr.X)
	case *ast.ParenExpr:
		return m.TranslateArg(expr.X)
	case nil:
	default:
		err = &ParseError{err: errors.New(UNPARSABLE_ARG + m.Fileset.Position(expr.Pos()).String())}

	}
	return e1, err
}
