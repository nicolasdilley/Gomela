package promela

import (
	"go/ast"
	"go/token"

	"golang.org/x/tools/go/packages"
)

type CommPar struct {
	Name      *ast.Ident
	Mandatory bool
	Pos       int // the position of the param in the fun decl (i.e, b is 0 and a is 1 in f(b,a))
}

// Return the parameters that are mandatory and optional
func (m *Model) AnalyseCommParam(fileSet *token.FileSet, pack string, fun *ast.FuncDecl, ast_map map[string]*packages.Package) []*CommPar {
	params := []*CommPar{}

	ast.Inspect(fun.Body, func(stmt ast.Node) bool {
		switch stmt := stmt.(type) {
		case *ast.AssignStmt:
			for _, rhs := range stmt.Rhs {
				switch rhs := rhs.(type) {
				case *ast.CallExpr:
					switch ident := rhs.Fun.(type) {
					case *ast.Ident:
						if ident.Name == "make" && len(rhs.Args) > 0 { // possibly a new chan
							switch rhs.Args[0].(type) {
							case *ast.ChanType:
								// definitely a new chan
								if len(rhs.Args) > 1 {
									params = m.Upgrade(fun, params, m.Vid(fun, rhs.Args[1], true)) // m.Upgrade the parameters with the variables contained in the length of the chan.
								}
							}
						}
					}
				}
			}
		case *ast.DeclStmt:
			switch decl := stmt.Decl.(type) {
			case *ast.GenDecl:
				for _, spec := range decl.Specs {
					switch val := spec.(type) {
					case *ast.ValueSpec:
						for _, rhs := range val.Values {
							switch call := rhs.(type) {
							case *ast.CallExpr:
								switch ident := call.Fun.(type) {
								case *ast.Ident:
									if ident.Name == "make" && len(call.Args) > 0 { // possibly a new chan
										switch call.Args[0].(type) {
										case *ast.ChanType:
											// definitely a new chan
											if len(call.Args) > 1 {
												params = m.Upgrade(fun, params, m.Vid(fun, call.Args[1], true)) // m.Upgrade the parameters with the variables contained in the length of the chan.
											}
										}
									}
								}
							}
						}
					}
				}
			}

		case *ast.ForStmt:
			// check if the body of the for loop contains a spawn (inter-procedurally)
			mandatory := spawns(pack, stmt.Body, ast_map)

			switch cond := stmt.Cond.(type) { // i:= n;i > n;i--
			case *ast.BinaryExpr:
				if cond.Op == token.GEQ || cond.Op == token.GTR {
					switch inc := stmt.Post.(type) {
					case *ast.IncDecStmt:
						if inc.Tok == token.DEC {
							params = m.Upgrade(fun, params, m.Vid(fun, cond.Y, mandatory)) // m.Upgrade the parameters with the variables contained in the bound of the for loop.
						}
					}

				} else if cond.Op == token.LSS || cond.Op == token.LEQ { // i:= 0;i < n;i++
					switch inc := stmt.Post.(type) {
					case *ast.IncDecStmt:
						if inc.Tok == token.INC {
							params = m.Upgrade(fun, params, m.Vid(fun, cond.Y, mandatory)) // m.Upgrade the parameters with the variables contained in the bound of the for loop.
						}
					}
				}
			}
		case *ast.CallExpr: // m.Upgrade if the args of the function are mapped to a MP or OP
			fun := ""
			// check if the call has a chan as param by looking at func decl
			switch f := stmt.Fun.(type) {
			case *ast.Ident:
				fun = f.Name
			case *ast.SelectorExpr:

				if getIdent(f.X) != nil {
					fun = getIdent(f.X).Name
					pack = f.Sel.Name
				} else {
					fun = "UNKNOWN FUNCTION -1"
				}
			}

			contains_chan := false
			found, fun_decl := FindDecl(pack, fun, len(stmt.Args), ast_map)
			if found {
				for _, param := range fun_decl.Type.Params.List {
					switch param.Type.(type) {
					case *ast.ChanType:
						contains_chan = true
					}
				}

				if contains_chan {
					// look inter procedurally
					params_1 := m.AnalyseCommParam(fileSet, pack, fun_decl, ast_map)

					for _, param := range params_1 { // m.upgrade all params with its respective arguments
						// give only the arguments that are either MP or OP
						// first apply m.Vid to extract all variables of the arguments
						params = m.Upgrade(fun_decl, params, m.Vid(fun_decl, stmt.Args[param.Pos], param.Mandatory))
					}
				}
			}
		case *ast.GoStmt: // m.Upgrade if the args of the function are mapped to a MP or OP
			fun := ""
			// check if the call has a chan as param by looking at func decl
			switch f := stmt.Call.Fun.(type) {
			case *ast.Ident:
				fun = f.Name
			case *ast.SelectorExpr:
				fun = getIdent(f.X).Name
				pack = f.Sel.Name
			}
			contains_chan := false

			found, fun_decl := FindDecl(pack, fun, len(stmt.Call.Args), ast_map)

			if found {
				for _, param := range fun_decl.Type.Params.List {
					switch param.Type.(type) {
					case *ast.ChanType:
						contains_chan = true
					}
				}

				if contains_chan {
					// look inter procedurally
					params_1 := m.AnalyseCommParam(fileSet, pack, fun_decl, ast_map)

					for _, param := range params_1 { // m.upgrade all params with its respective arguments
						// give only the arguments that are either MP or OP
						// first apply m.Vid to extract all variables of the arguments
						params = m.Upgrade(fun_decl, params, m.Vid(fun_decl, stmt.Call.Args[param.Pos], param.Mandatory))
					}
				}
			}
		}
		return true
	})

	return params
}

// Takes a list of parameter (Used to get the position of the commPar in the
// fun_decl), two list of Commpar and updates the commPar mandatory with the one
// from args
func (m *Model) Upgrade(fun *ast.FuncDecl, commPars []*CommPar, args []*CommPar) []*CommPar {
	for _, arg := range args {
		if contains, param := containsArgs(fun.Type.Params.List, arg); contains {

			inCommPar := false
			for _, commPar := range commPars {
				if param.Name.Name == commPar.Name.Name {
					inCommPar = true
					if arg.Mandatory { // potentially m.upgrade
						commPar.Mandatory = true
					}
					break
				}
			}
			if !inCommPar { // if its not in the list of commPar yet add it.
				commPars = append(commPars, param)
			}
		}
	}
	return commPars
}

// Check if the arg is contained in the list params. Returns if it is and the commPar if it is
func containsArgs(fields []*ast.Field, arg *CommPar) (bool, *CommPar) {
	for x, field := range fields {
		for y, name := range field.Names {
			if name.Name == arg.Name.Name {
				return true, &CommPar{Name: name, Pos: x + y, Mandatory: arg.Mandatory}
			}
		}
	}
	return false, nil
}

func (m *Model) Vid(fun *ast.FuncDecl, expr ast.Expr, mandatory bool) []*CommPar {
	params := []*CommPar{}

	switch expr := expr.(type) {
	case *ast.Ident:
		params = m.Upgrade(fun, params, []*CommPar{&CommPar{Name: expr, Mandatory: mandatory}})
	case *ast.SelectorExpr:
		params = m.Upgrade(fun, params, []*CommPar{&CommPar{Name: getIdent(expr), Mandatory: mandatory}})

		ast.Inspect(expr, func(node ast.Node) bool {
			switch node := node.(type) {
			case *ast.CallExpr:
				// add the arguments
				for _, arg := range node.Args {
					params = m.Upgrade(fun, params, m.Vid(fun, arg, mandatory))
				}
			}

			return true
		})
	case *ast.CallExpr:
		for _, arg := range expr.Args {
			params = m.Upgrade(fun, params, m.Vid(fun, arg, mandatory))
		}

	case *ast.BinaryExpr:
		params = m.Upgrade(fun, params, m.Vid(fun, expr.X, mandatory))
		params = m.Upgrade(fun, params, m.Vid(fun, expr.Y, mandatory))
	case *ast.UnaryExpr:
		params = m.Upgrade(fun, params, m.Vid(fun, expr.X, mandatory))
	case *ast.ParenExpr:
		params = m.Upgrade(fun, params, m.Vid(fun, expr.X, mandatory))
	case *ast.StarExpr:
		params = m.Upgrade(fun, params, m.Vid(fun, expr.X, mandatory))
	case *ast.IndexExpr:
		params = m.Upgrade(fun, params, m.Vid(fun, expr.X, mandatory))
		params = m.Upgrade(fun, params, m.Vid(fun, expr.Index, mandatory))
	}

	return params
}

// takes an ident or a selector or funcall and returns its id
func getIdent(expr ast.Expr) *ast.Ident {
	switch expr := expr.(type) {
	case *ast.Ident:
		return expr
	case *ast.SelectorExpr:
		name := expr.Sel.Name + "_" + getIdent(expr.X).Name
		return &ast.Ident{Name: name, NamePos: expr.Pos()}
	case *ast.CallExpr:
		return &ast.Ident{Name: getIdent(expr.Fun).Name, NamePos: expr.Pos()}
	case *ast.BinaryExpr:
		return &ast.Ident{Name: getIdent(expr.X).Name + expr.Op.String() + getIdent(expr.Y).Name, NamePos: expr.Pos()}
	case *ast.UnaryExpr:
		return &ast.Ident{Name: expr.Op.String() + getIdent(expr.X).Name, NamePos: expr.Pos()}
	case *ast.IndexExpr:
		return &ast.Ident{Name: getIdent(expr.X).Name + "[" + getIdent(expr.Index).Name + "]"}
	case *ast.BasicLit:
		return &ast.Ident{Name: expr.Value}
	case *ast.ParenExpr:
		return &ast.Ident{Name: getIdent(expr.X).Name, NamePos: expr.Pos()}
	}
	return nil
}

// check if there is a goroutine spawned in one of the stmts (inter-procedural)

// If unknown function potentially ask userif spawning or not?
func spawns(pack string, stmts *ast.BlockStmt, ast_map map[string]*packages.Package) bool {

	contains_chan := false

	for _, stmt := range stmts.List {
		switch stmt := stmt.(type) {
		case *ast.GoStmt:
			fun := ""
			// check if the goroutine has a chan as param by looking at func decl
			switch f := stmt.Call.Fun.(type) {
			case *ast.Ident:
				fun = f.Name
			case *ast.SelectorExpr:
				fun = getIdent(f.X).Name
				pack = f.Sel.Name
			}
			found, fun_decl := FindDecl(pack, fun, len(stmt.Call.Args), ast_map)
			if found {
				for _, param := range fun_decl.Type.Params.List {
					switch param.Type.(type) {
					case *ast.ChanType:
						contains_chan = true
					}
				}

				if contains_chan {
					// look inter procedurally
					return spawns(pack, fun_decl.Body, ast_map)
				}
			} else {
				// what do we do when we can't find decl ?
				return true
			}
		}
	}

	return false
}
