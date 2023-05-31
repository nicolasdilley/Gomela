package promela

import (
	"errors"

	"github.com/nicolasdilley/gomela/promela/promela_ast"

	"go/ast"
)

func (m *Model) translateSendStmt(s *ast.SendStmt) (b *promela_ast.BlockStmt, err error) {
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}

	var guard promela_ast.GuardStmt

	guard, err = m.generateGenSendStmt(s.Chan, &promela_ast.BlockStmt{
		List: []promela_ast.Stmt{},
	}, &promela_ast.BlockStmt{
		List: []promela_ast.Stmt{},
	})

	if_stmt := &promela_ast.IfStmt{
		If:    m.Props.Fileset.Position(s.Pos()),
		Model: "Send",
		Init: &promela_ast.BlockStmt{
			List: []promela_ast.Stmt{},
		},
		Guards: []promela_ast.GuardStmt{guard},
	}

	expr, err1 := m.TranslateExpr(s.Value)
	if err1 != nil {
		err = err1
	}
	addBlock(b, expr)

	b.List = append(b.List, if_stmt)

	return b, err

}

func (m *Model) generateGenSendStmt(e ast.Expr, body *promela_ast.BlockStmt, body2 *promela_ast.BlockStmt) (g promela_ast.GuardStmt, err error) {

	if m.containsChan(e) {

		// create GenSend instead
		chan_name := m.getChanStruct(e)

		g = &GenSendStmt{
			Send:       m.Props.Fileset.Position(e.Pos()),
			Chan:       chan_name.Name,
			M:          m.Props,
			Sync_body:  body,
			Async_body: body2,
		}

	} else {
		err = errors.New(UNKNOWN_SEND + m.Props.Fileset.Position(e.Pos()).String())
	}

	return g, err
}
