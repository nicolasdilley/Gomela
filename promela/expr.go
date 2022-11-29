package promela

import (
	"go/ast"
	"strconv"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

func (m *Model) IsExprKnown(expr ast.Expr) bool {

	isKnown := true

	ast.Inspect(expr, func(node ast.Node) bool {
		switch e := node.(type) {
		case *ast.Ident:

			lhs, _ := ContainsCommParam(m.CommPars, &CommPar{Name: &ast.Ident{Name: m.getIdent(e).Name}})
			_, err := strconv.Atoi(m.getIdent(e).Name)

			if !(lhs || err == nil) {
				isKnown = false
			}
			return isKnown
		case *ast.SelectorExpr:
			lhs, _ := ContainsCommParam(m.CommPars, &CommPar{Name: &ast.Ident{Name: m.getIdent(e).Name}})
			_, err := strconv.Atoi(m.getIdent(e).Name)

			if !(lhs || err == nil) {
				isKnown = false
			}
			return isKnown

		case *ast.CallExpr:

			switch ident := e.Fun.(type) {
			case *ast.Ident:
				if ident.Name == "len" || ident.Name == "int" {
					if len(e.Args) > 0 {
						isKnown = m.IsExprKnown(e.Args[0])
					} else {
						isKnown = false
					}
				}
			}

		}
		return isKnown
	})

	return isKnown
}

// Translate an expr where all variable (including literal) are either statically known or comm params
func (m *Model) TranslateKnownExpr(expr ast.Expr) promela_ast.Expr {
	var prom_expr promela_ast.Expr

	switch expr := expr.(type) {
	case *ast.Ident, *ast.SelectorExpr:
		known, ident := ContainsCommParam(m.CommPars, &CommPar{Name: &ast.Ident{Name: m.getIdent(expr).Name}})
		lit, err := strconv.Atoi(m.getIdent(expr).Name)

		var x string = ""

		if known {
			x = VAR_PREFIX + ident.Name.Name
		}

		if err == nil {
			x = strconv.Itoa(lit)
		}

		prom_expr = &promela_ast.Ident{Name: x}
	case *ast.CallExpr:
		switch ident := expr.Fun.(type) {
		case *ast.Ident:
			if ident.Name == "len" || ident.Name == "int" {
				if len(expr.Args) > 0 {
					prom_expr = m.TranslateKnownExpr(expr.Args[0])
				}
			}
		}
	case *ast.BinaryExpr:

		if m.IsExprKnown(expr) {
			prom_expr = &promela_ast.BinaryExpr{Lhs: m.TranslateKnownExpr(expr.X), Rhs: m.TranslateKnownExpr(expr.Y), Op: expr.Op.String()}
		}
	}

	return prom_expr
}

func (m *Model) FlagCommParamAsAlias(expr ast.Expr) {
	switch expr := expr.(type) {
	case *ast.Ident, *ast.SelectorExpr:
		known, ident := ContainsCommParam(m.CommPars, &CommPar{Name: &ast.Ident{Name: m.getIdent(expr).Name}})

		if !known {
			panic("expr.go => All expr should be known")
		}
		ident.Alias = true
	case *ast.CallExpr:
		switch ident := expr.Fun.(type) {
		case *ast.Ident:
			if ident.Name == "len" || ident.Name == "int" {
				if len(expr.Args) > 0 {
					m.FlagCommParamAsAlias(expr.Args[0])
				}
			}
		}
	}
}