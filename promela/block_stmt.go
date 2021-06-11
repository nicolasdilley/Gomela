package promela

import (
	"go/ast"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

// take a go block stmt and returns its promela counterpart
func (m *Model) TranslateBlockStmt(b *ast.BlockStmt) (block_stmt *promela_ast.BlockStmt, defer_stmts *promela_ast.BlockStmt, err *ParseError) {

	block_stmt = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	defer_stmts = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	if b != nil {
		block_stmt.Block = m.Fileset.Position(b.Pos())
		for _, stmt := range b.List {
			if stmt != nil {
				switch stmt := stmt.(type) {
				case *ast.DeferStmt:
					s1, err1 := m.translateDeferStmt(stmt)
					if err1 != nil {
						return block_stmt, defer_stmts, err1
					}
					if len(s1.List) > 0 {
						s1.List = append([]promela_ast.Stmt{&promela_ast.LabelStmt{Name: m.Current_return_label}}, s1.List...)
						defer_stmts.List = append(defer_stmts.List, s1)
					}
				default:
					var s1 *promela_ast.BlockStmt = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
					var defers *promela_ast.BlockStmt = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
					var err1 *ParseError
					switch stmt := stmt.(type) {
					case *ast.AssignStmt:
						s1, err1 = m.translateAssignStmt(stmt)
					case *ast.DeclStmt:
						s1, err1 = m.translateDeclStmt(stmt)
					case *ast.SendStmt:
						s1, err1 = m.translateSendStmt(stmt)
					case *ast.GoStmt:
						s1, err1 = m.TranslateGoStmt(stmt, false)
					case *ast.ReturnStmt:
						s1, defers, err1 = m.translateReturnStmt(stmt)
					case *ast.ExprStmt:
						s1, defers, err1 = m.translateExprStmt(stmt)
					case *ast.LabeledStmt:
						s1, defers, err1 = m.translateLabeledStmt(stmt)
					case *ast.ForStmt:
						s1, defers, err1 = m.translateForStmt(stmt)
					case *ast.RangeStmt:
						s1, defers, err1 = m.translateRangeStmt(stmt)
					case *ast.SelectStmt:
						s1, defers, err1 = m.translateSelectStmt(stmt)
					case *ast.SwitchStmt:
						s1, defers, err1 = m.translateSwitchStmt(stmt)
					case *ast.BranchStmt:
						s1, defers, err1 = m.translateBranchStmt(stmt)
					case *ast.IfStmt:
						s1, defers, err1 = m.translateIfStmt(stmt)
					case *ast.TypeSwitchStmt:
						s1, defers, err1 = m.translateTypeSwitchStmt(stmt)
					}

					if err1 != nil {
						return block_stmt, defer_stmts, err1
					} else {
						addBlock(block_stmt, s1)
						addBlock(defer_stmts, defers)
					}
				}
			}
		}
	}

	return block_stmt, defer_stmts, err
}
