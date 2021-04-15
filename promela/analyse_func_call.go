package promela

import (
	"go/ast"
	"go/token"

	"golang.org/x/tools/go/packages"
)

// Return the channels and the waitgroups that are created in the scope of a function body's until call_expr is reached
func AnalyseFuncCall(fileSet *token.FileSet, fun *ast.FuncDecl, call_expr *ast.CallExpr, pack *packages.Package) (chans []ast.Expr, wgs []ast.Expr) {

	chans = []ast.Expr{}
	wgs = []ast.Expr{}

	call_expr_reached := false
	ast.Inspect(fun.Body, func(n ast.Node) bool {

		if !call_expr_reached {
			switch n := n.(type) {
			case *ast.CallExpr:
				if call_expr == n {
					call_expr_reached = true
				}
			case *ast.AssignStmt:
				c1, w1 := AnalyseNewVar(n, n.Lhs, n.Rhs, pack)
				chans = append(chans, c1...)
				wgs = append(wgs, w1...)
			case *ast.DeclStmt:
				switch decl := n.Decl.(type) {
				case *ast.GenDecl:
					for _, spec := range decl.Specs {
						switch spec := spec.(type) {
						case *ast.ValueSpec:
							exprs := []ast.Expr{}

							for _, name := range spec.Names {
								exprs = append(exprs, name)
							}

							c1, w1 := AnalyseNewVar(n, exprs, spec.Values, pack)
							chans = append(chans, c1...)
							wgs = append(wgs, w1...)
							for i, rhs := range spec.Values {
								switch call := rhs.(type) {

								case *ast.CallExpr:
									switch ident := call.Fun.(type) {
									case *ast.Ident:
										if ident.Name == "make" && len(call.Args) > 0 { // possibly a new chan
											switch call.Args[0].(type) {
											case *ast.ChanType:

												chans = append(chans, spec.Names[i])
											}
										}
									}
								}
							}

							switch sel := spec.Type.(type) {
							case *ast.StarExpr:
								spec.Type = sel.X
							}
							// check if its the declaration of a WG
							switch sel := spec.Type.(type) {
							case *ast.SelectorExpr:
								if sel.Sel.Name == "WaitGroup" {
									switch sel := sel.X.(type) {
									case *ast.Ident:
										if sel.Name == "sync" {
											// we have a waitgroup
											for _, name := range spec.Names {
												wgs = append(wgs, name)
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
		return !call_expr_reached
	})

	// Add the chan parameter to the list
	for _, field := range fun.Type.Params.List {
		switch field.Type.(type) {
		case *ast.ChanType:
			for _, name := range field.Names {
				chans = append(chans, name)
			}
		}
	}

	return chans, wgs
}

func AnalyseNewVar(s ast.Stmt, lhs []ast.Expr, rhs []ast.Expr, pack *packages.Package) (chans []ast.Expr, wgs []ast.Expr) {
	chans = []ast.Expr{}
	wgs = []ast.Expr{}

	for i, r := range rhs {
		switch r := r.(type) {
		case *ast.UnaryExpr:
			rhs[i] = r.X
		}
	}

	for i, rhs := range rhs {
		switch rhs := rhs.(type) {
		case *ast.CallExpr:
			switch ident := rhs.Fun.(type) {
			case *ast.Ident:
				if ident.Name == "make" && len(rhs.Args) > 0 { // possibly a new chan
					switch rhs.Args[0].(type) {
					case *ast.ChanType:
						chans = append(chans, lhs[i])
					}
				} else if ident.Name == "new" && len(rhs.Args) > 0 {
					// check if its the decleration of a new sync.Waitgroup

					expr := rhs.Args[0]

					switch p := rhs.Args[0].(type) {
					case *ast.StarExpr:
						expr = p.X
					}

					switch expr := expr.(type) {
					case *ast.SelectorExpr:
						if expr.Sel.Name == "WaitGroup" {
							switch expr := expr.X.(type) {
							case *ast.Ident:
								if expr.Name == "sync" {
									wgs = append(wgs, lhs[i])
								}
							}
						}
					}
				}
			case *ast.SelectorExpr:
				if ident.Sel.Name == "WaitGroup" {
					switch sel := ident.X.(type) {
					case *ast.Ident:
						if sel.Name == "sync" {
							// we have a waitgroup
							if len(lhs) > i {
								wgs = append(wgs, lhs[i])
							}
						}
					}
				}
			}
		case *ast.CompositeLit:
			switch sel := rhs.Type.(type) {
			case *ast.SelectorExpr:
				if sel.Sel.Name == "WaitGroup" {
					switch sel := sel.X.(type) {
					case *ast.Ident:
						if sel.Name == "sync" {
							// we have a waitgroup
							for _, name := range lhs {
								wgs = append(wgs, name)
							}
						}
					}
				}
			}
		}
	}
	return chans, wgs
}
