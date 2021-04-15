package promela_ast

func Inspect(s Stmt, f func(Stmt) bool) {
	switch s := s.(type) {
	case *BlockStmt:
		if f(s) {
			for _, b := range s.List {
				Inspect(b, f)
			}
		}
	case *CondStmt:
		if f(s) {
			for _, g := range s.Guards {
				Inspect(g, f)
			}
		}
	case *DoStmt:
		if f(s) {
			for _, g := range s.Guards {
				Inspect(g, f)
			}
		}
	case *ForStmt:
		if f(s) {
			Inspect(s.Body, f)
		}
	case *SelectStmt:
		if f(s) {
			for _, g := range s.Guards {
				Inspect(g, f)
			}
		}
	case *IfStmt:
		if f(s) {
			for _, g := range s.Guards {
				Inspect(g, f)
			}
		}
	case *RunStmt:
		if f(s) {
			Inspect(s.X, f)
		}
	case *GuardStmt:
		Inspect(s.Cond, f)
		Inspect(s.Body, f)
	case *CallExpr:
		for _, arg := range s.Args {
			Inspect(arg, f)
		}
	case *AssignStmt:
		Inspect(s.Lhs, f)
		Inspect(s.Rhs, f)
	case *DeclStmt:
		if f(s) {
			Inspect(s.Name, f)
			Inspect(s.Rhs, f)
		}
	default:
		f(s)
	}
}
