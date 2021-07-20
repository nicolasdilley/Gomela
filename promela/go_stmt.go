package promela

import (
	"bytes"
	"errors"
	"fmt"
	"sort"
	"strconv"
	"strings"

	"go/ast"
	"go/printer"
	"go/token"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
	"github.com/nicolasdilley/gomela/promela/promela_types"
)

func (m *Model) TranslateGoStmt(s *ast.GoStmt, isMain bool) (b *promela_ast.BlockStmt, err *ParseError) {
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}

	var func_name string // The corresponding promela function name consisting of package + fun + num of param + len(proctypes)
	var pack_name string
	call_expr := s.Call

	// First generate list of params (ParamList) and arguments to the run stmt
	var decl *ast.FuncDecl
	var new_call_expr *ast.CallExpr

	if isMain {
		decl = m.Fun
		pack_name = m.Package
		new_call_expr = s.Call
	} else {
		var pack string
		var err1 *ParseError

		decl, new_call_expr, pack, err1 = m.findFunDecl(call_expr)

		pack_name = pack
		if err1 != nil {
			return b, err1
		}
	}

	if decl != nil {

		// Check if we have not seen it already !

		// check if its a call on a struct that contains a chan, mutex or wgs

		func_name = decl.Name.Name + fmt.Sprint(m.Fileset.Position(decl.Pos()).Line)

		new_mod := m.newModel(pack_name, decl)

		var err1 *ParseError
		new_mod.CommPars, err1 = new_mod.AnalyseCommParam(pack_name, decl, m.AstMap, false) // recover the commPar
		//. Create a define for each mandatory param

		if err1 != nil {
			return b, err1
		}
		params, args, hasChan, known, err2 := m.translateParams(new_mod, decl, new_call_expr, isMain)

		// translate args
		if err2 != nil {
			return b, err2
		}
		if hasChan && known {
			return m.translateCommParams(new_mod, true, new_call_expr, func_name, decl, params, args, isMain)

		}
	} else { // Could not find the decl of the function
		// So lets check if it takes a receive as an arg
		for _, arg := range call_expr.Args {

			stmt, err1 := m.TranslateExpr(arg)

			if err1 == nil {
				for _, e := range stmt.List {
					switch e := e.(type) {
					case *promela_ast.RcvStmt:

						b.List = append(b.List, e)
					}
				}
			} else {
				return b, err1
			}
		}
	}

	return b, err
}

// s can be either the go stmt or the call expr
func (m *Model) translateCommParams(new_mod *Model, isGo bool, call_expr *ast.CallExpr, func_name string, decl *ast.FuncDecl, params []*promela_ast.Param, args []promela_ast.Expr, isMain bool) (*promela_ast.BlockStmt, *ParseError) {

	b := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	prom_call := &promela_ast.CallExpr{Fun: &promela_ast.Ident{Name: func_name}, Call: m.Fileset.Position(call_expr.Pos())}

	prom_call.Args = args
	proc := &promela_ast.Proctype{
		Name:   &promela_ast.Ident{Name: func_name},
		Pos:    m.Fileset.Position(call_expr.Pos()),
		Active: false,
		Body:   &promela_ast.BlockStmt{List: []promela_ast.Stmt{}},
		Params: params,
		Decl:   decl,
	}

	// Parses the args
	for _, commPar := range new_mod.CommPars {
		name := "Actual Param"
		if commPar.Candidate {
			name = "Candidate Param"

			var_name := commPar.Name.Name

			if _, err := strconv.Atoi(var_name); err != nil {
				var_name = "var_" + var_name
			}
			if commPar.Mandatory {
				def := m.GenerateDefine(commPar) // generate the define statement out of the commpar

				proc.Body.List = append([]promela_ast.Stmt{&promela_ast.CommParamDeclStmt{Name: &promela_ast.Ident{Name: var_name}, Mandatory: true, Rhs: &promela_ast.Ident{Name: def}, Types: promela_types.Int}}, proc.Body.List...)
			} else {
				proc.Body.List = append([]promela_ast.Stmt{&promela_ast.CommParamDeclStmt{Name: &promela_ast.Ident{Name: var_name}, Mandatory: false, Rhs: &promela_ast.Ident{Name: OPTIONAL_BOUND}, Types: promela_types.Int}}, proc.Body.List...)
			}
		} else {
			proc.Params = append(proc.Params, &promela_ast.Param{Name: commPar.Name.Name, Types: promela_types.Int})

			arg, err1 := m.TranslateArg(call_expr.Args[commPar.Pos])

			if err1 != nil {
				return b, err1
			}
			if found, _ := ContainsCommParam(m.CommPars, &CommPar{Name: &ast.Ident{Name: TranslateIdent(call_expr.Args[commPar.Pos], m.Fileset).Name}}); found && err1 == nil {
				prom_call.Args = append(prom_call.Args, arg)
			} else { // the arguments passed as a commparam cannot be translated

				var ident *promela_ast.Ident
				if call_expr.Args[commPar.Pos] != nil {
					ident = &promela_ast.Ident{Name: "not_found_" + strconv.Itoa(m.Fileset.Position(call_expr.Pos()).Line)}
				} else {

					var_name := commPar.Name.Name

					if _, err := strconv.Atoi(var_name); err != nil {
						var_name = "var_" + var_name
					}
					ident = &promela_ast.Ident{Name: var_name}
				}

				rhs := ""
				if commPar.Mandatory {
					rhs = DEFAULT_BOUND + " // mand "
				} else {
					rhs = OPTIONAL_BOUND + " // opt "
				}

				var buff *bytes.Buffer = bytes.NewBuffer([]byte{})
				printer.Fprint(buff, m.Fileset, commPar.Expr)
				rhs += string(buff.Bytes()) + " line " + strconv.Itoa(m.Fileset.Position(commPar.Expr.Pos()).Line)

				m.Defines = append(m.Defines, promela_ast.DefineStmt{Name: ident, Rhs: &promela_ast.Ident{Name: rhs}})
				prom_call.Args = append(prom_call.Args, ident)
			}

		}

		m.PrintFeature(Feature{
			Proj_name: m.Project_name,
			Model:     m.Name,
			Fun:       new_mod.Fun.Name.String(),
			Name:      name,
			Mandatory: fmt.Sprint(commPar.Mandatory),
			Info:      commPar.Name.Name,
			Line:      0,
			Commit:    m.Commit,
			Filename:  m.Fileset.Position(m.Fun.Pos()).Filename,
		})
	}

	exist, err1 := m.CallExists(decl)

	if err1 != nil {
		return b, err1
	}

	if !exist { // add the new proctype if the call doesnt exists yet

		new_mod.Proctypes = append(new_mod.Proctypes, proc)

		stmt, defers, err1 := new_mod.TranslateBlockStmt(decl.Body)

		if err1 != nil {
			return b, err1
		}

		proc.Body.List = append(proc.Body.List, stmt.List...)
		for i, j := 0, len(defers.List)-1; i < j; i, j = i+1, j-1 {
			defers.List[i], defers.List[j] = defers.List[j], defers.List[i]
		}
		proc.Body.List = append(proc.Body.List, defers.List...)

		proc.Body.List = append(proc.Body.List, &promela_ast.LabelStmt{Name: "stop_process"})

	}
	prom_call.Fun = &promela_ast.Ident{Name: func_name, Ident: m.Fileset.Position(call_expr.Pos())}

	m.addNewProctypes(new_mod) // adding the new proctypes create in the new model

	m.ContainsChan = m.ContainsChan || new_mod.ContainsChan
	m.ContainsWg = m.ContainsWg || new_mod.ContainsWg
	m.ContainsMutexes = m.ContainsMutexes || new_mod.ContainsMutexes

	child_func_name := "child_" + func_name + strconv.Itoa(m.Counter)
	prom_call.Args = append(prom_call.Args, &promela_ast.Ident{Name: child_func_name})
	// add child param
	proc.Params = append(proc.Params, &promela_ast.Param{Name: "child", Types: promela_types.Chan})
	m.Counter++

	b.List = append(b.List,
		&promela_ast.Chandef{Name: &promela_ast.Ident{Name: child_func_name}, Size: &promela_ast.Ident{Name: "1"}, Types: []promela_types.Types{promela_types.Int}},
		&promela_ast.RunStmt{X: prom_call},
	)
	proc.Body.List = append(proc.Body.List, &promela_ast.SendStmt{Chan: &promela_ast.Ident{Name: "child"}, Rhs: &promela_ast.Ident{Name: "0"}})
	if !isGo {

		b.List = append(b.List, &promela_ast.RcvStmt{Chan: &promela_ast.Ident{Name: child_func_name}, Rhs: &promela_ast.Ident{Name: "0"}})
	} else {
		// Add the receiver call
		b.List = append(b.List, &promela_ast.RunStmt{
			X: &promela_ast.CallExpr{
				Fun: &promela_ast.Ident{
					Name: "receiver"},
				Args: []promela_ast.Expr{&promela_ast.Ident{Name: child_func_name}}}})
		m.ContainsReceiver = true
	}

	if isMain {
		m.Chans = new_mod.Chans
		m.WaitGroups = new_mod.WaitGroups
		m.Mutexes = new_mod.Mutexes
	}

	return b, nil
}

func (m *Model) translateParams(new_mod *Model, decl *ast.FuncDecl, call_expr *ast.CallExpr, isMain bool) ([]*promela_ast.Param, []promela_ast.Expr, bool, bool, *ParseError) {
	hasChan := isMain
	known := true
	params := []*promela_ast.Param{}
	args := []promela_ast.Expr{}

	counter := 0

	for _, field := range decl.Type.Params.List {
		for _, name := range field.Names {
			t := field.Type
			switch sel := field.Type.(type) {
			case *ast.StarExpr:
				t = sel.X
			}
			switch sel := t.(type) {
			case *ast.ChanType:
				hasChan = true

				if m.containsChan(call_expr.Args[counter]) {
					chan_name := name.Name + CHAN_NAME
					params = append(params, &promela_ast.Param{Name: chan_name, Types: promela_types.Chandef})
					new_mod.Chans[name] = &ChanStruct{Name: &promela_ast.Ident{Name: chan_name}, Chan: m.Fileset.Position(name.Pos())}

					ch := m.getChanStruct(call_expr.Args[counter])

					args = append(args, ch.Name)
				} else {
					known = false
				}
			case *ast.SelectorExpr:
				switch ident := sel.X.(type) {
				case *ast.Ident:
					if ident.Name == "sync" {
						if sel.Sel.Name == "WaitGroup" {
							hasChan = true
							if m.containsWaitgroup(call_expr.Args[counter]) {
								wg := &WaitGroupStruct{Name: &promela_ast.Ident{Name: name.Name, Ident: m.Fileset.Position(name.Pos())}, Wait: m.Fileset.Position(name.Pos())}
								params = append(params, &promela_ast.Param{Name: name.Name, Types: promela_types.Wgdef})
								new_mod.WaitGroups[name] = wg
								arg, err1 := m.TranslateArg(call_expr.Args[counter])
								if err1 != nil {
									return params, args, false, false, err1
								}
								args = append(args, arg)
							} else {
								known = false
							}
						} else if sel.Sel.Name == "Mutex" {
							hasChan = true
							if m.containsMutex(call_expr.Args[counter]) {
								new_mod.Mutexes = append(new_mod.Mutexes, name)
								params = append(params, &promela_ast.Param{Name: name.Name, Types: promela_types.Mutexdef})

								arg, err1 := m.TranslateArg(call_expr.Args[counter])
								if err1 != nil {
									return params, args, false, false, err1
								}
								args = append(args, arg)

							} else {
								known = false
							}
						}
					}

				}
			}

			counter++
		}
	}

	return params, args, hasChan, known, nil
}

// func (m *Model) GenerateParamAndArg(arg ast.Expr, t promela_types.Types) ([]*promela_ast.Param, []promela_ast.Expr) {
// 	name := translateIdent(arg).Name
// 	p := &promela_ast.Param{Name: name, Pos: m.Fileset.Position(arg.Pos()), Types: t}
// 	e := &promela_ast.Ident{Name: name}

// 	return p, e
// }

func (m *Model) findFunDecl(call_expr *ast.CallExpr) (*ast.FuncDecl, *ast.CallExpr, string, *ParseError) {
	pack_name := m.Package

	switch name := call_expr.Fun.(type) {
	case *ast.FuncLit: // in the case we have an anonymous func call
		fun_decl := &ast.FuncDecl{Body: &ast.BlockStmt{List: []ast.Stmt{}}, Type: &ast.FuncType{Params: &ast.FieldList{List: append([]*ast.Field{}, name.Type.Params.List...)}}}
		func_name := fmt.Sprint("Anonymous", m.Fun.Name.Name, m.Fileset.Position(name.Pos()).Line)
		ident := &ast.Ident{Name: func_name, NamePos: name.Pos()}
		fun_decl.Name = ident
		fun_decl.Body = name.Body

		names := []*ast.Ident{} // the names of the chans

		var exprs []ast.Expr

		new_call_expr := *call_expr
		new_call_expr.Args = append([]ast.Expr{}, call_expr.Args...)
		for _, arg := range new_call_expr.Args { // Remove the potential pointers
			switch arg := arg.(type) {
			case *ast.UnaryExpr:
				exprs = append(exprs, arg.X)
			default:
				exprs = append(exprs, arg)
			}
		}

		for ch, _ := range m.Chans {
			if !containsExpr(new_call_expr.Args, ch) {
				chan_name := TranslateIdent(ch, m.Fileset)
				names = append(names, &ast.Ident{Name: chan_name.Name, NamePos: ch.Pos()})
				new_call_expr.Args = append(new_call_expr.Args, ch)
			}
		}
		if len(names) > 0 {
			fun_decl.Type.Params.List = append(fun_decl.Type.Params.List, &ast.Field{Names: names, Type: &ast.ChanType{Value: &ast.Ident{Name: "int"}}})
		}
		wg_names := []*ast.Ident{}

		for wg, _ := range m.WaitGroups {
			if !containsExpr(exprs, wg) {
				wg_names = append(wg_names, &ast.Ident{Name: TranslateIdent(wg, m.Fileset).Name, NamePos: wg.Pos()})
				new_call_expr.Args = append(new_call_expr.Args, wg)
			}
		}

		if len(wg_names) > 0 {
			fun_decl.Type.Params.List = append(fun_decl.Type.Params.List, &ast.Field{
				Names: wg_names,
				Type: &ast.StarExpr{X: &ast.SelectorExpr{X: &ast.Ident{Name: "sync"},
					Sel: &ast.Ident{Name: "WaitGroup"}}}})
		}

		mu_names := []*ast.Ident{}

		for _, mu := range m.Mutexes {
			if !containsExpr(exprs, mu) {
				mu_names = append(mu_names, &ast.Ident{Name: TranslateIdent(mu, m.Fileset).Name, NamePos: mu.Pos()})
				new_call_expr.Args = append(new_call_expr.Args, mu)
			}
		}

		if len(mu_names) > 0 {
			fun_decl.Type.Params.List = append(fun_decl.Type.Params.List, &ast.Field{
				Names: mu_names,
				Type: &ast.StarExpr{X: &ast.SelectorExpr{X: &ast.Ident{Name: "sync"},
					Sel: &ast.Ident{Name: "Mutex"}}}})
		}
		// Add all commParam as args
		field := &ast.Field{Names: []*ast.Ident{}, Type: &ast.Ident{Name: "int"}}
		for _, commPar := range m.CommPars {
			field.Names = append(field.Names, commPar.Name)
			new_call_expr.Args = append(new_call_expr.Args, commPar.Name)
		}

		if len(field.Names) > 0 {
			fun_decl.Type.Params.List = append(fun_decl.Type.Params.List, field)
		}

		return fun_decl, &new_call_expr, pack_name, nil

	default:

		if found, decl, pack_name := m.FindDecl(call_expr); found {

			for _, field := range decl.Type.Params.List {
				switch field.Type.(type) {
				case *ast.Ellipsis:
					return nil, nil, pack_name, &ParseError{err: errors.New(ELLIPSIS + m.Fileset.Position(call_expr.Pos()).String())}
				}
			}
			new_decl, new_call_expr := m.updateDeclWithRcvAndStructs(*decl, call_expr)

			return new_decl, new_call_expr, pack_name, nil
		} else { // The declaration of the function could not be found
			// If the goroutines takes one of our channel as input return an error
			// Otherwise check if the args are a receive on a channel
			for _, arg := range call_expr.Args {
				expr := arg
				switch arg := arg.(type) {
				case *ast.UnaryExpr:
					if arg.Op != token.ARROW {
						expr = arg.X
					}
				}
				if m.isChan(expr) || m.isWaitgroup(expr) || m.isMutex(expr) {
					return nil, nil, pack_name, &ParseError{err: errors.New(UNKNOWN_DECL + fmt.Sprint(m.Fileset.Position(call_expr.Fun.Pos())))}
				}
			}

			// also check if the function is not a method on a struct that contains
			// a mutex, a chan or a wg !
			if m.isStructWithChans(call_expr.Fun) {
				return nil, nil, pack_name, &ParseError{err: errors.New(UNKNOWN_DECL + fmt.Sprint(m.Fileset.Position(call_expr.Fun.Pos())))}
			}

		}
	}
	return nil, nil, pack_name, nil
}

func (m *Model) isStructWithChans(expr ast.Expr) bool {
	switch expr := expr.(type) {
	case *ast.SelectorExpr:
		// might be!
		for name, _ := range m.Chans {
			switch name := name.(type) {
			case *ast.SelectorExpr:
				return isSubsetOfExpr(expr.X, name.X)
			}
		}
		for name, _ := range m.WaitGroups {
			switch name := name.(type) {
			case *ast.SelectorExpr:
				return isSubsetOfExpr(expr.X, name.X)
			}
		}
		for _, name := range m.Mutexes {
			switch name := name.(type) {
			case *ast.SelectorExpr:
				return isSubsetOfExpr(expr.X, name.X)
			}
		}
	}

	return false
}

func (m *Model) updateDeclWithRcvAndStructs(decl ast.FuncDecl, call_expr *ast.CallExpr) (*ast.FuncDecl, *ast.CallExpr) {

	ptr_decl := decl
	new_decl := &ptr_decl
	func_type := *decl.Type
	params_list := &ast.FieldList{}
	params_list.List = []*ast.Field{}

	new_fields := append([]*ast.Field{}, decl.Type.Params.List...)

	new_decl.Type = &func_type
	new_call_expr := *call_expr
	new_call_expr.Args = append([]ast.Expr{}, call_expr.Args...)

	if new_decl.Recv != nil { // put the receiver as the first param of decl

		switch call := call_expr.Fun.(type) {
		case *ast.SelectorExpr:
			new_call_expr.Args = append([]ast.Expr{call.X}, new_call_expr.Args...)

			new_fields = append(decl.Recv.List, new_fields...)

		}
	}

	new_args := []ast.Expr{}

	// now flatten all structure given as arg and turn the ch, wg and mutex in the structures into
	// params and args
	counter := 0

	for _, field := range new_fields {

		isConcurrent := false
		switch t := getElemIfStar(field.Type).(type) {
		case *ast.ChanType:
			isConcurrent = true
		case *ast.SelectorExpr:
			isConcurrent = t.Sel.Name == "WaitGroup" || t.Sel.Name == "Mutex"
		}
		if !isConcurrent {

			fields_to_add := []*ast.Field{}
			args_to_add := []ast.Expr{}

			new_counter := counter
			for _, name := range field.Names {
				if len(new_call_expr.Args) > new_counter {
					s := new_call_expr.Args[new_counter]
					exprs_in_rcv := [][]ast.Expr{}

					chans := []ast.Expr{}
					for name, _ := range m.Chans {

						chans = append(chans, name)
					}

					exprs_in_rcv = append(exprs_in_rcv, addIdenticalSelectorExprs(chans, s))

					wgs := []ast.Expr{}
					for name, _ := range m.WaitGroups {
						wgs = append(wgs, name)
					}

					exprs_in_rcv = append(exprs_in_rcv, addIdenticalSelectorExprs(wgs, s))
					mutexes := []ast.Expr{}

					for _, name := range m.Mutexes {
						mutexes = append(mutexes, name)
					}

					exprs_in_rcv = append(exprs_in_rcv, addIdenticalSelectorExprs(mutexes, s))

					// adding chans and wg
					chans_fields := generateFields(s, name, exprs_in_rcv[0], &ast.ChanType{})
					wgs_fields := generateFields(s, name, exprs_in_rcv[1], &ast.StarExpr{
						X: &ast.SelectorExpr{
							X:   &ast.Ident{Name: "sync"},
							Sel: &ast.Ident{Name: "WaitGroup"},
						},
					})

					mutexes_fields := generateFields(s, name, exprs_in_rcv[2], &ast.StarExpr{
						X: &ast.SelectorExpr{
							X:   &ast.Ident{Name: "sync"},
							Sel: &ast.Ident{Name: "Mutex"},
						},
					})
					fields_to_add = append(chans_fields, wgs_fields...)

					fields_to_add = append(fields_to_add, mutexes_fields...)

					for _, exprs := range exprs_in_rcv {
						for _, expr := range exprs {
							args_to_add = append(args_to_add, expr)
						}
					}

					// Add the new parameter to the function decleration
					params_list.List = append(params_list.List, fields_to_add...)
					new_args = append(new_args, args_to_add...)

					// Add the new args of the function
					new_counter++
				}
			}

			if len(args_to_add) == 0 && len(fields_to_add) == 0 {
				for range field.Names {

					if len(new_call_expr.Args) > counter {
						new_args = append(new_args, new_call_expr.Args[counter])
						counter++
					}
				}
				params_list.List = append(params_list.List, field)
			} else {
				counter = new_counter
			}

		} else {

			params_list.List = append(params_list.List, field)
			for range field.Names {
				new_args = append(new_args, new_call_expr.Args[counter])
				counter++
			}
		}
	}

	func_type.Params = params_list
	new_decl.Type = &func_type
	new_call_expr.Args = new_args
	return new_decl, &new_call_expr
}

// if types.Interface and take channel or wg or mutex abort otherwise skip

// generate the field from the exprs with type t. Returns also the exprs that are contained.
func generateFields(call_expr ast.Expr, rcv_name *ast.Ident, exprs []ast.Expr, t ast.Expr) []*ast.Field {
	fields := []*ast.Field{}

	sub_expr := call_expr

	// switch sel := sub_expr.(type) {
	// case *ast.SelectorExpr:
	// 	sub_expr = sel.X
	// }

	for _, expr := range exprs {
		fields = append(fields,
			&ast.Field{
				Names: []*ast.Ident{
					&ast.Ident{
						Name: translateIdent(renameBaseOfExprWithOther(expr, sub_expr, rcv_name)).Name,
					},
				},
				Type: t,
			})

	}

	return fields
}

func renameBaseOfExprWithOther(from ast.Expr, old ast.Expr, n *ast.Ident) ast.Expr {
	if !isSubsetOfExpr(old, from) {
		panic("Should be a subset " + fmt.Sprint(from, old))
	}

	switch from := from.(type) {
	case *ast.SelectorExpr:
		return replaceExpr(from, old, n)
	case *ast.Ident:
		idents := strings.Split(from.Name, "_")
		lhs := exprsToSelector(idents)

		return replaceExpr(lhs, old, n)
	default:
		panic("Should be a selector or an ident " + fmt.Sprint(from))
	}

	// find old and replace is with new

}

func exprsToSelector(exprs []string) ast.Expr {
	if len(exprs) == 1 {
		return &ast.Ident{Name: exprs[0]}
	}
	if len(exprs) > 2 {
		return &ast.SelectorExpr{X: exprsToSelector(exprs[:len(exprs)-1]), Sel: &ast.Ident{Name: exprs[len(exprs)-1]}}
	} else {
		return &ast.SelectorExpr{X: &ast.Ident{Name: exprs[0]}, Sel: &ast.Ident{Name: exprs[1]}}
	}
}

func replaceExpr(from ast.Expr, old ast.Expr, n *ast.Ident) ast.Expr {

	if IdenticalExpr(from, old) {
		return n
	}

	switch from := from.(type) {
	case *ast.SelectorExpr:
		return &ast.SelectorExpr{X: replaceExpr(from.X, old, n), Sel: from.Sel}
	default:
		panic("Cannot find subset")
	}

}

// Add the expression in exprs that contains s.

// Ie: if s == c and exprs == [c.ch] -> c.ch cause s contains one expr in exprs
func addIdenticalSelectorExprs(exprs []ast.Expr, s ast.Expr) []ast.Expr {
	to_return := Names{}

	sub_expr := s

	// switch call := s.(type) {
	// case *ast.SelectorExpr:
	// 	sub_expr = call.X
	// }

	// Reorder them in alphabetical order ?

	for _, name := range exprs {
		if IdenticalExpr(name, s) {
			to_return = append(to_return, name)
		} else {
			switch name := name.(type) {
			case *ast.SelectorExpr:
				if isSubsetOfExpr(sub_expr, name.X) {
					to_return = append(to_return, name)
				}
			case *ast.Ident:
				idents := strings.Split(name.Name, "_")
				if isSubsetOfExpr(sub_expr, exprsToSelector(idents)) {
					to_return = append(to_return, name)
				}
			}
		}

	}
	sort.Sort(to_return)

	return to_return
}

// check if sub is contained in set (t, t.wg) > yes, (t.t, t.wg) > no, (t.t, t.t.wg) > Yes
func isSubsetOfExpr(sub ast.Expr, sel ast.Expr) bool {

	if IdenticalExpr(sub, sel) {
		return true
	}
	switch sel := sel.(type) {
	case *ast.SelectorExpr:

		if !IdenticalExpr(sub, sel) {

			return isSubsetOfExpr(sub, sel.X)

		} else {
			return true
		}
	case *ast.Ident:
		idents := strings.Split(sel.Name, "_")
		if len(idents) == 1 {

			return IdenticalExpr(sub, sel)
		}

		return isSubsetOfExpr(sub, exprsToSelector(idents))
	}
	return false
}
