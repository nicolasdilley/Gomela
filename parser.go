package main

import (
	"fmt"
	"go/ast"
	"go/token"
	"go/types"
	"log"

	"github.com/nicolasdilley/gomela/promela"
	"github.com/nicolasdilley/gomela/promela/promela_ast"
	"golang.org/x/tools/go/packages"
)

// takes a project name and infer promela models
func ParseAst(fileSet *token.FileSet, proj_name string, commit string, ast_map map[string]*packages.Package, ver *VerificationInfo) {

	if len(ast_map) == 0 {
		fmt.Println("Program has no packages")
		return
	}

	for pack_name, node := range ast_map {
		// Analyse each file

		for _, file := range node.Syntax {
			for _, decl := range file.Decls {
				switch decl := decl.(type) {
				case *ast.FuncDecl:
					if !takeChanAsParam(decl) {

						var m promela.Model = promela.Model{
							Project_name:  proj_name,
							Package:       pack_name,
							AstMap:        ast_map,
							Fileset:       fileSet,
							Proctypes:     []*promela_ast.Proctype{},
							RecFuncs:      []promela.RecFunc{},
							SpawningFuncs: []*promela.SpawningFunc{},
							Fun:           decl,
							Chans:         make(map[ast.Expr]*promela.ChanStruct),
							Commit:        commit,
							Global_vars:   []promela_ast.Stmt{},
							For_counter:   &promela.ForCounter{},
							Default_ub:    *ver.ub,
							Default_lb:    *ver.lb,
						}

						for _, def := range node.TypesInfo.Defs {
							if def != nil {
								switch typ := def.Type().(type) {
								case *types.Named:
									if typ.Obj() != nil {
										if typ.Obj().Pkg() != nil {
											if typ.Obj().Pkg().Name() == "sync" {
												if typ.Obj().Name() == "WaitGroup" {
													promela.PrintCounter(promela.Counter{
														Proj_name: proj_name,
														Fun:       decl.Name.Name,
														Name:      "Initialisation of WaitGroup",
														Info:      "",
														Commit:    commit,
														Line:      fileSet.Position(def.Pos()).Line,
														Filename:  fileSet.Position(def.Pos()).Filename,
													})
												}
											}
										}
									}
								}
							}
						}

						m.GoToPromela()

					}
				}
			}
		}
	}
}

// Generate the GO ast for each packages in packages_names
func GenerateAst(dir string, package_names []string) (*token.FileSet, map[string]*packages.Package) {
	var ast_map map[string]*packages.Package = make(map[string]*packages.Package)
	var cfg *packages.Config = &packages.Config{Mode: packages.LoadAllSyntax, Fset: &token.FileSet{}, Dir: dir}

	package_names = append([]string{"."}, package_names...)
	lpkgs, err := packages.Load(cfg, package_names...)
	if err != nil {
		log.Fatal("Error while loading the packages ! , err : ", err.Error())
	}

	for _, pack := range lpkgs {
		ast_map[pack.Name] = pack
	}

	return cfg.Fset, ast_map
}

func takeChanAsParam(decl *ast.FuncDecl) bool {
	for _, field := range decl.Type.Params.List {
		switch field.Type.(type) {
		case *ast.ChanType:
			return true
		}
	}
	return false
}
