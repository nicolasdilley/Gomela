package main

import (
	"bytes"
	"fmt"
	"io/ioutil"
	"os"
	"os/exec"
	"path/filepath"
	"strconv"
	"strings"

	"github.com/fatih/color"
)

var (
	NUM_OF_TESTS   = 10
	SOURCE_FOLDER  = "./source"
	RESULTS_FOLDER = "./results"
)

func main() {

	if len(os.Args) > 1 {

		path, _ := filepath.Abs("./tests")

		packages := []string{path}

		f, ast_map := GenerateAst(packages)
		ParseAst(f, "test", ast_map)

		return
	}

	os.RemoveAll(RESULTS_FOLDER)
	os.Mkdir(RESULTS_FOLDER, os.ModePerm)
	files, e := ioutil.ReadDir(SOURCE_FOLDER)

	if e != nil {
		fmt.Printf("Could not open folder /source %q: %v\n", os.Args[1], e)
		return
	}

	// projects := []ProjectResult{}

	for _, dir := range files {

		if dir.IsDir() {

			fmt.Println("Infering : " + dir.Name())

			// 			// need to create 10 benchmark and take average

			path, _ := filepath.Abs(SOURCE_FOLDER + "/" + dir.Name())

			packages := []string{}
			filepath.Walk(path, func(path string, file os.FileInfo, err error) error {

				if file.IsDir() {
					if file.Name() != "vendor" && file.Name() != "tests" {
						packages = append(packages, path)
					} else {
						return filepath.SkipDir
					}
				}
				return nil
			})

			gopologyTest(path, dir.Name(), packages)
		}
	}

	return
}

func gopologyTest(path string, dir_name string, packages []string) {

	// 	project := ProjectResult{Name: dir_name}
	// 	infer := time.Now()

	// 	// Partition program
	f, ast_map := GenerateAst(packages)
	ParseAst(f, dir_name, ast_map)

	// 	// Verify with SPIN
	models, _ := ioutil.ReadDir(RESULTS_FOLDER + "/" + dir_name)

	// 	// verify each part
	for _, model := range models {
		if strings.HasSuffix(model.Name(), ".pml") {
			fmt.Println("Verifying model : " + model.Name())
			var ver VerificationRun = VerificationRun{Safety_error: true, Partial_deadlock: true, Global_deadlock: true}
			path, _ := filepath.Abs(RESULTS_FOLDER + "/" + dir_name + "/" + model.Name())
			var output bytes.Buffer

			command := exec.Command("spin", "-run", "-m1000000", "-w26", path, "-f")
			command.Stdout = &output
			command.Run()

			parseResults(output.String(), &ver)

			fmt.Println(ver)
			fmt.Println("-------------------------------")
			fmt.Println("Result for " + model.Name())
			fmt.Println("Number of states : ", ver.Num_states)
			fmt.Println("Time to verify model : ", ver.Spin_timing, " ms")
			fmt.Printf("Channel safety error : %s.\n", colorise(ver.Safety_error))
			fmt.Printf("Global deadlock : %s.\n", colorise(ver.Global_deadlock))
			fmt.Println("-------------------------------")
		}
	}

}

func colorise(flag bool) string {

	green := color.New(color.FgGreen).SprintFunc()
	red := color.New(color.FgRed).SprintFunc()

	if flag {
		return red("true")
	}

	return green("false")
}

// --------- BENCHMARK CODE ----------
// 	os.RemoveAll("./results")
// 	os.Mkdir("./results", os.ModePerm)
// 	files, e := ioutil.ReadDir("./benchmarks")

// 	if e != nil {
// 		fmt.Printf("prevent panic by handling failure accessing a path %q: %v\n", os.Args[1], e)
// 		return
// 	}

// 	projects := []ProjectResult{}

// 	for _, dir := range files {

// 		if dir.IsDir() {

// 			fmt.Println("Parsing : " + dir.Name())

// 			// need to create 10 benchmark and take average

// 			path, _ := filepath.Abs("./benchmarks/" + dir.Name())

// 			packages := []string{}
// 			filepath.Walk(path, func(path string, file os.FileInfo, err error) error {

// 				if file.IsDir() {
// 					if file.Name() != "vendor" && file.Name() != "tests" {
// 						packages = append(packages, path)
// 					} else {
// 						return filepath.SkipDir
// 					}
// 				}
// 				return nil
// 			})

// 			// calculate average
// 			godel_average := 0
// 			spin_average := 0
// 			infer_average := 0
// 			migoinfer_average := 0

// 			test_projects := []ProjectResult{}
// 			models := []int{}
// 			for i := 0; i < NUM_OF_TESTS; i++ {
// 				proj := gopologyTest(path, dir.Name(), packages)
// 				test_projects = append(test_projects, proj)

// 				for i, model := range proj.Models {
// 					models[i] += model.Spin_timing
// 				}

// 				godel_average += proj.Godel_timing
// 				spin_average += proj.Spin_timing
// 				infer_average += proj.Infer_timing
// 				migoinfer_average += proj.Migoinfer_timing
// 			}

// 			overall_result := test_projects[NUM_OF_TESTS-1]

// 			overall_result.Godel_timing = godel_average / NUM_OF_TESTS
// 			overall_result.Spin_timing = spin_average / NUM_OF_TESTS
// 			overall_result.Infer_timing = infer_average / NUM_OF_TESTS
// 			overall_result.Migoinfer_timing = migoinfer_average / NUM_OF_TESTS

// 			for i, model := range models {
// 				overall_result.Models[i].Spin_timing = model / NUM_OF_TESTS
// 			}

// 			projects = append(projects, overall_result)
// 		}
// 	}

// 	printProjects(&projects)
// 	return
// }

// func gopologyTest(path string, dir_name string, packages []string) ProjectResult {

// 	project := ProjectResult{Name: dir_name}
// 	infer := time.Now()

// 	// Partition program
// 	f, ast_map := GenerateAst(packages)
// 	ParseAst(f, dir_name, ast_map)

// 	t := time.Now()
// 	var dur time.Duration = t.Sub(infer)
// 	project.Infer_timing = int((float64(dur.Nanoseconds())) / 1000000.0)

// 	// Verify with SPIN
// 	models, _ := ioutil.ReadDir("./results/" + dir_name)

// 	// verify each part
// 	for _, model := range models {
// 		if strings.HasSuffix(model.Name(), ".pml") {
// 			var ver VerificationRun = VerificationRun{Safety_error: true, Partial_deadlock: true, Global_deadlock: true}
// 			path, _ := filepath.Abs("./results/" + dir_name + "/" + model.Name())
// 			var output bytes.Buffer

// 			command := exec.Command("spin", "-run", "-m1000000", "-w26", path, "-f")
// 			command.Stdout = &output
// 			start := time.Now()
// 			command.Run()

// 			parseResults(output.String(), &ver)

// 			finish := time.Now()
// 			var dur time.Duration = finish.Sub(start)
// 			ver.Spin_timing = int((float64(dur.Nanoseconds())) / 1000000.0)

// 			project.Spin_timing += ver.Spin_timing
// 			project.Models = append(project.Models, ver)
// 			project.Num_states += ver.Num_states
// 			project.Safety_error = project.Safety_error || ver.Safety_error
// 			project.Global_deadlock = project.Global_deadlock || ver.Global_deadlock
// 		}
// 	}

// 	temp_file_name := "./benchmarks/" + dir_name + "/temp"

// 	var out bytes.Buffer
// 	// MigoInfer
// 	command := exec.Command("migoinfer", path+"/main.go")
// 	command.Stdout = &out

// 	start := time.Now()
// 	command.Run()
// 	finish := time.Now()
// 	dur = finish.Sub(start)

// 	project.Migoinfer_timing = int((float64(dur.Nanoseconds())) / 1000000.0)
// 	ioutil.WriteFile(temp_file_name, out.Bytes(), 0644)

// 	start = time.Now()
// 	command = exec.Command("Godel", "-D", temp_file_name)
// 	var output bytes.Buffer
// 	command.Stdout = &output
// 	command.Run()

// 	//Godel
// 	finish = time.Now()
// 	dur = finish.Sub(start)
// 	project.Godel_timing = int((float64(dur.Nanoseconds())) / 1000000.0)
// 	os.Remove(temp_file_name)
// 	return project

func parseResults(result string, ver *VerificationRun) {

	fmt.Println(result)

	if !strings.Contains(result, "assertion violated") {
		fmt.Println("Ici")
		ver.Safety_error = false
	}
	if strings.Contains(result, "errors: 0") {
		ver.Global_deadlock = false
	}

	// Calculates the number of states

	splitted := strings.Split(result, "\n")
	for _, line := range splitted {
		if strings.Contains(line, "states, stored") {

			lines := strings.Split(line, "states, stored")
			r := strings.Replace(lines[0], " ", "", -1)

			states, err := strconv.Atoi(r)
			if err != nil {
				fmt.Println("There was an error in parsing the number of states : ", r)
			}

			ver.Num_states = states
		}
	}
}

func printProjects(projects *[]ProjectResult) {

	os.Remove("./table.tex")

	to_write := "\\begin{center} \n \\begin{tabular}{ c | c | c c | c c c } \n "
	to_write += "Programs & \\# states & $\\psi_s$ & $\\psi_g$ & Infer & Spin & Godel \\\\ \n "
	for _, project := range *projects {

		to_write += project.Name + " & " + fmt.Sprintf("%d", project.Num_states) + " & " + tickIt(project.Safety_error) + " & " + tickIt(project.Global_deadlock) + " & " +
			fmt.Sprintf("%d", project.Infer_timing) + " & " + fmt.Sprintf("%d", project.Spin_timing) + " & " + fmt.Sprintf("%d", project.Godel_timing) + "\\\\ \n"
		if len(project.Models) > 1 {
			for _, model := range project.Models {
				to_write += " & " + fmt.Sprintf("%d", model.Num_states) + " & " + tickIt(model.Safety_error) + " & " + tickIt(model.Global_deadlock) + " & " +
					" - " + " & " + fmt.Sprintf("%d", model.Spin_timing) + " &  $\\emptyset$ \\\\ \n"
			}
		}

	}
	to_write += "\\end{tabular} \n \\end{center} \n"
	ioutil.WriteFile("./table.tex", []byte(to_write), 0644)
}

// proj_listings := strings.Split(string(data), "\n")
// os.Mkdir("results", 0755)
// for _, project_name := range proj_listings {

// 	proj_name := filepath.Base(string(project_name))
// 	var path_to_dir string
// 	var commit_hash string
// 	path_to_dir, commit_hash = CloneRepo(string(project_name))
// 	path_to_main_dir := path_to_dir + "/" + proj_name
// 	list_packages := []string{}
// 	err := filepath.Walk(path_to_main_dir, func(path string, info os.FileInfo, err error) error {

// 		if err != nil {
// 			fmt.Printf("prevent panic by handling failure accessing a path %q: %v\n", path_to_dir, err)
// 			return err
// 		}
// 		if info.IsDir() {
// 			if info.Name() == "vendor" || info.Name() == "tests" || info.Name() == "test" {
// 				fmt.Printf("skipping a dir without errors: %+v \n", info.Name())
// 				return filepath.SkipDir
// 			}
// 			package_name := "github.com/" + project_name + strings.TrimPrefix(path, path_to_main_dir)
// 			list_packages = append(list_packages, package_name)
// 			return nil
// 		}
// 		return nil
// 	})
// 	if err != nil {

// 		fmt.Printf("error walking the path %q: %v\n", path_to_main_dir, err)
// 	}
// 	f, ast_map := GenerateAst(list_packages)
// 	project_info := ParseAst(f, proj_name, path_to_main_dir, commit_hash, ast_map)

// 	project_info.Full_project_name = project_name
// 	fmt.Println("Num of chans : " + strconv.Itoa(len(project_info.Chan_infos)))

// 	for _, channels := range project_info.Chan_infos {
// 		for _, channel := range channels {
// 			channel.Parent.SetCapability(ast_map)
// 			channel.Print()
// 		}
// 	}

// 	Output(&project_info, project_name, commit_hash) // output the result to html files
// 	defer os.RemoveAll(path_to_dir)                  // clean up
// }

func tickIt(tick bool) string {
	if !tick {
		return "\\cmark"
	} else {
		return "\\xmark"
	}
}

type ProjectResult struct {
	Name             string            // the name of the project
	Num_states       int               // The overall number of states needed to verify the whole program
	Infer_timing     int               // time in milli to infer the promela model
	Models           []VerificationRun // Verification run for all Models
	Safety_error     bool              // is there any safety errors
	Global_deadlock  bool              // is there any global deadlock
	Spin_timing      int               // time in milli to verify the program with spin
	Godel_timing     int               // time in milli to verify the program with godel
	Migoinfer_timing int               // time in milli to model the program with migoinfer
}

type VerificationRun struct {
	Spin_timing      int  // time in milli to verify the program
	Safety_error     bool // is there any safety errors
	Global_deadlock  bool // is there any global deadlock
	Partial_deadlock bool // is there any partial deadlock
	Num_states       int  // the number of states in the model
}
