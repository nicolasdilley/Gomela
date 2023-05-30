package promela

import (
	"errors"
	"github.com/nicolasdilley/gomela/promela/promela_ast"
	"go/ast"
	"go/token"
)

func (m *Model) translateAssignStmt(s *ast.AssignStmt) (b *promela_ast.BlockStmt, err error) {

	b, err = m.translateNewVar(s, s.Lhs, s.Rhs)

	if err != nil {
		return b, err
	}
	for i, spec := range s.Rhs {
		switch spec := spec.(type) {
		case *ast.FuncLit:
			return b, errors.New(FUNC_DECLARED_AS_VAR + m.Fileset.Position(spec.Pos()).String())
		case *ast.UnaryExpr:
			switch spec.Op {

			case token.ARROW:
				var guard promela_ast.GuardStmt

				guard, err = m.translateRcvStmt(spec.X, &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}, &promela_ast.BlockStmt{List: []promela_ast.Stmt{}})
				if_stmt := &promela_ast.IfStmt{
					Init: &promela_ast.BlockStmt{
						List: []promela_ast.Stmt{},
					},
					Guards: []promela_ast.GuardStmt{},
				}

				if_stmt.Guards = append(if_stmt.Guards, guard)

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
			} else {

				// flag the lhs as an alias so that its not turned into an unknown comm param

				// Checks if all is known on the right side
				// check if the left-hand side is a comm param
				if m.IsExprKnown(spec) && m.IsExprKnown(s.Lhs[i]) {
					// If it is then translate the assignment as is

					lhs, _ := m.TranslateKnownExpr(s.Lhs[i])
					rhs, comm_pars := m.TranslateKnownExpr(spec)
					addBlock(b, &promela_ast.BlockStmt{List: []promela_ast.Stmt{
						&promela_ast.AssignStmt{Lhs: lhs, Rhs: rhs}}})

					m.FlagCommParamAsAlias(s.Lhs[i], comm_pars)
				}
			}
		}
	}

	return b, err
}
