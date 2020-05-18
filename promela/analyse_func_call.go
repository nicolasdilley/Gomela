package promela

import (
	"go/ast"
	"go/token"

	"golang.org/x/tools/go/packages"
)

// Return the channels that are created in the scope of a function body's
func AnalyseFuncCall(fileSet *token.FileSet, fun *ast.FuncDecl, pack *packages.Package) []Chan_info {

	num_chans := []Chan_info{}
	ast.Inspect(fun.Body, func(n ast.Node) bool {
		switch n := n.(type) {
		case *ast.AssignStmt:
			for i, rhs := range n.Rhs {
				switch rhs := rhs.(type) {
				case *ast.CallExpr:
					switch ident := rhs.Fun.(type) {
					case *ast.Ident:
						if ident.Name == "make" && len(rhs.Args) > 0 { // possibly a new chan
							switch rhs.Args[0].(type) {
							case *ast.ChanType:
								num_chans = append(num_chans, Chan_info{Name: n.Lhs[i]})
							}
						}
					}
				}
			}
		case *ast.DeclStmt:
			switch decl := n.Decl.(type) {
			case *ast.GenDecl:
				for _, spec := range decl.Specs {
					switch spec := spec.(type) {
					case *ast.ValueSpec:
						for i, rhs := range spec.Values {
							switch call := rhs.(type) {
							case *ast.CallExpr:
								switch ident := call.Fun.(type) {
								case *ast.Ident:
									if ident.Name == "make" && len(call.Args) > 0 { // possibly a new chan
										switch call.Args[0].(type) {
										case *ast.ChanType:
											num_chans = append(num_chans, Chan_info{Name: spec.Names[i]})
										}
									}
								}
							}
						}
					}
				}
			}
		case *ast.GoStmt:
			return false
		}

		return true
	})

	// Add the chan parameter to the list
	for _, field := range fun.Type.Params.List {
		switch field.Type.(type) {
		case *ast.ChanType:
			for _, name := range field.Names {
				num_chans = append(num_chans, Chan_info{Name: name})
			}
		}
	}
	return num_chans
}
