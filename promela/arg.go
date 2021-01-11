package promela

import (
	"errors"
	"fmt"
	"go/ast"
	"strconv"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

// Return if the expr given could be translated to a var or not and if it can its promela expr.
func (m *Model) TranslateArg(expr ast.Expr) (e promela_ast.Expr, bounds []promela_ast.Ident, err *ParseError) {
	bounds = []promela_ast.Ident{}

	var e1 promela_ast.Expr = nil
	if con, num := IsConst(expr, m.AstMap[m.Package]); con {
		name := promela_ast.Ident{Name: fmt.Sprint(num), Ident: m.Fileset.Position(expr.Pos())}
		e1 = &name
		return e1, []promela_ast.Ident{name}, nil
	}
	switch expr := expr.(type) {
	case *ast.Ident:
		name := promela_ast.Ident{Name: expr.Name, Ident: m.Fileset.Position(expr.Pos())}
		e1 = &name
		bounds = append(bounds, name)
	case *ast.SelectorExpr:
		name := promela_ast.Ident{Name: m.getIdent(expr.X).Name + "_" + expr.Sel.Name,
			Ident: m.Fileset.Position(expr.Pos())}
		e1 = &name
		bounds = append(bounds, name)

	case *ast.BinaryExpr:
		lhs, names, err1 := m.TranslateArg(expr.X)

		if err1 != nil {
			err = err1
		}
		rhs, names2, err2 := m.TranslateArg(expr.Y)

		if err2 != nil {
			err = err2
		}
		if err == nil {

			e1 = &promela_ast.BinaryExpr{Lhs: lhs, Op: expr.Op.String(), Rhs: rhs}
		}
		for _, name := range append(names, names2...) {

			bounds = append(bounds, name)
		}

	case *ast.UnaryExpr:
		unary, names, err1 := m.TranslateArg(expr.X)

		if err1 != nil {
			err = err1
		} else {
			e1 = &promela_ast.ExprStmt{X: unary}
		}

		bounds = append(bounds, names...)
	case *ast.CallExpr:
		if TranslateIdent(expr.Fun, m.Fileset).Name == "len" {
			return m.TranslateArg(expr.Args[0]) // if its len just return the translation of the first args which is the list
		}

		arg, _, err1 := m.TranslateArg(expr.Fun)

		if err1 == nil {
			err = err1

			name := promela_ast.Ident{Name: m.getIdent(expr.Fun).Name + strconv.Itoa(m.Fileset.Position(expr.Fun.Pos()).Line) + strconv.Itoa(m.Fileset.Position(expr.Fun.Pos()).Column), Ident: m.Fileset.Position(expr.Pos())}
			e1 = &name
			bounds = append(bounds, name)
		} else {
			return arg, bounds, &ParseError{err: errors.New("Could not parse the name of the function at pos " + m.Fileset.Position(expr.Pos()).String())}
		}
	case *ast.BasicLit:
		name := promela_ast.Ident{Name: expr.Value}
		e1 = &name
		bounds = append(bounds, name)
	case *ast.StarExpr:
		return m.TranslateArg(expr.X)
	case *ast.ParenExpr:
		return m.TranslateArg(expr.X)
	default:
		err = &ParseError{err: errors.New("Could not parse an arguments at line " + m.Fileset.Position(expr.Pos()).String())}

	}
	return e1, bounds, err
}
