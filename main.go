package main

import (
	"bytes"
	"flag"
	"fmt"
	"io/ioutil"
	"os"
	"os/exec"
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

type VerificationInfo struct {
	multi_projects *string
	single_project *string
	verify         *bool
	lb             *int
	ub             *int
}

func main() {

	// Create the results folder
	os.RemoveAll(RESULTS_FOLDER)
	os.Mkdir(RESULTS_FOLDER, os.ModePerm)

	ver := &VerificationInfo{}

	ver.multi_projects = flag.String("l", "", "a .csv is also given as args and contains a list of github.com projects to parse.")
	ver.single_project = flag.String("s", "", "a single project is given to parse. Format \"creator/project_name\"")
	ver.verify = flag.Bool("v", false, "Specify that the models need to be verified.")
	ver.lb = flag.Int("lb", -1, "The default lower bound value to give to not well formed for loop.")
	ver.ub = flag.Int("ub", -1, "The default upper bound value to give to not well formed for loop.")

	flag.Parse()

	promela.CreateCSV()
	if *ver.multi_projects != "" {
		// parse multiple projects
		if len(os.Args) > 2 {
			if strings.HasSuffix(*ver.multi_projects, ".txt") {

				// parse each projects
				data, e := ioutil.ReadFile(*ver.multi_projects)

				if e != nil {
					fmt.Printf("prevent panic by handling failure accessing a path %q: %v\n", *ver.multi_projects, e)
					return
				}
				proj_listings := strings.Split(string(data), "\n")
				fmt.Println(len(proj_listings))
				for i, project_name := range proj_listings {
					if i < len(proj_listings) {
						parseProject(project_name, ver)
					}
				}

			} else {
				fmt.Println("Please provide a .txt file containing the list of projects to be parsed")
			}
		}

	} else if *ver.single_project != "" {
		// parse project given
		parseProject(*ver.single_project, ver)
	} else {

		files, e := ioutil.ReadDir(SOURCE_FOLDER)

		if e != nil {
			fmt.Printf("Could not open folder /source %q: %v\n", *ver.multi_projects, e)
			return
		}

		for _, dir := range files {
			if dir.IsDir() {
				fmt.Println("Infering : " + dir.Name())

				path, _ := filepath.Abs(SOURCE_FOLDER + "/" + dir.Name())

				packages := []string{}
				filepath.Walk(path, func(path string, file os.FileInfo, err error) error {
					if file.IsDir() {
						if file.Name() != "vendor" && file.Name() != "third_party" {
							packages = append(packages, path)
						} else {
							return filepath.SkipDir
						}
					}
					return nil
				})
				inferProject(path, dir.Name(), "", packages, ver)
			}
		}
	}

}

func parseProject(project_name string, ver *VerificationInfo) {

	fmt.Println("Infering : " + project_name)

	path_to_dir, commit_hash := CloneRepo(project_name)

	packages := []string{}

	err := filepath.Walk(path_to_dir, func(path string, info os.FileInfo, err error) error {

		if err != nil {
			fmt.Printf("prevent panic by handling failure accessing a path %q: %v\n", path_to_dir, err)
			return err
		}

		if info.IsDir() {

			if info.Name() != "vendor" {
				packages = append(packages, "."+strings.TrimPrefix(path, path_to_dir))
			} else {
				return filepath.SkipDir
			}
		}
		return nil
	})

	inferProject(path_to_dir, project_name, commit_hash, packages, ver)
	if err != nil {
		fmt.Printf("Error walking the path %q: %v\n", path_to_dir, err)
	}
	defer os.RemoveAll(path_to_dir) // clean up
}

func inferProject(path string, dir_name string, commit string, packages []string, ver *VerificationInfo) {

	// Partition program

	f, ast_map := GenerateAst(path, packages)
	if f != nil {
		ParseAst(f, dir_name, commit, ast_map, ver)

		models, err := ioutil.ReadDir(RESULTS_FOLDER + "/" + filepath.Base(dir_name))
		if err != nil {
			fmt.Println("Could not read folder :", RESULTS_FOLDER+"/"+filepath.Base(dir_name))
		}

		if *ver.verify {
			// verify each model
			for _, model := range models {
				if strings.HasSuffix(model.Name(), ".pml") { // make sure its a .pml file
					fmt.Println("Verifying model : " + model.Name())
					ver := VerificationRun{Safety_error: true, Partial_deadlock: true, Global_deadlock: true}
					path, _ := filepath.Abs(RESULTS_FOLDER + "/" + filepath.Base(dir_name) + "/" + model.Name())
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
	} else {
		fmt.Println("Error while parsing project")
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
