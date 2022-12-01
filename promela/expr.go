package promela

import (
	"github.com/nicolasdilley/gomela/promela/promela_ast"
	"go/ast"
)

func (m *Model) IsExprKnown(expr ast.Expr) bool {

	isKnown := true

	ast.Inspect(expr, func(node ast.Node) bool {
		switch e := node.(type) {
		case *ast.BasicLit:
			isKnown = true
		case *ast.Ident:

			lhs, _ := ContainsCommParam(m.CommPars, &CommPar{Name: &ast.Ident{Name: m.getIdent(e).Name}})

			isKnown = lhs
		case *ast.SelectorExpr:
			lhs, _ := ContainsCommParam(m.CommPars, &CommPar{Name: &ast.Ident{Name: m.getIdent(e).Name}})

			isKnown = lhs

		case *ast.CallExpr:

			switch ident := e.Fun.(type) {
			case *ast.Ident:
				if ident.Name == "len" || ident.Name == "int" {
					if len(e.Args) > 0 {
						isKnown = m.IsExprKnown(e.Args[0])
						return false // don't look further into the the arguments
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
// Also returns a list of all comm par translated
func (m *Model) TranslateKnownExpr(expr ast.Expr) (promela_ast.Expr, []*CommPar) {
	var prom_expr promela_ast.Expr
	commPars := []*CommPar{}

	switch expr := expr.(type) {
	case *ast.BasicLit:
		prom_expr = &promela_ast.Ident{Name: expr.Value}
	case *ast.Ident, *ast.SelectorExpr:
		known, ident := ContainsCommParam(m.CommPars, &CommPar{Name: &ast.Ident{Name: m.getIdent(expr).Name}})

		var x string = ""

		if known {
			x = VAR_PREFIX + ident.Name.Name
		} else {
			panic("expr.go => Should be known!")
		}

		prom_expr = &promela_ast.Ident{Name: x}
		commPars = append(commPars, ident)
	case *ast.CallExpr:
		switch ident := expr.Fun.(type) {
		case *ast.Ident:
			if ident.Name == "len" || ident.Name == "int" {
				if len(expr.Args) > 0 {
					var params []*CommPar
					prom_expr, params = m.TranslateKnownExpr(expr.Args[0])
					commPars = append(commPars, params...)
				}
			}
		}
	case *ast.BinaryExpr:
		if m.IsExprKnown(expr) {
			lhs, params1 := m.TranslateKnownExpr(expr.X)

			commPars = append(commPars, params1...)
			rhs, params2 := m.TranslateKnownExpr(expr.Y)
			commPars = append(commPars, params2...)
			prom_expr = &promela_ast.BinaryExpr{Lhs: lhs, Rhs: rhs, Op: expr.Op.String()}
		}
	}

	return prom_expr, commPars
}

func (m *Model) FlagCommParamAsAlias(expr ast.Expr, originals []*CommPar) {
	switch expr := expr.(type) {
	case *ast.Ident, *ast.SelectorExpr:
		known, ident := ContainsCommParam(m.CommPars, &CommPar{Name: &ast.Ident{Name: m.getIdent(expr).Name}})

		if !known {
			panic("expr.go => All exprs should be known")
		}
		ident.Alias = true

		for _, commPar := range originals {
			if ident.Mandatory {
				commPar.Mandatory = true
			}
			if commPar.Mandatory {
				ident.Mandatory = true
			}
		}

	case *ast.CallExpr:
		switch ident := expr.Fun.(type) {
		case *ast.Ident:
			if ident.Name == "len" || ident.Name == "int" {
				if len(expr.Args) > 0 {
					m.FlagCommParamAsAlias(expr.Args[0], originals)
				}
			}
		}
	}
}