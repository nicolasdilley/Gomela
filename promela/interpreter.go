package promela

import (
	"io/ioutil"
	"os"
	"strconv"
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

func Print(m *Model) {

	stmt := ""

	// print the bounds
	for _, c := range m.Defines {
		stmt += c.Print(0) + "\n"
	}

	// print the function inline
	for _, c := range m.Inlines {
		stmt += c.Print(0) + "\n"
	}

	stmt += "\n"

	splitted := strings.Split(
		strings.Split(
			m.Fileset.Position(m.Fun.Pos()).Filename, m.Projects_folder+"/")[1],
		"/")

	path := splitted[1:]

	file_path := ""

	for i, p := range path {
		file_path += p

		if i < len(path)-1 {
			file_path += "/"
		}
	}
	proj_name := strings.Replace(splitted[0], AUTHOR_PROJECT_SEP, "/", -1)
	stmt += "// https://github.com/" + proj_name + "/blob/" + m.Commit + "/" + file_path + "#L" + strconv.Itoa(m.Fileset.Position(m.Fun.Pos()).Line) + "\n"

	// add chans to the chandef
	chan_struct := promela_ast.ChanStructDef{Name: &promela_ast.Ident{Name: "Chandef"}, Defs: []*promela_ast.Chandef{}} // creating the struct that will represent the go channel
	sync := &promela_ast.Chandef{Name: &promela_ast.Ident{Name: "sync"}, Types: []promela_types.Types{promela_types.Bool, promela_types.Int}, Size: &promela_ast.Ident{Name: "0"}}
	async_send := &promela_ast.Chandef{Name: &promela_ast.Ident{Name: "async_send"}, Types: []promela_types.Types{promela_types.Int}, Size: &promela_ast.Ident{Name: "0"}}
	async_rcv := &promela_ast.Chandef{Name: &promela_ast.Ident{Name: "async_rcv"}, Types: []promela_types.Types{promela_types.Bool, promela_types.Int}, Size: &promela_ast.Ident{Name: "0"}}
	sending := &promela_ast.Chandef{Name: &promela_ast.Ident{Name: "sending"}, Types: []promela_types.Types{promela_types.Int}, Size: &promela_ast.Ident{Name: "0"}}
	closing := &promela_ast.Chandef{Name: &promela_ast.Ident{Name: "closing"}, Types: []promela_types.Types{promela_types.Bool}, Size: &promela_ast.Ident{Name: "0"}}
	chan_struct.Defs = append(chan_struct.Defs, sync, async_send, async_rcv, sending, closing)

	// add attributes to the chandef
	size := &promela_ast.DeclStmt{Name: &promela_ast.Ident{Name: "size"}, Rhs: &promela_ast.Ident{Name: "0"}, Types: promela_types.Int}
	num_msgs := &promela_ast.DeclStmt{Name: &promela_ast.Ident{Name: "num_msgs"}, Rhs: &promela_ast.Ident{Name: "0"}, Types: promela_types.Int}
	closed := &promela_ast.DeclStmt{Name: &promela_ast.Ident{Name: "closed"}, Rhs: &promela_ast.Ident{Name: "false"}, Types: promela_types.Bool}
	chan_struct.Decls = append(chan_struct.Decls, size, num_msgs, closed)

	// print Wgdef
	wg_struct := promela_ast.WgStructDef{Name: &promela_ast.Ident{Name: "Wgdef"}, Defs: []*promela_ast.Chandef{}} // creating the struct that will represent the go channel
	add := &promela_ast.Chandef{Name: &promela_ast.Ident{Name: "Add"}, Types: []promela_types.Types{promela_types.Int}, Size: &promela_ast.Ident{Name: "0"}}
	wait := &promela_ast.Chandef{Name: &promela_ast.Ident{Name: "Wait"}, Types: []promela_types.Types{promela_types.Int}, Size: &promela_ast.Ident{Name: "0"}}
	wg_struct.Defs = append(wg_struct.Defs, add, wait)

	b := promela_ast.BlockStmt{List: []promela_ast.Stmt{}}

	// setting the size of the int chan
	for _, c := range m.Global_vars {
		b.List = append(b.List, c)
	}
	if m.ContainsChan {
		stmt += chan_struct.Print(0)
	}
	if m.ContainsWg {
		stmt += wg_struct.Print(0)
	}
	stmt += "\n"
	stmt += b.Print(0)
	stmt += "\n\n"
	stmt += m.Init.Print(0)
	stmt += "\n"

	for _, proc := range m.Proctypes {
		stmt += proc.Print(0)
	}

	stmt += "\n /* ================================================================================== */"
	stmt += "\n /* ================================================================================== */"
	stmt += "\n /* ================================================================================== */ \n"
	if m.ContainsChan {
		stmt += GenerateAsyncMonitor() + generateSyncChanMonitor()
	}

	if m.ContainsWg {
		stmt += GenerateStructMonitor()
	}

	folder := "./" + m.Result_fodler + "/" + strings.Replace(m.Project_name, "/", "-", -1)
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
