package promela

import (
	"go/ast"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

func Clean(m *Model) {
	removeEmptyForLoops(m.Init.Body)
	for _, proc := range m.Proctypes {
		removeEmptyForLoops(proc.Body)

		params := findOptParams(proc.Body)

		for _, commPar := range params {
			if !used(commPar, proc.Body) {
				removeDecl(commPar, proc.Body)
			}
		}
	}

	for _, commPar := range m.CommPars {

		if !used(commPar, m.Init.Body) {
			for i := len(m.Defines) - 1; i >= 0; i-- {
				if m.Defines[i].Name.Name == commPar.Name.Name {
					m.Defines = append(m.Defines[:i], m.Defines[i+1:]...)
				}
			}
			removeDecl(commPar, m.Init.Body)
		}
	}

}

func findOptParams(b *promela_ast.BlockStmt) []*CommPar {
	params := []*CommPar{}
	for _, s := range b.List {
		switch s := s.(type) {
		case *promela_ast.DeclStmt:
			switch ident := s.Rhs.(type) {
			case *promela_ast.Ident:
				if ident.Name == "-2" {
					params = append(params, &CommPar{Name: &ast.Ident{Name: s.Name.Name}, Mandatory: false, Candidate: true})
				}
			}
		}
	}

	return params
}

func removeEmptyForLoops(b *promela_ast.BlockStmt) {
	for i := len(b.List) - 1; i >= 0; i-- {
		switch stmt := b.List[i].(type) {
		case *promela_ast.ForStmt:
			removeEmptyForLoops(stmt.Body)
			if !containsMSP(stmt.Body) {
				b.List = append(b.List[:i], b.List[i+1:]...)
			}
		default:
		}
	}
}

// check if the commpar is used in the model
func used(commPar *CommPar, b *promela_ast.BlockStmt) bool {
	is_used := false
	if commPar.Mandatory {
		return true
	}

	isUsed := func(s promela_ast.Stmt) bool {
		switch s := s.(type) {
		case *promela_ast.ForStmt:
			if s.Ub.Name == commPar.Name.Name+"-1" {
				is_used = true
			}
			if s.Lb.Name == commPar.Name.Name {
				is_used = true
			}
		}
		return !is_used
	}
	promela_ast.Inspect(b, isUsed)

	return is_used
}

// remove decleration of commPar in model
func removeDecl(commPar *CommPar, b *promela_ast.BlockStmt) {

	for i := len(b.List) - 1; i >= 0; i-- {
		switch s := b.List[i].(type) {
		case *promela_ast.DeclStmt:
			if s.Name.Name == commPar.Name.Name {
				b.List = append(b.List[:i], b.List[i+1:]...)
			}
		}
	}
}

// see if the blockstmt contains a receive or send
func containsMSP(b *promela_ast.BlockStmt) bool {
	contains := false

	promela_ast.Inspect(b, func(s promela_ast.Stmt) bool {
		switch s.(type) {
		case *promela_ast.RcvStmt, *promela_ast.SendStmt:
			contains = true
		}
		return true
	})
	return contains
}
