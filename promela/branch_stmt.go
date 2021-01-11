package promela

import (
	"fmt"
	"go/ast"
	"go/token"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

func (m *Model) translateBranchStmt(s *ast.BranchStmt) (b *promela_ast.BlockStmt, defers *promela_ast.BlockStmt, err *ParseError) {
	b = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	defers = &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}
	br := &promela_ast.GotoStmt{
		Goto: m.Fileset.Position(s.Pos()),
	}

	switch s.Tok {
	case token.CONTINUE:
		// jump to end of loop
		br.Label = &promela_ast.LabelStmt{Name: fmt.Sprintf("for%d%d_end", m.For_counter.X, m.For_counter.Y)}
		b.List = append(b.List, br)
	case token.BREAK:
		if s.Label != nil {
			br.Label = &promela_ast.LabelStmt{Name: translateIdent(s.Label).Name}
			b.List = append(b.List, br)
		} else {
			b.List = append(b.List, &promela_ast.Ident{Name: "break"})
		}
	case token.GOTO:
		br.Label = &promela_ast.LabelStmt{Name: translateIdent(s.Label).Name}
		b.List = append(b.List, br)
	}

	return b, defers, err
}
