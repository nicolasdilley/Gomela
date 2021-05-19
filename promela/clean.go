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
				removeFeatures(commPar, m)
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
			removeFeatures(commPar, m)
		}
	}

	for i := len(m.Defines) - 1; i >= 0; i-- {
		commPar := &CommPar{Name: &ast.Ident{Name: m.Defines[i].Name.Name}}

		is_used := used(commPar, m.Init.Body)

		for _, proc := range m.Proctypes {
			if used(commPar, proc.Body) {
				is_used = true
			}
		}

		if !is_used {
			m.Defines = append(m.Defines[:i], m.Defines[i+1:]...)
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
			if s.Ub.Name == commPar.Name.Name {
				is_used = true
			}
			if s.Lb.Name == commPar.Name.Name {
				is_used = true
			}
		case *promela_ast.CallExpr:
			for _, arg := range s.Args {
				switch arg := arg.(type) {
				case *promela_ast.Ident:
					if arg.Name == commPar.Name.Name {
						is_used = true
					}
				}
			}
		case *promela_ast.RunStmt:
			for _, arg := range s.X.Args {
				switch arg := arg.(type) {
				case *promela_ast.Ident:
					if arg.Name == commPar.Name.Name {
						is_used = true
					}
				}
			}
		case *promela_ast.DeclStmt:
			switch s := s.Rhs.(type) {
			case *promela_ast.Ident:
				if s.Name == commPar.Name.Name {
					is_used = true
				}
			}
			return false
		case *promela_ast.CommParamDeclStmt:
			switch s := s.Rhs.(type) {
			case *promela_ast.Ident:
				if s.Name == commPar.Name.Name {
					is_used = true
				}
			}
			return false
		case *promela_ast.Ident:
			if s.Name == commPar.Name.Name {
				is_used = true
			}
		}
		return !is_used
	}

	promela_ast.Inspect(b, isUsed)

	return is_used
}

func removeFeatures(commPar *CommPar, m *Model) {
	for i := len(m.Features) - 1; i >= 0; i-- {
		if m.Features[i].Info == commPar.Name.Name {
			m.Features = append(m.Features[:i], m.Features[i+1:]...)
		}
	}
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

// see if the blockstmt contains a receive, a send or a run stmt
func containsMSP(b *promela_ast.BlockStmt) bool {
	contains := false
	promela_ast.Inspect(b, func(s promela_ast.Stmt) bool {
		switch s.(type) {
		case *promela_ast.RcvStmt, *promela_ast.SendStmt, *promela_ast.RunStmt:
			contains = true
		}
		return !contains
	})
	return contains
}
