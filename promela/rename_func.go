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
	switch stmt := s.(type) {
	case *ast.BlockStmt:
		return RenameBlockStmt(stmt, alias, n), alias
	case *ast.ForStmt:
		stmt.Cond = renameExpr(stmt.Cond, alias, n)
		stmt.Init, alias = renameStmt(stmt.Init, alias, n)
		stmt.Post, alias = renameStmt(stmt.Post, alias, n)
		stmt.Body = RenameBlockStmt(stmt.Body, alias, n)

	case *ast.SelectStmt:
		stmt.Body = RenameBlockStmt(stmt.Body, alias, n)

	case *ast.AssignStmt:
		found := false

		for i, e := range stmt.Rhs {
			if IdenticalExprs(alias, e) {
				found = true
				alias = append(alias, stmt.Lhs[i]) // this is where the aliases get added
			} else {
				stmt.Rhs[i] = renameExpr(e, alias, n)
			}
		}
		if found {
			return nil, alias
		}
		for i, e := range stmt.Lhs {
			if IdenticalExprs(alias, e) {
				stmt.Lhs[i] = n
			}
		}
	case *ast.CommClause:
		stmt.Comm, alias = renameStmt(stmt.Comm, alias, n)
		if stmt.Body != nil {

			for i, s1 := range stmt.Body {
				stmt.Body[i], alias = renameStmt(s1, alias, n)
			}
		}

	case *ast.CaseClause:

		for i, e := range stmt.List {
			stmt.List[i] = renameExpr(e, alias, n)
		}
		if stmt.Body != nil {

			for i, s1 := range stmt.Body {
				stmt.Body[i], alias = renameStmt(s1, alias, n)
			}
		}

	case *ast.DeclStmt:
		found := false
		switch decl := stmt.Decl.(type) {
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
		stmt.Call = renameExpr(stmt.Call, alias, n).(*ast.CallExpr)
	case *ast.DeferStmt:
		stmt.Call = renameExpr(stmt.Call, alias, n).(*ast.CallExpr)
	case *ast.ExprStmt:
		stmt.X = renameExpr(stmt.X, alias, n)
	case *ast.SendStmt:
		stmt.Chan = renameExpr(stmt.Chan, alias, n)
		stmt.Value = renameExpr(stmt.Value, alias, n)
	case *ast.RangeStmt:
		stmt.X = renameExpr(stmt.X, alias, n)
		stmt.Body = RenameBlockStmt(stmt.Body, alias, n)
	case *ast.IfStmt:
		stmt.Init, alias = renameStmt(stmt.Init, alias, n)
		stmt.Body = RenameBlockStmt(stmt.Body, alias, n)
		if stmt.Else != nil {
			stmt.Else = RenameBlockStmt(stmt.Else.(*ast.BlockStmt), alias, n)
		}
	case *ast.ReturnStmt:
		for i, result := range stmt.Results {
			stmt.Results[i] = renameExpr(result, alias, n)
		}
	case *ast.LabeledStmt:
		stmt.Stmt, alias = renameStmt(stmt.Stmt, alias, n)
	}

	return s, alias
}

func renameExpr(e ast.Expr, prev []ast.Expr, n ast.Expr) ast.Expr {
	switch e1 := e.(type) {
	case *ast.BinaryExpr:
		e1.X = renameExpr(e1.X, prev, n)
		e1.Y = renameExpr(e1.Y, prev, n)
	case *ast.UnaryExpr:
		e1.X = renameExpr(e1.X, prev, n)
	case *ast.CallExpr:

		switch fun := e1.Fun.(type) {
		case *ast.FuncLit:
			fun.Body = RenameBlockStmt(fun.Body, prev, n)
		}
		for i, arg := range e1.Args {
			e1.Args[i] = renameExpr(arg, prev, n)
		}
	case *ast.StarExpr:
		e1.X = renameExpr(e1.X, prev, n)
	case *ast.ParenExpr:
		e1.X = renameExpr(e1.X, prev, n)
	case *ast.KeyValueExpr:
		e1.Key = renameExpr(e1.Key, prev, n)
		e1.Value = renameExpr(e1.Value, prev, n)
	case *ast.IndexExpr:
		e1.X = renameExpr(e1.X, prev, n)
		e1.Index = renameExpr(e1.Index, prev, n)
	case *ast.Ident:
		if IdenticalExprs(prev, e1) {
			return n
		}
	case *ast.SelectorExpr:
		if IdenticalExprs(prev, e1) {
			return n
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
