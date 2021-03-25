package promela

import (
	"errors"
	"go/ast"
	"go/token"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

func (m *Model) translateAssignStmt(s *ast.AssignStmt) (b *promela_ast.BlockStmt, err *ParseError) {

	b, err = m.translateNewVar(s, s.Lhs, s.Rhs)

	if err != nil {
		return b, err
	}
	for _, spec := range s.Rhs {
		switch spec := spec.(type) {
		case *ast.FuncLit:
			return b, &ParseError{err: errors.New(FUNC_DECLARED_AS_VAR + m.Fileset.Position(spec.Pos()).String())}
		case *ast.UnaryExpr:
			switch spec.Op {

			case token.ARROW:
				if m.containsChan(spec.X) {

					chan_name := TranslateIdent(spec.X, m.Fileset)
					if_stmt := &promela_ast.IfStmt{Init: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}, Guards: []*promela_ast.GuardStmt{}}

					dequeue := &promela_ast.RcvStmt{
						Chan: &promela_ast.SelectorExpr{
							X:   &chan_name,
							Sel: &promela_ast.Ident{Name: "deq"},
						},
						Rhs: &promela_ast.Ident{Name: "state,num_msgs"},
						Rcv: m.Fileset.Position(spec.Pos())}
					sync_rcv := &promela_ast.RcvStmt{
						Chan: &promela_ast.SelectorExpr{
							X:   &chan_name,
							Sel: &promela_ast.Ident{Name: "sync"},
						},
						Rhs: &promela_ast.Ident{Name: "state"},
						Rcv: m.Fileset.Position(spec.Pos())}

					async_guard := &promela_ast.GuardStmt{Cond: dequeue, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}
					sync_guard := &promela_ast.GuardStmt{Cond: sync_rcv, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{
						&promela_ast.SendStmt{
							Chan: &promela_ast.SelectorExpr{
								X:   &chan_name,
								Sel: &promela_ast.Ident{Name: "rcving"},
							},
							Rhs: &promela_ast.Ident{Name: "false"},
						},
					}}}

					if_stmt.Guards = append(if_stmt.Guards, async_guard, sync_guard)

					b.List = append(b.List, if_stmt)
					ch := m.getChanStruct(spec.X)
					if len(s.Lhs) == 2 {
						switch v := s.Lhs[1].(type) {
						case *ast.Ident:
							if v.Name != "_" {
								m.ClosedVars[ch] = append(m.ClosedVars[ch], v)
							}
						case *ast.SelectorExpr:
							m.ClosedVars[ch] = append(m.ClosedVars[ch], v)
						}
					}
				} else {
					err = &ParseError{err: errors.New(UNKNOWN_RCV + m.Fileset.Position(spec.Pos()).String())}
				}
			default:
				expr, err1 := m.TranslateExpr(spec.X)

				if err1 != nil {
					return expr, err1
				}

				if len(expr.List) > 0 {
					addBlock(b, expr)
				}
			}
		default:
			expr, err1 := m.TranslateExpr(spec)

			if err1 != nil {
				return expr, err1
			}

			if len(expr.List) > 0 {
				addBlock(b, expr)
			}
		}
	}

	return b, err
}
