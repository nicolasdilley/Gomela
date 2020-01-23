package main

import (
	"fmt"
	"go/ast"
	"go/token"
	"go/types"
	"log"
	"strings"

	"git.cs.kent.ac.uk/nd315/gopology/promela"
	"git.cs.kent.ac.uk/nd315/gopology/promela/promela_ast"
	"golang.org/x/tools/go/packages"
)

func ParseAst(fileSet *token.FileSet, proj_name string, ast_map map[string]*packages.Package) {

	if strings.Contains(proj_name, "test") {
		for _, node := range ast_map {
			for ident, obj := range node.TypesInfo.Defs {
				if obj != nil {
					switch obj.Type().(type) {
					case *types.Chan:
						fmt.Println(fileSet.Position(ident.NamePos).Filename + ":" + ident.Name + " -> " + obj.String())
						switch var1 := obj.(type) {
						case *types.Var:
							fmt.Println(var1)
						}
					}
				}
			}
		}
	}

	if len(ast_map) == 0 {
		return
	}

	for pack_name, node := range ast_map {

		// Analyse each file
		for _, file := range node.Syntax {
			for _, decl := range file.Decls {
				switch fun_decl := decl.(type) {
				case *ast.FuncDecl:
					if !takeChanAsParam(fun_decl) {

						var m promela.Model = promela.Model{
							Package:        pack_name,
							Proctypes:      []*promela_ast.Proctype{},
							Fun:            fun_decl,
							Chans:          make(map[ast.Expr]*promela.ChanStruct),
							LTL_Properties: []promela_ast.LTL_property{},
							Global_vars:    []promela_ast.Stmt{},
							For_counter:    &promela.ForCounter{},
						}

						m.GoToPromela(proj_name, fileSet, ast_map)
					}
				}
			}
		}
	}
}

func GenerateAst(package_names []string) (*token.FileSet, map[string]*packages.Package) {

	var ast_map map[string]*packages.Package = make(map[string]*packages.Package)
	var cfg *packages.Config = &packages.Config{Mode: packages.LoadAllSyntax, Fset: &token.FileSet{}}
	lpkgs, err := packages.Load(cfg, package_names...)
	if err != nil {
		log.Fatal("Error while loading the packages !")
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
