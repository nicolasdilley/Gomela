package promela

import (
	"errors"
	"fmt"
	"go/ast"
	"go/token"
	"strconv"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
	"github.com/nicolasdilley/gomela/promela/promela_types"
	"golang.org/x/tools/go/packages"
)

var (
	CHAN_NAME          = "_ch"
	DEFAULT_BOUND      = "??"
	OPTIONAL_BOUND     = "-2"
	CHAN_BOUND         = 0
	ADD_BOUND          = 1
	LOWER_FOR_BOUND    = 2
	UPPER_FOR_BOUND    = 3
	RANGE_BOUND        = 4
	AUTHOR_PROJECT_SEP = "--"

	Features = []Feature{}
)

type Model struct {
	Result_fodler   string // the name of the folder where the model need to ne printed
	Project_name    string // the full name of  project (eg. "nicolasdilley/Gomela")
	Package         string // the name of the package
	Name            string // the name of the file that will be generated. (Composed of "pack_functionName")
	Commit          string // the commit of the project
	RecFuncs        []RecFunc
	SpawningFuncs   []*SpawningFunc
	Fileset         *token.FileSet
	FuncDecls       []*ast.FuncDecl               // A list of all the funcdecl declared in the function being modelled (ie, fun := func(){ return true})
	Proctypes       []*promela_ast.Proctype       // the processes representing the functions of the model
	Inlines         []*promela_ast.Inline         // the inlines function that represent the commpar args that are function calls
	Fun             *ast.FuncDecl                 // the function being modelled
	Chans           map[ast.Expr]*ChanStruct      // the promela chan used in the module mapped to their go expr
	WaitGroups      map[ast.Expr]*WaitGroupStruct // the promela chan used in the module mapped to their go expr
	ContainsWg      bool
	ContainsChan    bool
	Init            *promela_ast.InitDef       // The proctype consisting of the "main" function of the source program
	Global_vars     []promela_ast.Stmt         // the global variable used in the ltl properties
	Defines         []promela_ast.DefineStmt   // the channel bounds
	CommPars        []*CommPar                 // the communications paramer
	Features        []Feature                  // The features for the survey
	ClosedVars      map[*ChanStruct][]ast.Expr // The variable that are used to test if a channel is closed when receiving (i.e ok in r,ok := >-ch )
	process_counter int                        // to give unique name to Promela processes
	func_counter    int                        // to give unique name to inline func call
	For_counter     *ForCounter                // Used to translate the for loop to break out properly out of them
	Counter         int                        // used to differentiate call expr channels
	Default_lb      int
	Default_ub      int
	AstMap          map[string]*packages.Package // the map used to find the type of the channels
	Chan_closing    bool
	Projects_folder string
}

// Used to represent a function for recursive calls
type RecFunc struct {
	Pkg  string
	Name string
}

// represent a function and states if it spawns or not
type SpawningFunc struct {
	Rec_func    RecFunc
	is_spawning bool
}

type Bound struct {
	Name ast.Expr
	Var  promela_ast.Ident
	Val  int
}

type ParseError struct {
	err error
}

// Take a go function and translate it to a Promela module
func (m *Model) GoToPromela(SEP string) {

	AUTHOR_PROJECT_SEP = SEP
	Features = []Feature{}
	// m.CommPars = m.AnalyseCommParam(m.Package, m.Fun, m.AstMap, true)

	//. Create a define for each mandatory param
	// m.Init = &promela_ast.InitDef{Def: m.Fileset.Position(m.Fun.Pos()), Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}
	// for _, commPar := range m.CommPars {
	// 	if commPar.Mandatory {
	// 		def := m.GenerateDefine(commPar) // generate the define statement out of the commpar
	// 		m.Init.Body.List = append(m.Init.Body.List, &promela_ast.DeclStmt{Name: &promela_ast.Ident{Name: commPar.Name.Name}, Rhs: &promela_ast.Ident{Name: def}, Types: promela_types.Int})
	// 	} else {
	// 		m.Init.Body.List = append(m.Init.Body.List, &promela_ast.DeclStmt{Name: &promela_ast.Ident{Name: commPar.Name.Name}, Rhs: &promela_ast.Ident{Name: OPTIONAL_BOUND}, Types: promela_types.Int})
	// 	}

	// 	name := "Actual Param"
	// 	if commPar.Candidate {
	// 		name = "Candidate Param"
	// 	}
	// 	Features = append(Features, Feature{
	// 		Proj_name: m.Project_name,
	// 		Model:     m.Name,
	// 		Fun:       m.Fun.Name.String(),
	// 		Name:      name,
	// 		Mandatory: fmt.Sprint(commPar.Mandatory),
	// 		Info:      commPar.Name.Name,
	// 		Line:      0,
	// 		Commit:    m.Commit,
	// 		Filename:  m.Fileset.Position(m.Fun.Pos()).Filename,
	// 	})
	// }

	// m.Init.Body.List = append(m.Init.Body.List,
	// 	&promela_ast.DeclStmt{Name: &promela_ast.Ident{Name: "i"}, Types: promela_types.Int},
	// 	&promela_ast.DeclStmt{Name: &promela_ast.Ident{Name: "state"}, Types: promela_types.Bool, Rhs: &promela_ast.Ident{Name: "false"}},
	// 	&promela_ast.DeclStmt{Name: &promela_ast.Ident{Name: "num_msgs"}, Types: promela_types.Int, Rhs: &promela_ast.Ident{Name: "0"}})
	// s1, defers, err := m.TranslateBlockStmt(m.Fun.Body)

	b, err := m.TranslateGoStmt(
		&ast.GoStmt{
			Go:   m.Fun.Pos(),
			Call: &ast.CallExpr{Fun: m.Fun.Name, Args: make([]ast.Expr, m.Fun.Type.Params.NumFields())},
		}, true)

	m.Init = &promela_ast.InitDef{
		Def:  m.Fileset.Position(m.Fun.Pos()),
		Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}},
	}
	// generate the model only if it contains a chan or a wg
	if len(m.Chans) > 0 || len(m.WaitGroups) > 0 {
		if err == nil {
			m.Init.Body.List = append(m.Init.Body.List,
				b.List...)

			// clean the model by removing empty for loops and unused opt param
			m.Features = Features
			Clean(m)
			Print(m) // print the model
			PrintFeatures(m.Features, m)
		} else {
			fmt.Println("Could not parse model ", m.Name, " :")
			fmt.Println(err.err.Error())

			logFeature(Feature{
				Proj_name: m.Project_name,
				Model:     m.Name,
				Fun:       m.Fun.Name.String(),
				Name:      "MODEL ERROR = " + fmt.Sprintf(err.err.Error()),
				Mandatory: "false",
				Line:      0,
				Commit:    m.Commit,
				Filename:  m.Fileset.Position(m.Fun.Pos()).Filename,
			}, m)
		}
	}

}
func (m *Model) translateNewVar(s ast.Stmt, lhs []ast.Expr, rhs []ast.Expr) (b *promela_ast.BlockStmt, err *ParseError) {
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}

	for i := len(rhs) - 1; i >= 0; i-- {
		call := rhs[i]
		switch unary := call.(type) {
		case *ast.UnaryExpr:
			call = unary.X

		}
		switch call := call.(type) {
		case *ast.SelectorExpr:
			if call.Sel.Name == "WaitGroup" {
				switch sel := call.X.(type) {
				case *ast.Ident:
					if sel.Name == "sync" {
						// we have a waitgroup
						if len(lhs) > i {
							b1, err1 := m.translateWg(s, lhs[i])
							addBlock(b, b1)
							if err1 != nil {
								err = err1
							}
						}
					}
				}
			}
		case *ast.CallExpr:
			switch ident := call.Fun.(type) {
			case *ast.Ident:
				if ident.Name == "make" && len(call.Args) > 0 { // possibly a new chan
					switch call.Args[0].(type) {
					case *ast.ChanType:
						ch, err1 := m.translateChan(lhs[i], call.Args)
						addBlock(b, ch)
						if err1 != nil {
							err = err1
						}
					}
				} else if ident.Name == "new" && len(call.Args) > 0 {
					// check if its the decleration of a new sync.Waitgroup

					expr := call.Args[0]

					switch p := call.Args[0].(type) {
					case *ast.StarExpr:
						expr = p.X
					}

					switch expr := expr.(type) {
					case *ast.SelectorExpr:
						if expr.Sel.Name == "WaitGroup" {
							switch expr := expr.X.(type) {
							case *ast.Ident:
								if expr.Name == "sync" {
									b1, err1 := m.translateWg(s, lhs[i])
									addBlock(b, b1)
									if err1 != nil {
										err = err1
									}
								}
							}
						}
					}
				}
			}

		case *ast.CompositeLit:

			for _, elt := range call.Elts {
				switch elt := elt.(type) {
				case *ast.KeyValueExpr:
					switch call := elt.Value.(type) {
					case *ast.CallExpr:
						switch ident := call.Fun.(type) {
						case *ast.Ident:
							if ident.Name == "make" && len(call.Args) > 0 { // possibly a new chan
								switch call.Args[0].(type) {
								case *ast.ChanType:

									return b, &ParseError{err: errors.New(CHAN_DECLARED_IN_STRUCT + m.Fileset.Position(s.Pos()).String())}
								}
							}
						}

					}
				}

			}

			// Tests if one of the field of the assign structs is a WG
			var obj *ast.Object
			switch sel := call.Type.(type) {
			case *ast.Ident:
				obj = sel.Obj
			case *ast.SelectorExpr:
				obj = sel.Sel.Obj
			}

			switch sel := call.Type.(type) {
			case *ast.SelectorExpr:
				if sel.Sel.Name == "WaitGroup" {
					switch sel := sel.X.(type) {
					case *ast.Ident:
						if sel.Name == "sync" {
							// we have a waitgroup
							for _, name := range lhs {
								b1, err1 := m.translateWg(s, name)
								addBlock(b, b1)
								if err1 != nil {
									err = err1
								}
							}
						}
					}
				}
			}

			if obj != nil {
				switch decl := obj.Decl.(type) {
				case *ast.TypeSpec:
					switch s := decl.Type.(type) {
					case *ast.StructType:
						for _, field := range s.Fields.List {
							var expr ast.Expr = field.Type
							switch star := field.Type.(type) {
							case *ast.StarExpr:
								expr = star.X
							}
							switch sel := expr.(type) {
							case *ast.SelectorExpr:
								if sel.Sel.Name == "WaitGroup" {
									switch sel := sel.X.(type) {
									case *ast.Ident:
										if sel.Name == "sync" {

											return b, &ParseError{err: errors.New(WG_DECLARED_IN_STRUCT + m.Fileset.Position(s.Pos()).String())}
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
	return b, err
}

func (m *Model) translateWg(s ast.Stmt, name ast.Expr) (b *promela_ast.BlockStmt, err *ParseError) {
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	if !m.For_counter.In_for {

		var prom_wg_name promela_ast.Ident
		switch name.(type) {
		case *ast.SelectorExpr:
			return b, &ParseError{err: errors.New(WG_DECLARED_IN_STRUCT + m.Fileset.Position(name.Pos()).String())}
		default:

			prom_wg_name = translateIdent(name)
		}
		if !m.containsWaitgroup(name) {
			m.ContainsWg = true
			m.WaitGroups[name] = &WaitGroupStruct{
				Name:    &prom_wg_name,
				Wait:    m.Fileset.Position(name.Pos()),
				Counter: 0,
			}

			Features = append(Features, Feature{
				Proj_name: m.Project_name,
				Model:     m.Name,
				Fun:       m.Fun.Name.String(),
				Name:      "new WaitGroup",
				Info:      "Name :" + prom_wg_name.Name,
				Mandatory: "false",
				Line:      m.Fileset.Position(s.Pos()).Line,
				Commit:    m.Commit,
				Filename:  m.Fileset.Position(s.Pos()).Filename,
			})

			b.List = append(b.List,
				&promela_ast.DeclStmt{Name: &prom_wg_name, Types: promela_types.Wgdef},
				&promela_ast.RunStmt{X: &promela_ast.CallExpr{Fun: &promela_ast.Ident{Name: "wgMonitor"}, Args: []promela_ast.Expr{&prom_wg_name}}})
		}
	} else {
		Features = append(Features, Feature{
			Proj_name: m.Project_name,
			Model:     m.Name,
			Fun:       m.Fun.Name.String(),
			Name:      "WaitGroup in for",
			Mandatory: "false",
			Line:      m.Fileset.Position(s.Pos()).Line,
			Commit:    m.Commit,
			Filename:  m.Fileset.Position(s.Pos()).Filename,
		})
		err = &ParseError{err: errors.New(WAITGROUP_IN_FOR + m.Fileset.Position(s.Pos()).String())}
	}

	return b, err
}

func (m *Model) translateChan(go_chan_name ast.Expr, args []ast.Expr) (b *promela_ast.BlockStmt, err *ParseError) {
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	if !m.For_counter.In_for {
		// a new channel is found lets change its name, rename it in function and add to struct

		// b.List = RenameBlockStmt(b, []ast.Expr{lhs[i]}, &chan_name).List
		var prom_chan_name promela_ast.Ident

		switch go_chan_name.(type) {
		case *ast.SelectorExpr:
			return b, &ParseError{err: errors.New(CHAN_DECLARED_IN_STRUCT + m.Fileset.Position(go_chan_name.Pos()).String())}
		default:

			prom_chan_name = translateIdent(go_chan_name)
		}
		channel := &ChanStruct{Name: &prom_chan_name, Chan: m.Fileset.Position(go_chan_name.Pos())}
		chan_def := &promela_ast.DeclStmt{Name: &promela_ast.Ident{Name: prom_chan_name.Name}, Types: promela_types.Chandef}
		b.List = append(b.List, chan_def)
		if_stmt := &promela_ast.IfStmt{Init: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}, Guards: []*promela_ast.GuardStmt{}}
		sync_monitor := &promela_ast.RunStmt{X: &promela_ast.CallExpr{Fun: &promela_ast.Ident{Name: "sync_monitor"}, Args: []promela_ast.Expr{&prom_chan_name}}}
		if len(args) > 1 { // check if the channel is buffered or not
			channel.Buffered = true
			var size *promela_ast.Ident
			size, err = m.lookUp(args[1], CHAN_BOUND, false)
			async_guard := &promela_ast.GuardStmt{
				Cond: &promela_ast.Ident{Name: size.Name + " > 0"},
				Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{
					&promela_ast.AssignStmt{Lhs: &promela_ast.SelectorExpr{X: &prom_chan_name, Sel: &promela_ast.Ident{Name: "size"}}, Rhs: size},
					&promela_ast.RunStmt{X: &promela_ast.CallExpr{Fun: &promela_ast.Ident{Name: "AsyncChan"}, Args: []promela_ast.Expr{&prom_chan_name}}},
				}}}
			sync_guard := &promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "else"},
				Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{sync_monitor}}}

			if_stmt.Guards = append(if_stmt.Guards, async_guard, sync_guard)
			b.List = append(b.List, if_stmt)
		} else {
			b.List = append(b.List, sync_monitor)
		}

		m.Chans[go_chan_name] = channel
		m.ContainsChan = true
		Features = append(Features, Feature{
			Proj_name: m.Project_name,
			Model:     m.Name,
			Fun:       m.Fun.Name.String(),
			Name:      "new channel",
			Info:      "Name :" + channel.Name.Name,
			Mandatory: "false",
			Line:      channel.Chan.Line,
			Commit:    m.Commit,
			Filename:  channel.Chan.Filename,
		})

	} else {
		Features = append(Features, Feature{
			Proj_name: m.Project_name,
			Model:     m.Name,
			Fun:       m.Fun.Name.String(),
			Name:      "Chan in for",
			Mandatory: "false",
			Line:      m.Fileset.Position(go_chan_name.Pos()).Line,
			Commit:    m.Commit,
			Filename:  m.Fileset.Position(go_chan_name.Pos()).Filename,
		})
		err = &ParseError{err: errors.New(CHAN_IN_FOR + m.Fileset.Position(go_chan_name.Pos()).String())}
	}
	return b, err
}

// takes a promela body and add break if there are no breaks at the end or if there is
// add a goto to the surrounding for loop
func (m *Model) checkForBreak(body *promela_ast.BlockStmt, g *promela_ast.GotoStmt) {
	if found := containsBreak(body); !found && !containsReturn(body) { // no return or break then just break
		body.List = append(body.List, &promela_ast.Ident{Name: "break"})
	} else {
		if found {
			replaceBreak(body, g)
		}
	}
}

func replaceBreak(body *promela_ast.BlockStmt, g *promela_ast.GotoStmt) {

	promela_ast.Inspect(&promela_ast.BlockStmt{List: []promela_ast.Stmt{body}}, func(s promela_ast.Stmt) bool {
		switch s := s.(type) {
		case *promela_ast.BlockStmt:
			for i, ident := range s.List {
				switch ident := ident.(type) {
				case *promela_ast.Ident:
					if ident.Name == "break" {
						s.List[i] = g
					}
				}
			}
			return true
		case *promela_ast.ForStmt:
			return false
		case *promela_ast.DoStmt:
			return false
		}
		return true
	})
}

func containsBreak(b *promela_ast.BlockStmt) bool {
	contains := false
	promela_ast.Inspect(b, func(stmt promela_ast.Stmt) bool {
		switch stmt := stmt.(type) {
		case *promela_ast.Ident:
			if stmt.Name == "break" {
				contains = true
			}
		case *promela_ast.ForStmt:
			return false
		case *promela_ast.DoStmt:
			return false
		}
		return true
	})
	return contains
}

func (m *Model) TranslateExpr(expr ast.Expr) (b *promela_ast.BlockStmt, err *ParseError) {
	stmts := &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	switch expr := expr.(type) {
	case *ast.BinaryExpr:
		e1, err1 := m.TranslateExpr(expr.X)
		if err1 != nil {
			err = err1
		}
		addBlock(stmts, e1)

		expr2, err2 := m.TranslateExpr(expr.Y)
		if err2 != nil {
			err = err2
		}
		addBlock(stmts, expr2)

	case *ast.CallExpr:
		switch name := expr.Fun.(type) {
		case *ast.Ident:
			if name.Name == "close" && len(expr.Args) == 1 { // closing a chan
				send := &promela_ast.SendStmt{Send: m.Fileset.Position(name.Pos())}

				ch := TranslateIdent(expr.Args[0], m.Fileset)

				if m.containsChan(expr.Args[0]) {
					send.Chan = &promela_ast.SelectorExpr{
						X: &ch, Sel: &promela_ast.Ident{Name: "closing"},
						Pos: m.Fileset.Position(expr.Args[0].Pos()),
					}
					send.Rhs = &promela_ast.Ident{Name: "true"}
					m.Chan_closing = true
					stmts.List = append(stmts.List, send)
				} else {
					return stmts, &ParseError{err: errors.New(UNKNOWN_CHAN_CLOSE + m.Fileset.Position(expr.Pos()).String())}
				}
			} else {
				call, err1 := m.TranslateCallExpr(expr)
				if err1 != nil {
					err = err1
				}
				addBlock(stmts, call)
			}

		case *ast.SelectorExpr:
			call, err1 := m.TranslateCallExpr(expr)
			if err1 != nil {
				err = err1
			}
			addBlock(stmts, call)

		case *ast.FuncLit:
			new_block := name.Body
			for x, field := range name.Type.Params.List {
				for y, name := range field.Names {

					arg := expr.Args[x+y]
					switch expr := expr.Args[x+y].(type) {
					case *ast.UnaryExpr:
						arg = expr.X
					}
					new_block = RenameBlockStmt(new_block, []ast.Expr{name}, arg)
				}
			}
			stmts, d1, err1 := m.TranslateBlockStmt(new_block)

			stmts.List = append(stmts.List, d1.List...)
			return stmts, err1

		}

	case *ast.UnaryExpr:
		switch expr.Op {
		case token.NOT:
			return m.TranslateExpr(expr.X)
		case token.ARROW:
			if m.containsChan(expr.X) {

				chan_name := TranslateIdent(expr.X, m.Fileset)
				if_stmt := &promela_ast.IfStmt{Init: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}, Guards: []*promela_ast.GuardStmt{}}

				async_rcv := &promela_ast.RcvStmt{Chan: &promela_ast.SelectorExpr{X: &chan_name, Sel: &promela_ast.Ident{Name: "async_rcv"}}, Rhs: &promela_ast.Ident{Name: "state,num_msgs"}, Rcv: m.Fileset.Position(expr.Pos())}
				sync_rcv := &promela_ast.RcvStmt{Chan: &promela_ast.SelectorExpr{X: &chan_name, Sel: &promela_ast.Ident{Name: "sync"}}, Rhs: &promela_ast.Ident{Name: "state,num_msgs"}, Rcv: m.Fileset.Position(expr.Pos())}

				async_guard := &promela_ast.GuardStmt{Cond: async_rcv, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}
				sync_guard := &promela_ast.GuardStmt{Cond: sync_rcv, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}

				if_stmt.Guards = append(if_stmt.Guards, async_guard, sync_guard)

				stmts.List = append(stmts.List, if_stmt)
			} else {
				err = &ParseError{err: errors.New(UNKNOWN_RCV + m.Fileset.Position(expr.Pos()).String())}
			}
		}

	case *ast.ParenExpr:
		call, err1 := m.TranslateExpr(expr.X)
		if err1 != nil {
			err = err1
		}
		addBlock(stmts, call)
	}
	return stmts, err
}

func addBlock(b1 *promela_ast.BlockStmt, b2 *promela_ast.BlockStmt) {
	for _, b := range b2.List {
		b1.List = append(b1.List, b)
	}
}

func (m *Model) getChanStruct(expr ast.Expr) *ChanStruct {
	for e, s := range m.Chans {
		if IdenticalExpr(e, expr) {
			return s
		}
	}
	return nil
}

func (m *Model) FindDecl(pack string, func_name string, param_num int, ast_map map[string]*packages.Package) (bool, *ast.FuncDecl) {

	if ast_map[pack] != nil {
		for _, file := range ast_map[pack].Syntax {
			if file.Decls != nil {
				for _, decl := range file.Decls {
					switch decl := decl.(type) {
					case *ast.FuncDecl:
						if func_name == decl.Name.Name {
							if decl.Type.Params.NumFields() == param_num {
								return true, decl
							}
						}
					}
				}
			}
		}
	}

	return false, nil
}

func (m *Model) containsChan(expr ast.Expr) bool {
	for e, _ := range m.Chans {
		if IdenticalExpr(e, expr) {
			return true
		}
	}
	return false
}

func (m *Model) containsWaitgroup(expr ast.Expr) bool {

	switch ptr := expr.(type) {
	case *ast.UnaryExpr:
		expr = ptr.X
	}

	for e, _ := range m.WaitGroups {

		if IdenticalExpr(e, expr) {
			return true
		}
	}
	return false
}

func (m *Model) CallExists(name string) bool {
	for _, proc := range m.Proctypes {
		if proc.Name.Name == name {
			return true
		}
	}

	return false
}

func isRecursive(pack string, block *ast.BlockStmt, ast_map map[string]*packages.Package, call_seen []ast.Expr) bool {

	recursive := false
	ast.Inspect(block, func(n ast.Node) bool {
		switch n := n.(type) {
		case *ast.CallExpr:
			if IdenticalExprs(call_seen, n.Fun) {
				recursive = true
			}

		}
		return true
	})

	return recursive
}

// Takes a commPar and genrate a define stmt out of the name of the commPar and the function under analysis
func (m *Model) GenerateDefine(commPar *CommPar) string {
	name := m.Fun.Name.Name + "_" + commPar.Name.Name
	m.Defines = append(m.Defines, promela_ast.DefineStmt{Name: &promela_ast.Ident{Name: name}, Rhs: &promela_ast.Ident{Name: DEFAULT_BOUND}})

	return name
}

func IsConst(expr ast.Expr, pack *packages.Package) (found bool, val int) {
	switch expr := expr.(type) {
	case *ast.Ident:
		obj := expr.Obj
		if obj != nil {
			if obj.Kind == ast.Con {
				switch value_spec := obj.Decl.(type) {
				case *ast.ValueSpec:
					if value_spec.Values != nil && len(value_spec.Values) > 0 {
						switch val := value_spec.Values[0].(type) {
						case *ast.BasicLit:
							v, err := strconv.Atoi(val.Value)
							if err == nil {
								return true, v
							}
						case *ast.Ident:
							return IsConst(val, pack)
						}
					}
				}
			}
		}
	case *ast.SelectorExpr:
		obj := expr.Sel.Obj
		if obj != nil {
			if obj.Kind == ast.Con {
				switch value_spec := obj.Decl.(type) {
				case *ast.ValueSpec:
					if value_spec.Values != nil && len(value_spec.Values) > 0 {
						switch val := value_spec.Values[0].(type) {
						case *ast.BasicLit:
							v, err := strconv.Atoi(val.Value)
							if err == nil {
								return true, v
							}
						case *ast.Ident:
							return IsConst(val, pack)
						}
					}
				}
			}
		}
	case *ast.BasicLit:
		if expr.Kind == token.INT {
			val, err := strconv.Atoi(expr.Value)
			if err == nil {
				return true, val
			}
		}
	}
	return false, -1
}

func translateIdent(expr ast.Expr) (expr1 promela_ast.Ident) {
	switch e := expr.(type) {
	case *ast.Ident:
		expr1 = promela_ast.Ident{Name: e.Name}
	case *ast.SelectorExpr:
		expr1 = promela_ast.Ident{Name: translateIdent(e.X).Name + "_" + e.Sel.Name}
	}

	return expr1
}

func containsExpr(exprs []ast.Expr, expr ast.Expr) bool {
	for _, e := range exprs {
		switch e := e.(type) {
		case *ast.SelectorExpr:
			if IdenticalExpr(&ast.Ident{Name: translateIdent(e.X).Name + "_" + e.Sel.Name}, expr) {
				return true
			}
		default:

			if IdenticalExpr(e, expr) {
				return true
			}
		}

	}

	return false
}
func (m *Model) containsInline(expr ast.Expr) bool {
	for _, inline := range m.Inlines {
		if inline.Name.Name == m.getIdent(expr).Name {
			return true
		}
	}
	return false
}
func containsReturn(b *promela_ast.BlockStmt) bool {
	for _, stmt := range b.List {
		switch stmt.(type) {
		case *promela_ast.GotoEndStmt:
			return true
		}
	}
	return false
}

func (m *Model) ContainsRecFunc(pkg string, name string) bool {

	for _, fun := range m.RecFuncs {
		if pkg == fun.Pkg && name == fun.Name {
			return true
		}
	}

	return false
}

func (m *Model) AddRecFunc(pkg string, name string) {
	m.RecFuncs = append(m.RecFuncs, RecFunc{Pkg: pkg, Name: name})
}

func (m *Model) notDefine(name string) bool {
	found := false

	for _, define := range m.Defines {
		if define.Name.Name == name {
			found = true
		}
	}
	return found
}

func (m *Model) newModel(pack string, fun *ast.FuncDecl) Model {
	return Model{
		Result_fodler:   m.Result_fodler,
		Project_name:    m.Project_name,
		Package:         pack,
		Name:            m.Name,
		Commit:          m.Commit,
		RecFuncs:        []RecFunc{},
		SpawningFuncs:   m.SpawningFuncs,
		Fileset:         m.Fileset,
		Proctypes:       m.Proctypes,
		Inlines:         m.Inlines,
		Fun:             fun,
		ContainsChan:    m.ContainsChan,
		ContainsWg:      m.ContainsWg,
		Chans:           make(map[ast.Expr]*ChanStruct),
		WaitGroups:      make(map[ast.Expr]*WaitGroupStruct),
		Init:            m.Init,
		Global_vars:     m.Global_vars,
		Defines:         m.Defines,
		CommPars:        []*CommPar{},
		FuncDecls:       []*ast.FuncDecl{},
		Features:        []Feature{},
		process_counter: 0,
		func_counter:    0,
		For_counter:     m.For_counter,
		Counter:         m.Counter,
		Default_lb:      m.Default_lb,
		Default_ub:      m.Default_lb,
		AstMap:          m.AstMap,
		Chan_closing:    m.Chan_closing,
		Projects_folder: m.Projects_folder,
		ClosedVars:      make(map[*ChanStruct][]ast.Expr),
	}
}

func (m *Model) addNewProctypes(new_model Model) {

	for _, proc := range new_model.Proctypes {
		contains := false
		for _, proc2 := range m.Proctypes {
			if proc.Name.Name == proc2.Name.Name {
				contains = true
			}
		}

		if !contains {
			m.Proctypes = append(m.Proctypes, proc)
		}
	}
	for _, def := range new_model.Defines {
		contains := false
		for _, def2 := range m.Defines {
			if def.Name.Name == def2.Name.Name {
				contains = true
			}
		}

		if !contains {
			m.Defines = append(m.Defines, def)
		}
	}
}

func prettyPrint(expr ast.Expr) string {
	switch expr := expr.(type) {
	case *ast.CallExpr:

		name := prettyPrint(expr.Fun) + "("

		for i, arg := range expr.Args {
			name += prettyPrint(arg)

			if i < len(expr.Args)-1 {
				name += "."
			}
		}

		return name + ")"
	default:
		return fmt.Sprint(expr)
	}
}
