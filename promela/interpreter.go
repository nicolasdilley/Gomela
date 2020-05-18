package promela

import (
	"io/ioutil"
	"os"
	"strings"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
	"github.com/nicolasdilley/gomela/promela/promela_types"
)

type ForCounter struct { // used to create the labels to jump to for for select statement
	X       int
	Y       int
	In_for  bool // a flag to say if we are or not in a for loop if true update Y if false update X
	With_go bool // true if a go stmt was found inside
}

func Print(p *ProjectInfo, m *Model) {

	p.checkChanClosing(m)
	stmt := ""

	// print the bounds
	for _, c := range m.Defines {
		stmt += c.Print(0) + "\n"
	}

	stmt += "\n"
	// print chandef
	chan_struct := promela_ast.ChanStructDef{Name: promela_ast.Ident{Name: "Chandef"}, Defs: []promela_ast.Chandef{}} // creating the struct that will represent the go channel
	in := promela_ast.Chandef{Name: promela_ast.Ident{Name: "in"}, Types: []promela_types.Types{promela_types.Int}, Size: promela_ast.Ident{Name: "0"}}
	sending := promela_ast.Chandef{Name: promela_ast.Ident{Name: "sending"}, Types: []promela_types.Types{promela_types.Int}, Size: promela_ast.Ident{Name: "0"}}
	closed := promela_ast.Chandef{Name: promela_ast.Ident{Name: "closing"}, Types: []promela_types.Types{promela_types.Bool}, Size: promela_ast.Ident{Name: "0"}}
	is_closed := promela_ast.Chandef{Name: promela_ast.Ident{Name: "is_closed"}, Types: []promela_types.Types{promela_types.Bool}, Size: promela_ast.Ident{Name: "0"}}
	chan_struct.Defs = append(chan_struct.Defs, in, sending, closed, is_closed)

	b := promela_ast.BlockStmt{List: []promela_ast.Stmt{}}

	// setting the size of the in chan

	for _, c := range m.Global_vars {
		b.List = append(b.List, c)
	}

	if len(m.Chans) > 0 {
		stmt += chan_struct.Print(0)
	}
	stmt += "\n"
	stmt += b.Print(0)
	stmt += "\n\n"
	stmt += m.Init.Print(0)
	stmt += "\n"

	for _, proc := range m.Proctypes {
		stmt += proc.Print(0)
	}

	folder := "./results/" + p.Project_name
	if _, err := os.Stat(folder); os.IsNotExist(err) {
		os.Mkdir(folder, os.ModePerm)
	}

	d1 := []byte(stmt)
	filename := folder + "/" + m.Name + ".pml"
	err := ioutil.WriteFile(filename, d1, 0644)
	if err != nil {
		panic(err)
	}

}

func (p *ProjectInfo) checkChanClosing(m *Model) {

	if !p.Chan_closing {
		for _, proc := range m.Proctypes {
			checkChanClosing(proc.Body)
		}

		checkChanClosing(m.Init.Body)
	} else {
		m.Proctypes = append(m.Proctypes, GenerateChanMonitor())

	}
}

func checkChanClosing(stmts *promela_ast.BlockStmt) {
	for i := len(stmts.List) - 1; i >= 0; i-- {
		switch s := stmts.List[i].(type) {
		case *promela_ast.RunStmt:
			if s.X.Fun.Name == "chanMonitor" {
				stmts.List = append(stmts.List[:i], stmts.List[i+1:]...)
			}
		case *promela_ast.DoStmt:
			for _, guard := range s.Guards {
				checkChanClosing(guard.Body)
			}
		case *promela_ast.IfStmt:
			for _, guard := range s.Guards {
				checkChanClosing(guard.Body)
			}
		case *promela_ast.SelectStmt:
			for _, guard := range s.Guards {
				checkChanClosing(guard.Body)
			}
		case *promela_ast.RcvStmt:
			switch e := s.Chan.(type) {
			case *promela_ast.Ident:
				if strings.Contains(e.Name, "sending") {
					stmts.List = append(stmts.List[:i], stmts.List[i+1:]...)
				}
			case *promela_ast.SelectorExpr:
				if strings.Contains(e.Sel.Name, "sending") {
					stmts.List = append(stmts.List[:i], stmts.List[i+1:]...)
				}
			}

		case *promela_ast.ForStmt:
			checkChanClosing(&s.Body)

		}
	}
}
