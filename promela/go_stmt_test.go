package promela

import (
	"go/ast"
	"testing"
)

// check if sub is contained in set (t, t.wg) > yes, (t.t, t.wg) > no, (t.t, t.t.wg) > Yes

func TestIsSubsetOfExpr(t *testing.T) {
	if !isSubsetOfExpr(&ast.Ident{Name: "t"}, &ast.SelectorExpr{X: &ast.Ident{Name: "t"}, Sel: &ast.Ident{Name: "wg"}}) {
		t.Error("result was incorrect, got: false, want: true")
	}

	if isSubsetOfExpr(&ast.SelectorExpr{X: &ast.Ident{Name: "t"}, Sel: &ast.Ident{Name: "t"}}, &ast.SelectorExpr{X: &ast.Ident{Name: "t"}, Sel: &ast.Ident{Name: "wg"}}) {
		t.Error("result was incorrect, got: true, want: false")
	}

	if !isSubsetOfExpr(&ast.SelectorExpr{X: &ast.Ident{Name: "t"}, Sel: &ast.Ident{Name: "t"}}, &ast.SelectorExpr{X: &ast.SelectorExpr{X: &ast.Ident{Name: "t"}, Sel: &ast.Ident{Name: "t"}}, Sel: &ast.Ident{Name: "wg"}}) {
		t.Error("result was incorrect, got: false, want: true")
	}
	if isSubsetOfExpr(&ast.Ident{Name: "u"}, &ast.SelectorExpr{X: &ast.Ident{Name: "t"}, Sel: &ast.Ident{Name: "wg"}}) {
		t.Error("result was incorrect, got: true, want: false")
	}
	if !isSubsetOfExpr(&ast.Ident{Name: "u"}, &ast.Ident{Name: "u_u_c"}) {
		t.Error("result was incorrect, got: false, want: true")
	}

}

//

func TestReplaceExpr(t *testing.T) {
	new_expr := replaceExpr(&ast.SelectorExpr{X: &ast.SelectorExpr{X: &ast.Ident{Name: "t"}, Sel: &ast.Ident{Name: "t"}}, Sel: &ast.Ident{Name: "wg"}}, &ast.Ident{Name: "t"}, &ast.Ident{Name: "s"})
	if !IdenticalExpr(new_expr, &ast.SelectorExpr{X: &ast.SelectorExpr{X: &ast.Ident{Name: "s"}, Sel: &ast.Ident{Name: "t"}}, Sel: &ast.Ident{Name: "wg"}}) {
		t.Error("result was incorrect, got: false, want: true")
	}

	new_expr = replaceExpr(&ast.SelectorExpr{X: &ast.SelectorExpr{X: &ast.Ident{Name: "t"}, Sel: &ast.Ident{Name: "t"}}, Sel: &ast.Ident{Name: "wg"}}, &ast.SelectorExpr{X: &ast.Ident{Name: "t"}, Sel: &ast.Ident{Name: "t"}}, &ast.Ident{Name: "s"})
	if !IdenticalExpr(new_expr, &ast.SelectorExpr{X: &ast.Ident{Name: "s"}, Sel: &ast.Ident{Name: "wg"}}) {
		t.Error("result was incorrect, got: false, want: true")
	}
}

func TestAddIdenticalSelectorExprs(t *testing.T) {

	exprs := []ast.Expr{&ast.SelectorExpr{X: &ast.SelectorExpr{X: &ast.Ident{Name: "t"}, Sel: &ast.Ident{Name: "a"}}, Sel: &ast.Ident{Name: "wg"}}, &ast.SelectorExpr{X: &ast.Ident{Name: "t"}, Sel: &ast.Ident{Name: "wg"}}}
	new_expr := addIdenticalSelectorExprs(exprs, &ast.SelectorExpr{X: &ast.Ident{Name: "t"}, Sel: &ast.Ident{Name: "a"}})
	if len(new_expr) != 1 {
		t.Error("result was incorrect, got: false, want: true")
	}

	exprs = []ast.Expr{&ast.SelectorExpr{X: &ast.SelectorExpr{X: &ast.Ident{Name: "t"}, Sel: &ast.Ident{Name: "t"}}, Sel: &ast.Ident{Name: "wg"}}, &ast.SelectorExpr{X: &ast.Ident{Name: "t"}, Sel: &ast.Ident{Name: "wg"}}}
	new_expr = addIdenticalSelectorExprs(exprs, &ast.SelectorExpr{X: &ast.Ident{Name: "t"}, Sel: &ast.Ident{Name: "t"}})
	if len(new_expr) != 1 {
		t.Error("result was incorrect, got: false, want: true")
	}

	exprs = []ast.Expr{&ast.SelectorExpr{X: &ast.SelectorExpr{X: &ast.Ident{Name: "s"}, Sel: &ast.Ident{Name: "t"}}, Sel: &ast.Ident{Name: "wg"}}, &ast.SelectorExpr{X: &ast.Ident{Name: "t"}, Sel: &ast.Ident{Name: "wg"}}}
	new_expr = addIdenticalSelectorExprs(exprs, &ast.SelectorExpr{X: &ast.SelectorExpr{X: &ast.Ident{Name: "t"}, Sel: &ast.Ident{Name: "t"}}, Sel: &ast.Ident{Name: "a"}})
	if len(new_expr) != 0 {
		t.Error("result was incorrect, got: false, want: true")
	}

	exprs = []ast.Expr{&ast.Ident{Name: "s_wg"}}
	new_expr = addIdenticalSelectorExprs(exprs, &ast.SelectorExpr{X: &ast.Ident{Name: "s"}, Sel: &ast.Ident{Name: "wg"}})
	if len(new_expr) != 1 {
		t.Error("result was incorrect, got: false, want: true")
	}
	exprs = []ast.Expr{&ast.Ident{Name: "t_wg"}}
	new_expr = addIdenticalSelectorExprs(exprs, &ast.Ident{Name: "t"})
	if len(new_expr) != 1 {
		t.Error("result was incorrect, got: false, want: true")
	}
	exprs = []ast.Expr{&ast.Ident{Name: "t"}}
	new_expr = addIdenticalSelectorExprs(exprs, &ast.Ident{Name: "t"})
	if len(new_expr) != 1 {
		t.Error("result was incorrect, got: false, want: true")
	}

	exprs = []ast.Expr{&ast.Ident{Name: "s_wg"}}
	new_expr = addIdenticalSelectorExprs(exprs, &ast.SelectorExpr{X: &ast.Ident{Name: "t"}, Sel: &ast.Ident{Name: "a"}})
	if len(new_expr) != 0 {
		t.Error("result was incorrect, got: false, want: true")
	}
}

func TestRenameBaseOfExprWithOther(t *testing.T) {

	new_expr := renameBaseOfExprWithOther(&ast.SelectorExpr{X: &ast.SelectorExpr{X: &ast.Ident{Name: "t"}, Sel: &ast.Ident{Name: "t"}}, Sel: &ast.Ident{Name: "wg"}},
		&ast.Ident{Name: "t"}, &ast.Ident{Name: "s"})
	if !IdenticalExpr(new_expr, &ast.SelectorExpr{X: &ast.SelectorExpr{X: &ast.Ident{Name: "s"}, Sel: &ast.Ident{Name: "t"}}, Sel: &ast.Ident{Name: "wg"}}) {
		t.Error("result was incorrect, got: false, want: true")
	}

	new_expr = renameBaseOfExprWithOther(&ast.SelectorExpr{X: &ast.SelectorExpr{X: &ast.Ident{Name: "t"}, Sel: &ast.Ident{Name: "t"}}, Sel: &ast.Ident{Name: "wg"}},
		&ast.SelectorExpr{X: &ast.Ident{Name: "t"}, Sel: &ast.Ident{Name: "t"}}, &ast.Ident{Name: "s"})
	if !IdenticalExpr(new_expr, &ast.SelectorExpr{X: &ast.Ident{Name: "s"}, Sel: &ast.Ident{Name: "wg"}}) {
		t.Error("result was incorrect, got: false, want: true")
	}

}
