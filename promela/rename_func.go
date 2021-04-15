package promela

import (
	"go/ast"
)

// Take a function decleration and rename channel "prev" to "n"
func RenameChan(fun *ast.FuncDecl, prev ast.Expr, n ast.Expr) {
	b := RenameBlockStmt(fun.Body, []ast.Expr{prev}, n)
	fun.Body = b
}

func RenameBlockStmt(b *ast.BlockStmt, prev []ast.Expr, n ast.Expr) (new_block *ast.BlockStmt) {
	new_block = &ast.BlockStmt{List: []ast.Stmt{}}
	alias := prev
	for _, stmt := range b.List {
		stmt, alias = renameStmt(stmt, alias, n)
		if stmt != nil {
			new_block.List = append(new_block.List, stmt)
		}
	}

	return new_block
}

func renameStmt(s ast.Stmt, prev []ast.Expr, n ast.Expr) (s1 ast.Stmt, alias []ast.Expr) {
	alias = prev
	s1 = s
	switch s := s.(type) {
	case *ast.BlockStmt:
		return RenameBlockStmt(s, alias, n), alias
	case *ast.ForStmt:
		s.Cond = renameExpr(s.Cond, alias, n)
		s.Init, alias = renameStmt(s.Init, alias, n)
		s.Post, alias = renameStmt(s.Post, alias, n)
		s.Body = RenameBlockStmt(s.Body, alias, n)

	case *ast.SelectStmt:
		s.Body = RenameBlockStmt(s.Body, alias, n)

	case *ast.AssignStmt:
		found := false

		for i, e := range s.Rhs {
			if IdenticalExprs(alias, e) {
				found = true
				alias = append(alias, s.Lhs[i]) // this is where the aliases get added
			} else {
				s.Rhs[i] = renameExpr(e, alias, n)
			}
		}
		if found {
			return nil, alias
		}
		for i, e := range s.Lhs {
			if IdenticalExprs(alias, e) {
				s.Lhs[i] = n
			}
		}
	case *ast.CommClause:
		s.Comm, alias = renameStmt(s.Comm, alias, n)
		if s.Body != nil {

			for i, s1 := range s.Body {
				s.Body[i], alias = renameStmt(s1, alias, n)
			}
		}

	case *ast.CaseClause:

		for i, e := range s.List {
			s.List[i] = renameExpr(e, alias, n)
		}
		if s.Body != nil {

			for i, s1 := range s.Body {
				s.Body[i], alias = renameStmt(s1, alias, n)
			}
		}

	case *ast.DeclStmt:
		found := false
		switch decl := s.Decl.(type) {
		case *ast.GenDecl:
			for _, spec := range decl.Specs {
				switch val := spec.(type) {
				case *ast.ValueSpec:
					for i, v := range val.Values {
						if IdenticalExprs(alias, v) {
							found = true
							alias = append(alias, v)
						} else {
							val.Values[i] = renameExpr(v, alias, n)
						}
					}

					for i, v := range val.Names {
						if IdenticalExprs(alias, v) {
							found = true
							alias = append(alias, v)
						} else {
							val.Names[i] = FindIdent(n)
						}
					}
				}
			}
		}
		if found {
			return nil, alias
		}
	case *ast.GoStmt:
		s.Call = renameExpr(s.Call, alias, n).(*ast.CallExpr)
	case *ast.DeferStmt:
		s.Call = renameExpr(s.Call, alias, n).(*ast.CallExpr)
	case *ast.ExprStmt:
		s.X = renameExpr(s.X, alias, n)
	case *ast.SendStmt:
		s.Chan = renameExpr(s.Chan, alias, n)
		s.Value = renameExpr(s.Value, alias, n)
	case *ast.RangeStmt:
		s.X = renameExpr(s.X, alias, n)
		s.Body = RenameBlockStmt(s.Body, alias, n)
	case *ast.IfStmt:
		s.Init, alias = renameStmt(s.Init, alias, n)
		s.Body = RenameBlockStmt(s.Body, alias, n)
		if s.Else != nil {

			switch els := s.Else.(type) {
			case *ast.BlockStmt:
				s.Else = RenameBlockStmt(els, alias, n)
			default:
				s.Else, alias = renameStmt(els, alias, n)
			}
		}
	case *ast.ReturnStmt:
		for i, result := range s.Results {
			s.Results[i] = renameExpr(result, alias, n)
		}
	case *ast.LabeledStmt:
		s.Stmt, alias = renameStmt(s.Stmt, alias, n)
	}

	return s, alias
}

func renameExpr(e ast.Expr, prev []ast.Expr, n ast.Expr) ast.Expr {
	switch e := e.(type) {
	case *ast.BinaryExpr:
		e.X = renameExpr(e.X, prev, n)
		e.Y = renameExpr(e.Y, prev, n)
	case *ast.UnaryExpr:
		e.X = renameExpr(e.X, prev, n)
	case *ast.CallExpr:

		switch fun := e.Fun.(type) {
		case *ast.FuncLit:

			contains := false
			for _, arg := range e.Args {
				if translateIdent(arg).Name == translateIdent(e).Name {
					contains = true
				}
			}

			// rename only if not in args
			if !contains {
				fun.Body = RenameBlockStmt(fun.Body, prev, n)
			}
		}

		e.Fun = renameExpr(e.Fun, prev, n)
		for i, arg := range e.Args {
			e.Args[i] = renameExpr(arg, prev, n)
		}
	case *ast.StarExpr:
		e.X = renameExpr(e.X, prev, n)
	case *ast.ParenExpr:
		e.X = renameExpr(e.X, prev, n)
	case *ast.KeyValueExpr:
		e.Key = renameExpr(e.Key, prev, n)
		e.Value = renameExpr(e.Value, prev, n)
	case *ast.IndexExpr:
		e.X = renameExpr(e.X, prev, n)
		e.Index = renameExpr(e.Index, prev, n)
	case *ast.Ident:
		if IdenticalExprs(prev, e) {
			return n
		}
	case *ast.SelectorExpr:
		if IdenticalExprs(prev, e) {
			return n
		}
		if IdenticalExprs(prev, e.X) {
			e.X = n
		}
	}

	return e
}

// Return if two ast.Expr (Expect ast.Ident and ast.SelectorExpr only) are exactly the same or not
func IdenticalExprs(exprs []ast.Expr, expr2 ast.Expr) (identical bool) {
	identical = false
	for _, e := range exprs {
		if IdenticalExpr(e, expr2) {
			identical = true
		}
	}
	return identical
}
