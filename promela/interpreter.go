package promela

import (
	"io/ioutil"
	"os"
	"strings"

	"go/ast"
	"go/token"

	"git.cs.kent.ac.uk/nd315/gopology/promela/promela_ast"
	"git.cs.kent.ac.uk/nd315/gopology/promela/promela_types"
)

type ForCounter struct { // used to create the labels to jump to for for select statement
	X       int
	Y       int
	In_for  bool // a flag to say if we are or not in a for loop if true update Y if false update X
	With_go bool // true if a go stmt was found inside
}

func Print(p *ProjectInfo, m *Model) {

	p.checkChanClosing(m)

	// properties := PropertyGenerator{
	// 	Properties:     []promela_ast.LTL_property{},
	// 	Model:          m,
	// 	counter:        0,
	// 	Select_counter: 0,
	// }
	// properties.GenerateProperties()
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
	for _, inline := range m.Inlines {
		stmt += inline.Print(0)
	}
	stmt += "\n"
	stmt += b.Print(0)
	stmt += "\n\n"
	stmt += m.Init.Print(0)
	stmt += "\n"

	for _, proc := range m.Proctypes {
		stmt += proc.Print(0)
	}

	// // print a single LTL property based on all small properties]
	// overall_property := promela_ast.LTL_property{Name: "overall", Property: ""}

	// // ltl can only verify a maximum of 12 properties at once
	// var number_of_sub_properties int = int(math.Ceil(float64(float64(len(m.LTL_Properties)) / 12)))

	// if number_of_sub_properties != 1 { // there are more than 12 so lets partition them
	// 	sub_properties := []promela_ast.LTL_property{}

	// 	for i := 0; i < number_of_sub_properties; i++ {
	// 		sub_property := promela_ast.LTL_property{Name: fmt.Sprintf("sub_properties%d", i), Property: ""}

	// 		length := ((i + 1) * 12) - 1
	// 		if ((i+1)*12)-1 > len(m.LTL_Properties)-1 {
	// 			length = len(m.LTL_Properties)
	// 		}
	// 		for x, prop := range m.LTL_Properties[(i * 12):length] { // truncate the list of properties
	// 			sub_property.Property += prop.Property

	// 			if x < len(m.LTL_Properties[(i*12):length])-1 {
	// 				sub_property.Property += " && "
	// 			}

	// 		}

	// 		sub_properties = append(sub_properties, sub_property)
	// 	}

	// 	for i, sub_property := range sub_properties {
	// 		overall_property.Property += sub_property.Name

	// 		if i < len(sub_properties)-1 {
	// 			overall_property.Property += " && "
	// 		}
	// 	}

	// 	// print the overall property
	// 	stmt += overall_property.Print(0) + "\n"

	// 	for _, sub_properties := range sub_properties {
	// 		stmt += sub_properties.Print(0) + "\n"
	// 	}
	// } else { // only need a single overall

	// 	for i, prop := range m.LTL_Properties { // truncate the list of properties
	// 		overall_property.Property += prop.Property

	// 		if i < len(m.LTL_Properties)-1 {
	// 			overall_property.Property += " && "
	// 		}

	// 	}

	// 	// Generate overall property based on sub property

	// 	stmt += overall_property.Print(0) + "\n"

	// }

	// // print LTL properties individually
	// for _, prop := range m.LTL_Properties {
	// 	stmt += prop.Print(0) + "\n"
	// }
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

		for _, inline := range m.Inlines {
			checkChanClosing(inline.Body)
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

func (t *ProjectInfo) BoundSeen(bound ast.Node) (bool, *Bound) {

	for _, b := range t.Known_bounds.List {
		if b.Name == bound {
			return true, b
		}
	}
	switch e := bound.(type) {

	case *ast.CallExpr:
		for _, b := range t.Known_bounds.List {
			switch e1 := b.Name.(type) {
			case *ast.CallExpr:
				switch i := e.Fun.(type) {
				case *ast.Ident:
					switch i1 := e1.Fun.(type) {
					case *ast.Ident:
						if i.Name == i1.Name {
							if len(e.Args) > 0 && len(e1.Args) > 0 {
								if IdenticalExpr(e.Args[0], e1.Args[0]) {
									return true, b
								}
							}
						}
					}
				}
			}
		}
	case *ast.ForStmt:
		switch bin_expr := e.Cond.(type) {
		case *ast.BinaryExpr:
			if bin_expr.Op == token.LEQ || bin_expr.Op == token.LSS { // <, <=
				// check if the right hand side is a constant
				for _, b := range t.Known_bounds.List {
					if IdenticalExpr(bin_expr.Y, b.Name) {
						return true, b
					}
				}
			} else if bin_expr.Op == token.GEQ || bin_expr.Op == token.GTR { // >, >=

				// check if the initialisation is a constant
				switch assign := e.Init.(type) {
				case *ast.AssignStmt:
					for _, rh := range assign.Rhs {
						for _, b := range t.Known_bounds.List {
							if IdenticalExpr(rh, b.Name) {
								return true, b
							}
						}
					}
				}
			}
		}
	case *ast.RangeStmt:
		for _, b := range t.Known_bounds.List {
			if IdenticalExpr(b.Name, e.X) {
				return true, b
			}
		}
	case ast.Expr:
		for _, b := range t.Known_bounds.List {
			if IdenticalExpr(e, b.Name) {
				return true, b
			}
		}
	}

	return false, nil
}
