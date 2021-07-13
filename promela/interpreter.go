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

	// print meta-data

	num_mand_param_in_model, num_opt_param_in_model := numCommParInModel(m)
	stmt += "// num_comm_params=" + strconv.Itoa(num_mand_param_in_model+num_opt_param_in_model) + "\n"
	stmt += "// num_mand_comm_params=" + strconv.Itoa(num_mand_param_in_model) + "\n"
	stmt += "// num_opt_comm_params=" + strconv.Itoa(num_opt_param_in_model) + "\n"

	stmt += "\n"

	name := strings.Split(
		m.Fileset.Position(m.Fun.Pos()).Filename, m.Projects_folder+"/")
	path := []string{m.Fileset.Position(m.Fun.Pos()).Filename}

	splitted := []string{""}
	if len(name) > 1 {
		splitted = strings.Split(
			name[1],
			"/")
		path = splitted[1:]
	}

	file_path := ""

	for i, p := range path {
		file_path += p

		if i < len(path)-1 {
			file_path += "/"
		}
	}
	proj_name := strings.Replace(splitted[0], AUTHOR_PROJECT_SEP, "/", -1)
	stmt += "// git_link=https://github.com/" + proj_name + "/blob/" + m.Commit + "/" + file_path + "#L" + strconv.Itoa(m.Fileset.Position(m.Fun.Pos()).Line) + "\n"

	// print the bounds
	for _, c := range m.Defines {
		stmt += c.Print(0) + "\n"
	}
	// print the function inline
	for _, c := range m.Inlines {
		stmt += c.Print(0) + "\n"
	}

	// add chans to the chandef
	chan_struct := promela_ast.ChanStructDef{Name: &promela_ast.Ident{Name: "Chandef"}, Defs: []*promela_ast.Chandef{}} // creating the struct that will represent the go channel
	sync := &promela_ast.Chandef{Name: &promela_ast.Ident{Name: "sync"}, Types: []promela_types.Types{promela_types.Bool}, Size: &promela_ast.Ident{Name: "0"}}
	enqueue := &promela_ast.Chandef{Name: &promela_ast.Ident{Name: "enq"}, Types: []promela_types.Types{promela_types.Int}, Size: &promela_ast.Ident{Name: "0"}}
	deq := &promela_ast.Chandef{Name: &promela_ast.Ident{Name: "deq"}, Types: []promela_types.Types{promela_types.Bool, promela_types.Int}, Size: &promela_ast.Ident{Name: "0"}}
	sending := &promela_ast.Chandef{Name: &promela_ast.Ident{Name: "sending"}, Types: []promela_types.Types{promela_types.Bool}, Size: &promela_ast.Ident{Name: "0"}}
	rcving := &promela_ast.Chandef{Name: &promela_ast.Ident{Name: "rcving"}, Types: []promela_types.Types{promela_types.Bool}, Size: &promela_ast.Ident{Name: "0"}}
	closing := &promela_ast.Chandef{Name: &promela_ast.Ident{Name: "closing"}, Types: []promela_types.Types{promela_types.Bool}, Size: &promela_ast.Ident{Name: "0"}}
	chan_struct.Defs = append(chan_struct.Defs, sync, enqueue, deq, sending, rcving, closing)

	// add attributes to the chandef
	size := &promela_ast.DeclStmt{Name: &promela_ast.Ident{Name: "size"}, Rhs: &promela_ast.Ident{Name: "0"}, Types: promela_types.Int}
	num_msgs := &promela_ast.DeclStmt{Name: &promela_ast.Ident{Name: "num_msgs"}, Rhs: &promela_ast.Ident{Name: "0"}, Types: promela_types.Int}
	closed := &promela_ast.DeclStmt{Name: &promela_ast.Ident{Name: "closed"}, Rhs: &promela_ast.Ident{Name: "false"}, Types: promela_types.Bool}
	chan_struct.Decls = append(chan_struct.Decls, size, num_msgs, closed)

	// print Wgdef
	wg_struct := promela_ast.WgStructDef{Name: &promela_ast.Ident{Name: "Wgdef"}, Defs: []*promela_ast.Chandef{}} // creating the struct that will represent the go channel
	add := &promela_ast.Chandef{Name: &promela_ast.Ident{Name: "update"}, Types: []promela_types.Types{promela_types.Int}, Size: &promela_ast.Ident{Name: "0"}}
	wait := &promela_ast.Chandef{Name: &promela_ast.Ident{Name: "wait"}, Types: []promela_types.Types{promela_types.Int}, Size: &promela_ast.Ident{Name: "0"}}
	wg_struct.Defs = append(wg_struct.Defs, add, wait)

	// print Wgdef
	mutex_struct := promela_ast.MutexStructDef{Name: &promela_ast.Ident{Name: "Mutexdef"}, Defs: []*promela_ast.Chandef{}} // creating the struct that will represent the go channel
	lock := &promela_ast.Chandef{Name: &promela_ast.Ident{Name: "Lock"}, Types: []promela_types.Types{promela_types.Bool}, Size: &promela_ast.Ident{Name: "0"}}
	unlock := &promela_ast.Chandef{Name: &promela_ast.Ident{Name: "Unlock"}, Types: []promela_types.Types{promela_types.Bool}, Size: &promela_ast.Ident{Name: "0"}}
	RLock := &promela_ast.Chandef{Name: &promela_ast.Ident{Name: "RLock"}, Types: []promela_types.Types{promela_types.Bool}, Size: &promela_ast.Ident{Name: "0"}}
	RUnlock := &promela_ast.Chandef{Name: &promela_ast.Ident{Name: "RUnlock"}, Types: []promela_types.Types{promela_types.Bool}, Size: &promela_ast.Ident{Name: "0"}}
	mutex_struct.Defs = append(mutex_struct.Defs, lock, unlock, RLock, RUnlock)

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
	if m.ContainsMutexes {
		stmt += mutex_struct.Print(0)
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
	if m.ContainsMutexes {
		stmt += GenerateMutexMonitor()
	}

	if m.ContainsReceiver {
		stmt += GenerateReceiverProcess()
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

func numCommParInModel(m *Model) (int, int) {
	num_mand_param := 0
	num_opt_param := 0
	// findParam := func(s promela_ast.Stmt) bool {
	// 	num_mand_param := 0
	// 	num_opt_param := 0

	// 	switch s := s.(type) {
	// 	case *promela_ast.CommParamDeclStmt:
	// 		if s.Mandatory {
	// 			num_mand_param++
	// 		} else {
	// 			num_opt_param++
	// 		}

	// 	case *promela_ast.DeclStmt:
	// 		switch rhs := s.Rhs.(type) {
	// 		case *promela_ast.Ident:
	// 			if strings.Contains(rhs.Name, "opt") {
	// 				num_opt_param++
	// 			} else if strings.Contains(rhs.Name, "mand") {
	// 				num_mand_param++
	// 			}
	// 		}

	// 	}
	// 	return true
	// }

	for _, def := range m.Defines {
		switch rhs := def.Rhs.(type) {
		case *promela_ast.Ident:
			if strings.Contains(rhs.Name, "opt") {
				num_opt_param++
			} else if strings.Contains(rhs.Name, "mand") {
				num_mand_param++
			}
		}
	}
	// promela_ast.Inspect(m.Init.Body, findParam)
	// for _, proc := range m.Proctypes {
	// 	promela_ast.Inspect(proc.Body, findParam)
	// }

	// for _, define := range m.Defines {
	// 	switch rhs := define.Rhs.(type) {
	// 	case *promela_ast.Ident:
	// 		if strings.Contains(rhs.Name, "opt") {
	// 			num_opt_param++
	// 		} else if strings.Contains(rhs.Name, "mand") {
	// 			num_mand_param++
	// 		}
	// 	}
	// }

	return num_mand_param, num_opt_param
}
