package main

import (
	"bytes"
	"flag"
	"fmt"
	"io/ioutil"
	"os"
	"os/exec"
	"path"
	"path/filepath"
	"strconv"
	"strings"

	"github.com/fatih/color"
	"github.com/nicolasdilley/gomela/promela"
)

const (
	SOURCE_FOLDER  = "./source"  // The folder containing the projects to verify
	RESULTS_FOLDER = "./results" // The folder where the models of the projects in /source are placed
)

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

func main() {

	logger := &Logger{
		Counters: []promela.Counter{},
	}

	// Create the results folder
	os.RemoveAll(RESULTS_FOLDER)
	os.Mkdir(RESULTS_FOLDER, os.ModePerm)

	if len(os.Args) > 1 {

		multi_projects := flag.Bool("l", false, "a .csv is also given as args and contains a list of github.com projects to parse")

		flag.Parse()

		if *multi_projects {
			// parse multiple projects
			if len(os.Args) > 2 {
				if strings.HasSuffix(os.Args[2], ".txt") {

					// parse each projects
					data, e := ioutil.ReadFile(os.Args[2])

					if e != nil {
						fmt.Printf("prevent panic by handling failure accessing a path %q: %v\n", os.Args[2], e)
						return
					}
					proj_listings := strings.Split(string(data), "\n")

					for i, project_name := range proj_listings {
						if i < len(project_name) {
							parseProject(logger, project_name)
						}
					}

				} else {
					fmt.Println("Please provide a .txt file containing the list of projects to be parsed")
				}
			}

		} else {
			// parse project given
			parseProject(logger, os.Args[1])
		}
	} else {

		files, e := ioutil.ReadDir(SOURCE_FOLDER)

		if e != nil {
			fmt.Printf("Could not open folder /source %q: %v\n", os.Args[1], e)
			return
		}

		for _, dir := range files {
			if dir.IsDir() {
				fmt.Println("Infering : " + dir.Name())

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
				inferProject(logger, path, dir.Name(), "", packages)
			}
		}

		return
	}

	// Print logger
	d1 := []byte(logger.PrintHTML())
	fmt.Println("Writing log file.")
	filename := "./results/log.html"
	err := ioutil.WriteFile(filename, d1, 0644)
	if err != nil {
		panic(err)
	}

	// Print CSV
	d1 = []byte(logger.PrintCSV())
	filename = "./results/log.csv"
	err = ioutil.WriteFile(filename, d1, 0644)

	if err != nil {
		panic(err)
	}
}

func parseProject(logger *Logger, project_name string) {

	fmt.Println("Infering : " + project_name)

	path_to_dir, commit_hash := CloneRepo(project_name)

	packages := []string{}

	err := filepath.Walk(path_to_dir, func(path string, info os.FileInfo, err error) error {

		if err != nil {
			fmt.Printf("prevent panic by handling failure accessing a path %q: %v\n", path_to_dir, err)
			return err
		}

		if info.IsDir() {

			if info.Name() != "vendor" && info.Name() != "tests" {
				packages = append(packages, "."+strings.TrimPrefix(path, path_to_dir))
			} else {
				return filepath.SkipDir
			}
		}
		return nil
	})

	fmt.Println(packages)

	inferProject(logger, path_to_dir, path.Base(project_name), commit_hash, packages)
	if err != nil {
		fmt.Printf("Error walking the path %q: %v\n", path_to_dir, err)
	}
	defer os.RemoveAll(path_to_dir) // clean up
}

func inferProject(logger *Logger, path string, dir_name string, commit string, packages []string) {

	// Partition program

	f, ast_map := GenerateAst(path, packages)
	ParseAst(logger, f, dir_name, commit, ast_map)

	models, err := ioutil.ReadDir(RESULTS_FOLDER + "/" + dir_name)
	if err != nil {
		fmt.Println("Could not read folder :", RESULTS_FOLDER+"/"+dir_name)
	}

	// verify each model
	for _, model := range models {
		if strings.HasSuffix(model.Name(), ".pml") { // make sure its a .pml file
			fmt.Println("Verifying model : " + model.Name())
			ver := VerificationRun{Safety_error: true, Partial_deadlock: true, Global_deadlock: true}
			path, _ := filepath.Abs(RESULTS_FOLDER + "/" + dir_name + "/" + model.Name())
			var output bytes.Buffer

			// Verify with SPIN
			command := exec.Command("spin", "-run", "-m1000000", "-w26", path, "-f")
			command.Stdout = &output
			command.Run()

			parseResults(output.String(), &ver)

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

func parseResults(result string, ver *VerificationRun) {

	if !strings.Contains(result, "assertion violated") {
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

func tickIt(tick bool) string {
	if !tick {
		return "\\cmark"
	} else {
		return "\\xmark"
	}
}
