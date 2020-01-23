package promela

import (
	"go/ast"
	"go/token"

	"golang.org/x/tools/go/packages"
)

func AnalyseFuncCall(fileSet *token.FileSet, fun *ast.FuncDecl, pack *packages.Package) []Chan_info {
	num_chans := []Chan_info{}
	ast.Inspect(fun.Body, func(n ast.Node) bool {
		switch s := n.(type) {
		case *ast.AssignStmt:
			for i, rhs := range s.Rhs {
				switch call := rhs.(type) {
				case *ast.CallExpr:
					switch ident := call.Fun.(type) {
					case *ast.Ident:
						if ident.Name == "make" && len(call.Args) > 0 { // possibly a new chan
							switch call.Args[0].(type) {
							case *ast.ChanType:
								num_chans = append(num_chans, Chan_info{Name: s.Lhs[i]})
							}
						}
					}
				}
			}
		case *ast.DeclStmt:
			switch decl := s.Decl.(type) {
			case *ast.GenDecl:
				for _, spec := range decl.Specs {
					switch val := spec.(type) {
					case *ast.ValueSpec:
						for i, rhs := range val.Values {
							switch call := rhs.(type) {
							case *ast.CallExpr:
								switch ident := call.Fun.(type) {
								case *ast.Ident:
									if ident.Name == "make" && len(call.Args) > 0 { // possibly a new chan
										switch call.Args[0].(type) {
										case *ast.ChanType:
											num_chans = append(num_chans, Chan_info{Name: val.Names[i]})
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
	return num_chans
}
