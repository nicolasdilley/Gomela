package main

import (
	"go/token"
	"go/types"
	"sort"
	"sync"

	"github.com/dominikh/go-tools/ssa"
	"github.com/dominikh/go-tools/ssa/ssautil"
	"github.com/rogpeppe/godef/go/ast"
	"golang.org/x/tools/go/loader"
)

func (l *Linter) Lint(lprog *loader.Program) []Problem {
	ssaprog := ssautil.CreateProgram(lprog, ssa.GlobalDebug)
	ssaprog.Build()
	pkgMap := map[*ssa.Package]*Pkg{}
	var pkgs []*Pkg
	for _, pkginfo := range lprog.InitialPackages() {
		ssapkg := ssaprog.Package(pkginfo.Pkg)
		pkg := &Pkg{
			Package: ssapkg,
			Info:    pkginfo,
		}
		pkgMap[ssapkg] = pkg
		pkgs = append(pkgs, pkg)
	}
	prog := &Program{
		SSA:          ssaprog,
		Prog:         lprog,
		Packages:     pkgs,
		Info:         &types.Info{},
		GoVersion:    l.GoVersion,
		tokenFileMap: map[*token.File]*ast.File{},
		astFileMap:   map[*ast.File]*Pkg{},
	}
	initial := map[*types.Package]struct{}{}
	for _, pkg := range pkgs {
		initial[pkg.Info.Pkg] = struct{}{}
	}
	for fn := range ssautil.AllFunctions(ssaprog) {
		if fn.Pkg == nil {
			continue
		}
		prog.AllFunctions = append(prog.AllFunctions, fn)
		if _, ok := initial[fn.Pkg.Pkg]; ok {
			prog.InitialFunctions = append(prog.InitialFunctions, fn)
		}
	}
	for _, pkg := range pkgs {
		prog.Files = append(prog.Files, pkg.Info.Files...)

		ssapkg := ssaprog.Package(pkg.Info.Pkg)
		for _, f := range pkg.Info.Files {
			tf := lprog.Fset.File(f.Pos())
			prog.tokenFileMap[tf] = f
			prog.astFileMap[f] = pkgMap[ssapkg]
		}
	}

	sizes := struct {
		types      int
		defs       int
		uses       int
		implicits  int
		selections int
		scopes     int
	}{}
	for _, pkg := range pkgs {
		sizes.types += len(pkg.Info.Info.Types)
		sizes.defs += len(pkg.Info.Info.Defs)
		sizes.uses += len(pkg.Info.Info.Uses)
		sizes.implicits += len(pkg.Info.Info.Implicits)
		sizes.selections += len(pkg.Info.Info.Selections)
		sizes.scopes += len(pkg.Info.Info.Scopes)
	}
	prog.Info.Types = make(map[ast.Expr]types.TypeAndValue, sizes.types)
	prog.Info.Defs = make(map[*ast.Ident]types.Object, sizes.defs)
	prog.Info.Uses = make(map[*ast.Ident]types.Object, sizes.uses)
	prog.Info.Implicits = make(map[ast.Node]types.Object, sizes.implicits)
	prog.Info.Selections = make(map[*ast.SelectorExpr]*types.Selection, sizes.selections)
	prog.Info.Scopes = make(map[ast.Node]*types.Scope, sizes.scopes)
	for _, pkg := range pkgs {
		for k, v := range pkg.Info.Info.Types {
			prog.Info.Types[k] = v
		}
		for k, v := range pkg.Info.Info.Defs {
			prog.Info.Defs[k] = v
		}
		for k, v := range pkg.Info.Info.Uses {
			prog.Info.Uses[k] = v
		}
		for k, v := range pkg.Info.Info.Implicits {
			prog.Info.Implicits[k] = v
		}
		for k, v := range pkg.Info.Info.Selections {
			prog.Info.Selections[k] = v
		}
		for k, v := range pkg.Info.Info.Scopes {
			prog.Info.Scopes[k] = v
		}
	}
	l.Checker.Init(prog)

	funcs := l.Checker.Funcs()
	var keys []string
	for k := range funcs {
		keys = append(keys, k)
	}
	sort.Strings(keys)

	var jobs []*Job
	for _, k := range keys {
		j := &Job{
			Program: prog,
			check:   k,
		}
		jobs = append(jobs, j)
	}
	wg := &sync.WaitGroup{}
	for _, j := range jobs {
		wg.Add(1)
		go func(j *Job) {
			defer wg.Done()
			fn := funcs[j.check]
			if fn == nil {
				return
			}
			fn(j)
		}(j)
	}
	wg.Wait()

	var out []Problem
	for _, j := range jobs {
		for _, p := range j.problems {
			if !l.ignore(j, p) {
				out = append(out, p)
			}
		}
	}

	sort.Sort(byPosition{lprog.Fset, out})
	return out
}
