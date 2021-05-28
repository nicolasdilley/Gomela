package main

import (
	"fmt"
	"go/ast"
	"go/token"
	"go/types"
	"log"
	"os"

	"github.com/nicolasdilley/gomela/promela"
	"github.com/nicolasdilley/gomela/promela/promela_ast"
	"golang.org/x/tools/go/packages"
)

// takes a project name and infer promela models
func ParseAst(fileSet *token.FileSet, proj_name string, commit string, ast_map map[string]*packages.Package, ver *VerificationInfo, result_folder string, projects_folder string) {

	if len(ast_map) == 0 {
		fmt.Println("Program has no packages")
		return
	}

	for pack_name, node := range ast_map {
		// Analyse each file

		// make sure the package doesnt contain any global concurrency primitives

		if !containsConcurrencyPrimitiveAsAGlobalVariable(node) {
			for _, file := range node.Syntax {
				for _, decl := range file.Decls {
					switch decl := decl.(type) {
					case *ast.FuncDecl:
						if !takeChanAsParam(decl, ast_map[pack_name]) {
							fmt.Println("Parsing ", decl.Name.Name)
							// fmt.Println("Parsing ", decl.Name)
							var m promela.Model = promela.Model{
								Result_fodler:        result_folder,
								Project_name:         proj_name,
								Package:              pack_name,
								Name:                 pack_name + PACKAGE_MODEL_SEP + decl.Name.Name + fmt.Sprint(fileSet.Position(decl.Pos()).Line),
								AstMap:               ast_map,
								Fileset:              fileSet,
								FuncDecls:            []*ast.FuncDecl{},
								Proctypes:            []*promela_ast.Proctype{},
								RecFuncs:             []promela.RecFunc{},
								SpawningFuncs:        []*promela.SpawningFunc{},
								ClosedVars:           make(map[*promela.ChanStruct][]ast.Expr),
								Fun:                  decl,
								Chans:                make(map[ast.Expr]*promela.ChanStruct),
								WaitGroups:           make(map[ast.Expr]*promela.WaitGroupStruct),
								Mutexes:              []ast.Expr{},
								Commit:               commit,
								Global_vars:          []promela_ast.Stmt{},
								For_counter:          &promela.ForCounter{},
								Projects_folder:      projects_folder,
								GenerateFeatures:     true,
								Current_return_label: "stop_process",
							}

							m.GoToPromela(AUTHOR_PROJECT_SEP)

						}
					}
				}
			}
		} else {
			ver.num_concurrency_primitive_as_global++
		}
	}
}

func containsConcurrencyPrimitiveAsAGlobalVariable(pack *packages.Package) bool {
	// for _, file := range pack.Syntax {
	// 	for _, decl := range file.Decls {
	// 		switch decl := decl.(type) {
	// 		case *ast.FuncDecl:

	// 		case *ast.GenDecl:

	// 			for _, spec := range decl.Specs {
	// 				switch spec := spec.(type) {
	// 				case *ast.ValueSpec:
	// 					var expr ast.Expr = spec.Type
	// 					switch arg := expr.(type) {
	// 					case *ast.UnaryExpr:
	// 						expr = arg.X
	// 					case *ast.StarExpr:
	// 						expr = arg.X
	// 					}
	// 					switch expr := expr.(type) {
	// 					case *ast.ChanType:
	// 						return true
	// 					case *ast.SelectorExpr:
	// 						switch x := expr.X.(type) {
	// 						case *ast.Ident:

	// 							if x.Name == "sync" {
	// 								if expr.Sel.Name == "WaitGroup" {
	// 									return true
	// 								} else if expr.Sel.Name == "Mutex" {
	// 									return true
	// 								}
	// 							}
	// 						}
	// 					}
	// 					t := pack.TypesInfo.TypeOf(expr)
	// 					if t == nil {
	// 						return true
	// 					}
	// 					if structContainsChan(t, []*types.Named{}) {
	// 						return true
	// 					}
	// 				}
	// 			}
	// 		}
	// 	}
	// }

	return false
}

// Generate the GO ast for each packages in packages_names
func GenerateAst(dir string, package_names []string, dir_name string) (*token.FileSet, map[string]*packages.Package) {
	var ast_map map[string]*packages.Package = make(map[string]*packages.Package)
	var cfg *packages.Config = &packages.Config{Mode: packages.LoadAllSyntax, Fset: &token.FileSet{}, Dir: dir, Tests: true}

	package_names = append([]string{"."}, package_names...)
	lpkgs, err := packages.Load(cfg, package_names...)

	if a := recover(); a != nil || err != nil || cfg.Fset == nil {
		f, err := os.OpenFile("./"+RESULTS_FOLDER+"/log.csv",
			os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)

		toPrint := dir_name + ",Could not parse project"

		if err != nil {
			toPrint += ", " + err.Error()
		}

		toPrint += "\n"
		packages.PrintErrors(lpkgs)

		if _, err1 := f.WriteString(toPrint); err1 != nil {
			panic(err1)
		}
		fmt.Println("Error while loading the packages !")
		return nil, map[string]*packages.Package{}
	}

	for _, pack := range lpkgs {
		ast_map[pack.Name] = pack
	}

	return cfg.Fset, ast_map
}

func takeChanAsParam(decl *ast.FuncDecl, pack *packages.Package) bool {

	// check if the args are not structures that contains channels, wg or mutex

	for _, field := range decl.Type.Params.List {
		switch field.Type.(type) {
		case *ast.ChanType:
			return true
		}

		var ident ast.Expr
		switch t := field.Type.(type) {
		case *ast.StarExpr:
			ident = t.X
		}

		t := pack.TypesInfo.TypeOf(ident)

		if t != nil {
			switch t := t.(type) {
			case *types.Named:
				if t.String() != "testing.T" {
					if structContainsChan(t, []*types.Named{t}) {
						return true
					}
				}
			}
		}

	}

	if decl.Recv != nil {
		for _, field := range decl.Recv.List {

			var ident ast.Expr
			switch t := field.Type.(type) {
			case *ast.StarExpr:
				ident = t.X
			default:
				ident = t
			}
			switch ident := ident.(type) {
			case *ast.Ident:
				t := pack.TypesInfo.TypeOf(ident)
				if t != nil {
					switch t := t.(type) {
					case *types.Named:
						return structContainsChan(t, []*types.Named{t})

					}
				} else {
					log.Print(pack.Name, ":", decl.Name.Name, ":", "MODEL ERROR = The type of the receiver of func ", decl.Name.Name, " could not be found ")
				}
			default:

				log.Print(pack.Name, ":", decl.Name.Name, ",", "MODEL ERROR = The receiver of func ", decl.Name.Name, " was not an ident ", ident)

			}
		}
	}

	return false
}

func structContainsChan(t types.Type, seen []*types.Named) bool {
	t = promela.GetElemIfPointer(t)
	if t.String() == "sync.WaitGroup" {
		return true
	} else if t.String() == "sync.Mutex" || t.String() == "sync.RWMutex" {
		return true
	}
	switch t := t.Underlying().(type) {
	case *types.Struct:

		for i := 0; i < t.NumFields(); i++ {

			field_type := promela.GetElemIfPointer(t.Field(i).Type())

			switch field := field_type.(type) {
			case *types.Struct:
				if structContainsChan(field, seen) {
					return true
				}
			case *types.Named:
				contains := false

				for _, s := range seen {
					if s.String() == field.String() {
						contains = true
					}
				}
				if !contains {
					if structContainsChan(field, append(seen, field)) {
						return true
					}
				}
			case *types.Chan:
				return true
			}

		}
	}
	return false
}
