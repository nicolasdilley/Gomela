package promela

import (
	"errors"
	"fmt"
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
	Expr      ast.Expr
	Pos       int // the position of the param in the fun decl (i.e, b is 0 and a is 1 in f(b,a))
	Candidate bool
}

// Return the parameters that are mandatory and optional
func (m *Model) AnalyseCommParam(pack string, fun *ast.FuncDecl, ast_map map[string]*packages.Package, log bool) ([]*CommPar, *ParseError) {

	params := []*CommPar{}
	var err *ParseError
	m.AddRecFunc(pack, fun.Name.Name)
	if fun.Body == nil {
		return params, err
	}

	ast.Inspect(fun.Body, func(stmt ast.Node) bool {
		switch stmt := stmt.(type) {

		case *ast.ForStmt:
			// check if the body of the for loop contains a spawn (inter-procedurally)

			mandatory := m.spawns(stmt.Body, log)
			switch cond := stmt.Cond.(type) { // i:= n;i > n;i--
			case *ast.BinaryExpr:
				if cond.Op == token.GEQ || cond.Op == token.GTR {
					switch inc := stmt.Post.(type) {
					case *ast.IncDecStmt:
						if inc.Tok == token.DEC {
							params = m.Upgrade(fun, params, m.Vid(fun, cond.Y, mandatory, log), log) // m.Upgrade the parameters with the variables contained in the bound of the for loop.
							// look for upper bound
							switch stmt := stmt.Init.(type) {
							case *ast.AssignStmt:
								for _, rh := range stmt.Rhs {
									params = m.Upgrade(fun, params, m.Vid(fun, rh, mandatory, log), log)
								}
							}

						}
					}

				} else if cond.Op == token.LSS || cond.Op == token.LEQ { // i:= 0;i < n;i++
					switch inc := stmt.Post.(type) {
					case *ast.IncDecStmt:
						if inc.Tok == token.INC {
							params = m.Upgrade(fun, params, m.Vid(fun, cond.Y, mandatory, log), log) // m.Upgrade the parameters with the variables contained in the bound of the for loop.

							// look for lower bound
							switch stmt := stmt.Init.(type) {
							case *ast.AssignStmt:
								for _, rh := range stmt.Rhs {
									params = m.Upgrade(fun, params, m.Vid(fun, rh, mandatory, log), log)
								}
							}
						}
					}
				}
			}
		case *ast.RangeStmt:
			mandatory := m.spawns(stmt.Body, log)

			switch m.AstMap[m.Package].TypesInfo.TypeOf(stmt.X).(type) {
			case *types.Chan:
				break
			default:
				params = m.Upgrade(fun, params, m.Vid(fun, stmt.X, mandatory, log), log)
			}
		case *ast.CallExpr: // m.Upgrade if the args of the function are mapped to a MP or OP
			// check if the call has a chan as param by looking at func decl
			switch ident := stmt.Fun.(type) {
			case *ast.Ident:
				if ident.Name == "make" && len(stmt.Args) > 0 { // possibly a new chan
					switch stmt.Args[0].(type) {
					case *ast.ChanType:
						// definitely a new chan
						if len(stmt.Args) > 1 {
							_, err1 := m.TranslateArg(stmt.Args[1])
							if err1 == nil {
								params = m.Upgrade(fun, params, m.Vid(fun, stmt.Args[1], true, log), log) // m.Upgrade the parameters with the variables contained in the bound of the for loop.
							}
						}
					}
				}
			}
			contains_chan := false
			for _, arg := range stmt.Args {
				typ := ast_map[m.Package].TypesInfo.TypeOf(arg)

				switch typ := typ.(type) {
				case *types.Chan:
					contains_chan = true
				case *types.Pointer:
					switch s := typ.Elem().(type) {
					case *types.Named:
						switch s := s.Underlying().(type) {
						case *types.Struct:
							for i := 0; i < s.NumFields(); i++ {
								switch field := s.Field(i).Type().(type) {
								case *types.Named:
									if field.Obj() != nil {
										if field.Obj().Pkg() != nil {
											if field.Obj().Pkg().Name() == "sync" {
												if field.Obj().Name() == "WaitGroup" {
													contains_chan = true
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
			fun_name := ""
			fun_pack := pack

			switch f := stmt.Fun.(type) {
			case *ast.Ident:
				fun_name = f.Name
			case *ast.SelectorExpr:
				fun_name = f.Sel.Name
				obj := ast_map[m.Package].TypesInfo.ObjectOf(f.Sel)
				if obj != nil {
					if obj.Pkg() != nil {
						fun_pack = obj.Pkg().Name()
						if fun_pack == "sync" && f.Sel.Name == "Add" {
							params = m.Upgrade(fun, params, m.Vid(fun, stmt.Args[0], true, log), log) // m.Upgrade the parameters with the variables contained in the bound of the for loop.
						}

					} else {
						fun_name = "UNKNOWN FUNCTION"
					}
				} else {
					fun_name = "UNKNOWN FUNCTION"
				}

			}
			if !m.ContainsRecFunc(fun_pack, fun_name) {
				if contains_chan {
					found, fun_decl, pack := m.FindDecl(stmt)
					if found {

						// check if contqins ellipsis arg

						for _, param := range fun_decl.Type.Params.List {
							switch param.Type.(type) {
							case *ast.Ellipsis:
								err = &ParseError{err: errors.New(ELLIPSIS + m.Fileset.Position(fun_decl.Pos()).String())}
								return false
							}
						}

						// look inter procedurally
						new_model := m.newModel(pack, fun_decl)
						new_model.RecFuncs = m.RecFuncs
						new_model.AddRecFunc(fun_pack, fun_name) // MAYBE THIS IS AN ERROR SO UNCOMMENT IF BUG

						params_1, err1 := new_model.AnalyseCommParam(pack, fun_decl, ast_map, log)

						if err1 != nil {
							err = err1
						}
						for _, param := range params_1 {
							// m.upgrade all params with its respective arguments
							// give only the arguments that are either MP or OP
							// first apply m.Vid to extract all variables of the arguments
							if !param.Candidate {
								params = m.Upgrade(fun, params, m.Vid(fun, stmt.Args[param.Pos], param.Mandatory, log), log)
							}
						}
					}
					// }
				}
			}
		case *ast.GoStmt: // m.Upgrade if the args of the function are mapped to a MP or OP
			fun_name := ""
			// check if the call has a chan as param by looking at func decl
			switch f := stmt.Call.Fun.(type) {
			case *ast.Ident:
				fun_name = f.Name
			case *ast.SelectorExpr:
				pack = m.getIdent(f.X).Name
				fun_name = f.Sel.Name
			}
			contains_chan := false

			found, fun_decl, pack := m.FindDecl(stmt.Call)

			if found {
				for _, param := range fun_decl.Type.Params.List {
					switch typ := param.Type.(type) {
					case *ast.ChanType:
						contains_chan = true
					case *ast.StarExpr:
						switch sel := typ.X.(type) {
						case *ast.SelectorExpr:
							if sel.Sel.Name == "WaitGroup" {
								switch sel := sel.X.(type) {
								case *ast.Ident:
									if sel.Name == "sync" {
										contains_chan = true
									}
								}
							}
						}
					}
				}

				if contains_chan {
					if !m.ContainsRecFunc(pack, fun_name) {

						// look inter procedurally
						new_model := m.newModel(pack, fun_decl)
						new_model.RecFuncs = m.RecFuncs
						// new_model.AddRecFunc(pack, fun) // MAYBE THIS IS AN ERROR SO UNCOMMENT IF BUG
						params_1, err1 := new_model.AnalyseCommParam(pack, fun_decl, ast_map, log)

						if err1 != nil {
							err = err1
						}
						for _, param := range params_1 {
							if !param.Candidate {

								// m.upgrade all params with its respective arguments
								// give only the arguments that are either MP or OP
								// first apply m.Vid to extract all variables of the arguments
								params = m.Upgrade(fun, params, m.Vid(fun_decl, stmt.Call.Args[param.Pos], param.Mandatory, log), log)
							}
						}
					}
				}
			}

			return false
		}
		return true
	})

	return params, err
}

// Takes a list of parameter (Used to get the position of the commPar in the
// fun_decl), two list of Commpar and updates the commPar mandatory with the one
// from args
func (m *Model) Upgrade(fun *ast.FuncDecl, commPars []*CommPar, args []*CommPar, log bool) []*CommPar {

	for _, arg := range args {
		if contains, param := containsArgs(fun.Type.Params.List, arg); contains {

			arg.Candidate = false
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
			arg.Candidate = true
			if found, param := ContainsCommParam(commPars, arg); !found {
				commPars = append(commPars, arg)
			} else {
				if arg.Mandatory {
					param.Mandatory = true
				}
			}
		}
	}

	return commPars
}

// Check if the arg is contained in the list params. Returns if it is and the commPar if it is
func containsArgs(fields []*ast.Field, arg *CommPar) (bool, *CommPar) {
	pos := 0
	for _, field := range fields {
		for _, name := range field.Names {

			if name.Name == arg.Name.Name {

				return true, &CommPar{Name: name, Pos: pos, Mandatory: arg.Mandatory, Expr: name}
			}
			pos++
		}
	}
	return false, nil
}

// Check if the arg is contained in the list params. Returns if it is and the commPar if it is
func ContainsCommParam(commPars []*CommPar, commPar *CommPar) (found bool, p *CommPar) {
	for _, param := range commPars {
		if param.Name.Name == commPar.Name.Name {
			return true, param
		}

	}
	return false, nil
}

func (m *Model) Vid(fun *ast.FuncDecl, expr ast.Expr, mandatory bool, log bool) []*CommPar {
	params := []*CommPar{}
	if con, _ := IsConst(expr, m.AstMap[m.Package]); con {
		return params
	}
	switch expr := expr.(type) {
	case *ast.Ident:
		params = m.Upgrade(fun, params, []*CommPar{&CommPar{Name: expr, Mandatory: mandatory, Expr: expr}}, log)
	case *ast.SelectorExpr:
		params = m.Upgrade(fun, params, []*CommPar{&CommPar{Name: m.getIdent(expr), Mandatory: mandatory, Expr: expr}}, log)

		ast.Inspect(expr, func(node ast.Node) bool {
			switch node := node.(type) {
			case *ast.CallExpr:
				// add the arguments
				for _, arg := range node.Args {
					params = m.Upgrade(fun, params, m.Vid(fun, arg, mandatory, log), log)
				}
			}

			return true
		})
	case *ast.CallExpr:
		switch ident := expr.Fun.(type) {
		case *ast.Ident:
			if ident.Name == "len" {
				if len(expr.Args) > 0 {
					params = m.Upgrade(fun, params, m.Vid(fun, expr.Args[0], mandatory, log), log)
					return params
				}
			} else if ident.Name == "int" {
				params = m.Upgrade(fun, params, m.Vid(fun, expr.Args[0], mandatory, log), log)
				return params
			}
		}
		name := &ast.Ident{Name: TranslateIdent(expr, m.Fileset).Name}
		params = m.Upgrade(fun, params, []*CommPar{&CommPar{Name: name, Mandatory: mandatory, Expr: name}}, log)
	case *ast.BinaryExpr:
		params = m.Upgrade(fun, params, m.Vid(fun, expr.X, mandatory, log), log)
		params = m.Upgrade(fun, params, m.Vid(fun, expr.Y, mandatory, log), log)
	case *ast.UnaryExpr:
		params = m.Upgrade(fun, params, m.Vid(fun, expr.X, mandatory, log), log)
	case *ast.ParenExpr:
		params = m.Upgrade(fun, params, m.Vid(fun, expr.X, mandatory, log), log)
	case *ast.StarExpr:
		params = m.Upgrade(fun, params, m.Vid(fun, expr.X, mandatory, log), log)
	}

	return params
}

// takes an ident or a selector or funcall and returns its id
func (m *Model) getIdent(expr ast.Expr) *ast.Ident {
	switch expr := expr.(type) {
	case *ast.Ident:
		return expr
	case *ast.SelectorExpr:
		name := m.getIdent(expr.X).Name + "_" + expr.Sel.Name
		return &ast.Ident{Name: name, NamePos: expr.Pos()}
	case *ast.CallExpr:
		return &ast.Ident{Name: m.getIdent(expr.Fun).Name, NamePos: expr.Pos()}
	case *ast.BinaryExpr:
		return &ast.Ident{Name: m.getIdent(expr.X).Name + expr.Op.String() + m.getIdent(expr.Y).Name, NamePos: expr.Pos()}
	case *ast.UnaryExpr:
		return &ast.Ident{Name: expr.Op.String() + m.getIdent(expr.X).Name, NamePos: expr.Pos()}
	case *ast.IndexExpr:
		return &ast.Ident{Name: m.getIdent(expr.X).Name + "L" + m.getIdent(expr.Index).Name + "L"}
	case *ast.BasicLit:
		return &ast.Ident{Name: expr.Value}
	case *ast.ParenExpr:
		return &ast.Ident{Name: m.getIdent(expr.X).Name, NamePos: expr.Pos()}
	case *ast.SliceExpr:
		return &ast.Ident{Name: m.getIdent(expr.X).Name, NamePos: expr.Pos()}
	case *ast.StarExpr:
		return &ast.Ident{Name: m.getIdent(expr.X).Name, NamePos: expr.Pos()}
	case *ast.ChanType:
		return &ast.Ident{Name: fmt.Sprint(expr.Value), NamePos: expr.Pos()}
	case *ast.FuncLit:
		m.PrintFeature(Feature{
			Proj_name: m.Project_name,
			Fun:       m.Fun.Name.String(),
			Name:      "Anonymous function as ident",
			Mandatory: "false",
			Info:      "Unsupported",
			Line:      m.Fileset.Position(expr.Pos()).Line,
			Commit:    m.Commit,
			Filename:  m.Fileset.Position(expr.Pos()).Filename,
		})
		return &ast.Ident{Name: "UNSUPPORTED", NamePos: expr.Pos()}
	case *ast.FuncType:
		m.PrintFeature(Feature{
			Proj_name: m.Project_name,
			Fun:       m.Fun.Name.String(),
			Name:      "High order function",
			Mandatory: "false",
			Info:      "Unsupported",
			Line:      m.Fileset.Position(expr.Pos()).Line,
			Commit:    m.Commit,
			Filename:  m.Fileset.Position(expr.Pos()).Filename,
		})
		return &ast.Ident{Name: "UNSUPPORTED", NamePos: expr.Pos()}
	case *ast.KeyValueExpr:
		return &ast.Ident{Name: m.getIdent(expr.Key).Name, NamePos: expr.Pos()}
	case *ast.CompositeLit:
		name := "{"
		for _, elt := range expr.Elts {
			name += m.getIdent(elt).Name
		}
		name += "}"
		return &ast.Ident{Name: name, NamePos: expr.Pos()}
	case *ast.TypeAssertExpr:
		return &ast.Ident{Name: m.getIdent(expr.X).Name, NamePos: expr.Pos()}
	case *ast.ArrayType:
		return &ast.Ident{Name: fmt.Sprint(expr.Elt), NamePos: expr.Pos()}
	case *ast.MapType:
		return &ast.Ident{Name: fmt.Sprint(expr.Value), NamePos: expr.Pos()}
	}

	return nil
}

// check if there is a goroutine spawned in one of the stmts (inter-procedural)

// If unknown function potentially ask user if spawning or not?
func (m *Model) spawns(stmts *ast.BlockStmt, log bool) bool {

	is_spawning := false

	var call ast.Node
	recursive := false
	ast.Inspect(stmts, func(stmt ast.Node) bool {
		switch stmt := stmt.(type) {
		case *ast.CallExpr:
			if recur, call_spawning := m.isCallSpawning(stmt, log); call_spawning {
				if recur {
					recursive = true
					call = stmt
				}
				is_spawning = true
			}
		case *ast.GoStmt:

			switch stmt.Call.Fun.(type) {
			case *ast.FuncLit:
				is_spawning = true
			default:
				contains_chan := false
				contains_wg := false
				// check if the goroutine has a chan as param by looking at func decl

				for _, arg := range stmt.Call.Args {
					typ := m.AstMap[m.Package].TypesInfo.TypeOf(arg)
					switch typ := typ.(type) {
					case *types.Chan:
						contains_chan = true
					case *types.Pointer:
						switch typ := typ.Elem().(type) {
						case *types.Named:
							if typ.String() == "sync.WaitGroup" || typ.String() == "sync.Mutex" {
								contains_wg = true
							}
						}
					}
				}

				if contains_chan || contains_wg {
					is_spawning = true
				}
				recur, _ := m.isCallSpawning(stmt.Call, log)
				if recur {
					recursive = true
					call = stmt
				}

				return false
			}
		}

		return true

	})

	if recursive && log {
		m.PrintFeature(Feature{
			Proj_name: m.Project_name,
			Fun:       m.Fun.Name.String(),
			Name:      "Recursive call",
			Mandatory: strconv.FormatBool(is_spawning),
			Info:      "Spawning : " + strconv.FormatBool(is_spawning),
			Line:      m.Fileset.Position(call.Pos()).Line,
			Commit:    m.Commit,
			Filename:  m.Fileset.Position(call.Pos()).Filename,
		})

	}
	return is_spawning
}

func (m *Model) isCallSpawning(call_expr *ast.CallExpr, log bool) (recursive bool, call_spawning bool) {
	contains_chan := false
	contains_wg := false
	call_spawning = false
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
		if obj != nil && obj.Pkg() != nil {
			if obj.Pkg().Name() == "sync" {
				if f.Sel.Name == "Add" {
					return false, true
				}
			}

			fun_pack = obj.Pkg().Name()
		}
		fun = f.Sel.Name

	}

	if contains, spawning_func := m.ContainsSpawningFunc(fun_pack, fun); !contains {
		for _, arg := range call_expr.Args {
			typ := m.AstMap[m.Package].TypesInfo.TypeOf(arg)
			switch typ := typ.(type) {
			case *types.Chan:
				contains_chan = true
			case *types.Pointer:
				switch typ := typ.Elem().(type) {
				case *types.Named:
					if typ.String() == "sync.WaitGroup" || typ.String() == "sync.Mutex" {
						contains_wg = true
					}
				}
			}
		}

		spawning_func := &SpawningFunc{Rec_func: RecFunc{Name: fun, Pkg: fun_pack}}
		m.SpawningFuncs = append(m.SpawningFuncs, spawning_func)
		if contains_chan || contains_wg && fun != "len" {
			found, fun_decl, _ := m.FindDecl(call_expr)

			if found {
				// look inter procedurally
				call_spawning = m.spawns(fun_decl.Body, log)
				spawning_func.is_spawning = call_spawning

				// add the call we have just analysed. to the spawning calls
			} else {

				// what do we do when we can't find decl ?
				call_spawning = true
			}
		} else {
			spawning_func.is_spawning = false
		}
	} else {
		recursive = true
		call_spawning = spawning_func.is_spawning
	}

	return recursive, call_spawning
}

func (m *Model) ContainsSpawningFunc(pack string, fun_name string) (bool, *SpawningFunc) {
	for _, fun := range m.SpawningFuncs {
		if fun.Rec_func.Name == fun_name && fun.Rec_func.Pkg == pack {
			return true, fun
		}
	}

	return false, nil
}

func isConstant(expr ast.Expr) string {
	var value string = "not found"
	switch ident := expr.(type) {
	case *ast.Ident:
		if ident.Obj != nil {
			if ident.Obj.Kind == ast.Con {
				switch value_spec := ident.Obj.Decl.(type) {
				case *ast.ValueSpec:

					if value_spec.Values != nil && len(value_spec.Values) > 0 {
						switch val := value_spec.Values[0].(type) {
						case *ast.BasicLit:
							return val.Value
						case *ast.Ident:
							return isConstant(val)
						}
					}
				}
			}
		}
	case *ast.SelectorExpr:
		return isConstant(ident.Sel)
	case *ast.BasicLit:
		if ident.Kind == token.INT {
			return ident.Value
		}
	}

	return value
}
