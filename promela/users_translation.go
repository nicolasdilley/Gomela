package promela

import (
	"fmt"
	"go/ast"
	"go/token"
	"strconv"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

func TranslateIdent(expr ast.Expr, fileSet *token.FileSet) (expr1 promela_ast.Ident) {
	switch expr := expr.(type) {
	case *ast.Ident:
		expr1 = promela_ast.Ident{Name: expr.Name, Ident: fileSet.Position(expr.Pos())}
	case *ast.SelectorExpr:
		expr1 = promela_ast.Ident{Name: TranslateIdent(expr.X, fileSet).Name + "_" + expr.Sel.Name, Ident: fileSet.Position(expr.Pos())}
	case *ast.BasicLit:
		expr1 = promela_ast.Ident{Name: expr.Value}
	case *ast.UnaryExpr:
		expr1 = TranslateIdent(expr.X, fileSet)
	case *ast.StarExpr:
		expr1 = TranslateIdent(expr.X, fileSet)
	case *ast.BinaryExpr:
		expr1 = promela_ast.Ident{Name: TranslateIdent(expr.X, fileSet).Name + expr.Op.String() + TranslateIdent(expr.X, fileSet).Name}

	case *ast.ParenExpr:
		return TranslateIdent(expr.X, fileSet)
	case *ast.CompositeLit:
		expr1 = promela_ast.Ident{Name: "compos" + strconv.Itoa(len(expr.Elts)), Ident: fileSet.Position(expr.Pos())}

	case *ast.CallExpr:
		func_name := TranslateIdent(expr.Fun, fileSet).Name
		expr1 = promela_ast.Ident{Name: func_name}
	case *ast.IndexExpr:
		expr1 = TranslateIdent(expr.X, fileSet)
	case *ast.KeyValueExpr:
		expr1 = TranslateIdent(expr.Key, fileSet)
	case *ast.SliceExpr:
		expr1 = TranslateIdent(expr.X, fileSet)
	case *ast.TypeAssertExpr:
		expr1 = promela_ast.Ident{Name: "0"}
	case *ast.ArrayType, *ast.ChanType, *ast.MapType:
		expr1 = promela_ast.Ident{Name: "0"}
	case nil:
		expr1 = promela_ast.Ident{Name: "0"}
	default:
		ast.Print(fileSet, expr)
		panic("An expression can not be translated " + fmt.Sprint(expr) + " at pos: " + fileSet.Position(expr.Pos()).String())
	}

	return expr1
}

func findExprFromParams(list *ast.FieldList, index int) *ast.Ident {
	i := 0
	for _, field := range list.List {
		for _, name := range field.Names {

			if i == index {
				return name
			}
			i++
		}
	}
	return nil
}

func identicalSelectorExpr(s1 ast.Expr, s2 *ast.SelectorExpr) (bool, *ast.SelectorExpr) {
	switch s1 := s1.(type) {
	case *ast.SelectorExpr:
		switch i1 := s1.X.(type) {
		case *ast.Ident:
			switch i2 := s2.X.(type) {
			case *ast.Ident:
				if i1.Name == i2.Name {
					return true, s1
				}
			}
		case *ast.SelectorExpr:
			switch i2 := s2.X.(type) {
			case *ast.SelectorExpr:
				return identicalSelectorExpr(i1, i2)
			}
		}

	}
	return false, nil

}

// Return if two ast.Expr (Expect ast.Ident and ast.SelectorExpr only) are exactly the same or not
func IdenticalExpr(expr1 ast.Expr, expr2 ast.Expr) (identical bool) {
	switch expr1 := expr1.(type) {
	case *ast.Ident:
		switch e2 := expr2.(type) {
		case *ast.Ident:
			if expr1.Name == e2.Name {
				identical = true
			}
		default:
			identical = false
		}
	case *ast.SelectorExpr:
		switch expr2 := expr2.(type) {
		case *ast.SelectorExpr:
			if expr1.Sel.Name == expr2.Sel.Name {
				identical = IdenticalExpr(expr1.X, expr2.X)
			}
		default:
			identical = false
		}
	case *ast.CallExpr:
		switch expr2 := expr2.(type) {
		case *ast.CallExpr:

			if IdenticalExpr(expr1.Fun, expr2.Fun) {
				identical = true
				for _, a1 := range expr1.Args {
					for _, a2 := range expr2.Args {
						if !IdenticalExpr(a1, a2) {
							identical = false
						}
					}
				}
			}
		}
	}

	return identical
}

// Return the latest possible identification from an expr
func FindIdent(e ast.Expr) (ident *ast.Ident) {
	switch e := e.(type) {
	case *ast.Ident:
		ident = e
	case *ast.SelectorExpr:
		ident = FindIdent(e.X)
	}
	return ident
}
