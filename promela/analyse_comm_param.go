package promela

import (
	"go/ast"
	"go/token"
	"go/types"
	"strconv"

	"golang.org/x/tools/go/packages"
)

type CommPar struct {
	Name      *ast.Ident
	Mandatory bool
	Type      types.Type
	Pos       int // the position of the param in the fun decl (i.e, b is 0 and a is 1 in f(b,a))
}

// Return the parameters that are mandatory and optional
func (m *Model) AnalyseCommParam(pack string, fun *ast.FuncDecl, ast_map map[string]*packages.Package) []*CommPar {

	params := []*CommPar{}

	if fun.Body == nil {
		return params
	}

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
			mandatory := m.spawns(stmt.Body)

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
			// check if the call has a chan as param by looking at func decl

			contains_chan := false
			for _, arg := range stmt.Args {
				typ := ast_map[pack].TypesInfo.TypeOf(arg)

				switch typ.(type) {
				case *types.Chan:
					contains_chan = true
				}
			}
			fun_name := ""
			fun_pack := pack

			switch f := stmt.Fun.(type) {
			case *ast.Ident:
				fun_name = f.Name
			case *ast.SelectorExpr:
				fun_name = f.Sel.Name

				obj := ast_map[pack].TypesInfo.ObjectOf(f.Sel)
				if obj != nil {
					fun_pack = obj.Pkg().Name()
					if fun_pack == "sync" && f.Sel.Name == "Add" {
						params = m.Upgrade(fun, params, m.Vid(fun, stmt.Args[0], true)) // m.Upgrade the parameters with the variables contained in the bound of the for loop.
					}
				} else {
					fun_name = "UNKNOWN FUNCTION"
				}
			}

			// contains_chan := false
			// found, fun_decl := FindDecl(pack, fun, len(stmt.Args), ast_map)
			// if found {
			// 	for _, param := range fun_decl.Type.Params.List {
			// 		switch param.Type.(type) {
			// 		case *ast.ChanType:
			// 			contains_chan = true
			// 		}
			// 	}

			found, fun_decl := FindDecl(fun_pack, fun_name, len(stmt.Args), ast_map)

			if contains_chan && found {
				// look inter procedurally
				params_1 := m.AnalyseCommParam(pack, fun_decl, ast_map)

				for _, param := range params_1 { // m.upgrade all params with its respective arguments
					// give only the arguments that are either MP or OP
					// first apply m.Vid to extract all variables of the arguments
					params = m.Upgrade(fun_decl, params, m.Vid(fun_decl, stmt.Args[param.Pos], param.Mandatory))
				}
			}
			// }a
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
					params_1 := m.AnalyseCommParam(pack, fun_decl, ast_map)

					for _, param := range params_1 {
						// m.upgrade all params with its respective arguments
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
		} else {
			// if arg.Mandatory {
			m.Counters = append(m.Counters, Counter{
				Proj_name: m.Project_name,
				Fun:       m.Fun.Name.String(),
				Name:      "Candidate param",
				Info:      "Name : " + prettyPrint(arg.Name) + ", Mandatory : " + strconv.FormatBool(arg.Mandatory),
				Line:      m.Fileset.Position(arg.Name.Pos()).Line,
				Commit:    m.Commit,
				Filename:  m.Fileset.Position(arg.Name.Pos()).Filename,
			})

			// }
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
	case *ast.SliceExpr:
		return &ast.Ident{Name: getIdent(expr.X).Name, NamePos: expr.Pos()}
	case *ast.StarExpr:
		return &ast.Ident{Name: getIdent(expr.X).Name, NamePos: expr.Pos()}
	case *ast.KeyValueExpr:
		return &ast.Ident{Name: getIdent(expr.Key).Name, NamePos: expr.Pos()}
	case *ast.CompositeLit:
		name := "{"
		for _, elt := range expr.Elts {
			name += getIdent(elt).Name
		}
		name += "}"
		return &ast.Ident{Name: name, NamePos: expr.Pos()}
	case *ast.TypeAssertExpr:
		return &ast.Ident{Name: getIdent(expr.X).Name, NamePos: expr.Pos()}
	}

	return nil
}

// check if there is a goroutine spawned in one of the stmts (inter-procedural)

// If unknown function potentially ask user if spawning or not?
func (m *Model) spawns(stmts *ast.BlockStmt) bool {

	is_spawning := false
	ast.Inspect(stmts, func(stmt ast.Node) bool {
		switch stmt := stmt.(type) {
		case *ast.CallExpr:
			if m.isCallSpawning(stmt) {
				is_spawning = true
			}
		case *ast.GoStmt:
			if m.isCallSpawning(stmt.Call) {
				is_spawning = true
			}
			return false
		}

		return true
	})
	return is_spawning
}

func (m *Model) isCallSpawning(call_expr *ast.CallExpr) bool {
	contains_chan := false
	contains_wg := false
	is_spawning := false

	fun := ""
	fun_pack := m.Package
	// check if the goroutine or the call has a chan as param by looking at func decl
	switch f := call_expr.Fun.(type) {
	case *ast.Ident:
		fun = f.Name
	case *ast.SelectorExpr:
		// Check if its a call a Waitgroup call (Add(x))
		sel := m.AstMap[m.Package].TypesInfo.Selections[f]
		var obj types.Object
		if sel == nil {
			obj = m.AstMap[m.Package].TypesInfo.ObjectOf(f.Sel)
		} else {
			obj = sel.Obj()
		}
		if obj != nil {
			if obj.Pkg().Name() == "sync" {
				if f.Sel.Name == "Add" {
					return true
				}
			}

			fun_pack = obj.Pkg().Name()
		}
		fun = f.Sel.Name

	}

	for _, arg := range call_expr.Args {
		typ := m.AstMap[m.Package].TypesInfo.TypeOf(arg)
		switch typ := typ.(type) {
		case *types.Chan:
			contains_chan = true
		case *types.Pointer:
			switch typ := typ.Elem().(type) {
			case *types.Named:
				if typ.String() == "sync.WaitGroup" {
					contains_wg = true
				}
			}
		}
	}

	found, fun_decl := FindDecl(fun_pack, fun, len(call_expr.Args), m.AstMap)
	if found {
		if contains_chan || contains_wg {
			// look inter procedurally
			is_spawning = m.spawns(fun_decl.Body)
		}
	} else {
		if contains_chan || contains_wg {
			// what do we do when we can't find decl ?
			is_spawning = true
		}
	}

	return is_spawning
}
