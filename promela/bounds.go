package promela

import (
	"go/ast"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

type Bounds struct {
	List []*Bound
}

type Bound struct {
	Name ast.Expr
	Var  promela_ast.Ident
	Val  int
}

func (b *Bounds) Contains(expr ast.Expr) (bool, promela_ast.Ident) {
	for _, val := range b.List {
		if IdenticalExpr(val.Name, expr) {
			return true, val.Var
		}
	}

	return false, promela_ast.Ident{Name: "0"}
}
