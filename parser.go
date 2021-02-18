package main

import (
	"fmt"
	"go/ast"
	"go/token"
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

		for _, file := range node.Syntax {
			for _, decl := range file.Decls {
				switch decl := decl.(type) {
				case *ast.FuncDecl:
					if !takeChanAsParam(decl) {
						if decl.Name.Name == "doChunkedGetNonLiveBlocks" {
							fmt.Println("OUIIIIIIIIZIEZIDIZDIZIDZDOZJDOAJDZJODIQJZODJQZODJZQODJQOZDJQZBD QZJDBQ ZIDBHQZIDBQZIDUB QZIDQZDIU")
						}
						var m promela.Model = promela.Model{
							Result_fodler:   result_folder,
							Project_name:    proj_name,
							Package:         pack_name,
							Name:            pack_name + PACKAGE_MODEL_SEP + decl.Name.Name + fmt.Sprint(fileSet.Position(decl.Pos()).Line),
							AstMap:          ast_map,
							Fileset:         fileSet,
							FuncDecls:       []*ast.FuncDecl{},
							Proctypes:       []*promela_ast.Proctype{},
							RecFuncs:        []promela.RecFunc{},
							SpawningFuncs:   []*promela.SpawningFunc{},
							Fun:             decl,
							Chans:           make(map[ast.Expr]*promela.ChanStruct),
							WaitGroups:      make(map[ast.Expr]*promela.WaitGroupStruct),
							Commit:          commit,
							Global_vars:     []promela_ast.Stmt{},
							For_counter:     &promela.ForCounter{},
							Default_ub:      *ver.ub,
							Default_lb:      *ver.lb,
							Projects_folder: projects_folder,
						}

						m.GoToPromela(AUTHOR_PROJECT_SEP)

					}
				}
			}
		}
	}
}

// Generate the GO ast for each packages in packages_names
func GenerateAst(dir string, package_names []string, dir_name string) (*token.FileSet, map[string]*packages.Package) {
	var ast_map map[string]*packages.Package = make(map[string]*packages.Package)
	var cfg *packages.Config = &packages.Config{Mode: packages.LoadAllSyntax, Fset: &token.FileSet{}, Dir: dir}

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

func takeChanAsParam(decl *ast.FuncDecl) bool {
	for _, field := range decl.Type.Params.List {
		switch field.Type.(type) {
		case *ast.ChanType:
			return true
		}
	}
	return false
}
