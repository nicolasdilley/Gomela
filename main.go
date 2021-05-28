package main

import (
	"flag"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"path/filepath"
	"strconv"
	"strings"
	"time"

	"github.com/fatih/color"
	"github.com/nicolasdilley/gomela/promela"
	"github.com/nicolasdilley/gomela/stats"
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

type VerificationInfo struct {
	multi_list                          *string
	multi_projects                      *string
	single_project                      *string
	num_concurrency_primitive_as_global int
	unused_mutex                        int
	unused_wg                           int
	unused_chan                         int
	// single_file    *string
}

var (
	NUM_OF_MODELS            int = 0
	NUM_OF_EXECUTABLE_MODELS int = 0
	RESULTS_FOLDER               = "result"
	PROJECTS_FOLDER              = "../projects"
	AUTHOR_PROJECT_SEP           = "--"
	PACKAGE_MODEL_SEP            = "++"
)

func main() {

	// connecting to github to parse all git projects
	// add timestamps to name of folder

	_, err := os.Stat(PROJECTS_FOLDER)

	if os.IsNotExist(err) { // create the projects folder if not there
		errDir := os.MkdirAll(PROJECTS_FOLDER, 0755)
		if errDir != nil {
			log.Fatal(err)
		}
	}

	f, _ := os.OpenFile("./"+RESULTS_FOLDER+"/package_errors.csv",
		os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	os.Stderr = f
	defer f.Close()

	ver := &VerificationInfo{}

	projects := flag.String("p", "", "a folder that contains all the projects.")

	ver.multi_list = flag.String("l", "", "a .csv is also given as args and contains a list of github.com projects with their commits to parse.")
	ver.multi_projects = flag.String("mp", "", "Recursively loop through the folder given and parse all folder that contains a go file.")
	ver.single_project = flag.String("s", "", "a single project is given to parse. Format \"creator/project_name\"")

	flag.Parse()
	if *projects != "" {
		PROJECTS_FOLDER = *projects
	}

	switch os.Args[1] {
	case "model": // the user wants to generate the model
		model(ver)
		fmt.Println("Num of global concurrency primitives ", ver.num_concurrency_primitive_as_global)
	case "verify": // the user wants to verify a .pml file with specifics bounds

		if len(os.Args) > 2 && strings.Contains(os.Args[2], ".pml") {
			model_to_verify := os.Args[2]

			// parse how many comm pars are in the file

			content, err := ioutil.ReadFile(model_to_verify)

			if err != nil {
				panic("Please provide a valid file , err : " + err.Error())
			}

			mand_params, opt_params := findNumCommParam(string(content))

			if len(os.Args)-3-mand_params-opt_params != 0 {
				panic("Please provide a value for each comm parameter in the order they appear in the program, num params = " + fmt.Sprint(mand_params+opt_params) + ", num args given " + fmt.Sprint(len(os.Args)))
			} else {
				verifyModelWithSpecificValues(string(content), os.Args[3:])
			}
		} else {
			panic("Please provide a .pml file : ie. gomela verify hello.pml")
		}
	case "full_stats": // Generate a set of stats for each projects and models
		stats.Stats()
	case "stats":
		printStats()
	case "fs": // Full scale model -> verify -> stats
		model(ver)
		verify(ver, RESULTS_FOLDER)

	case "bmc":

		if len(os.Args) > 2 {
			verify(ver, os.Args[2])
		} else {
			panic("Please provide a folder that contains the .pml that you want to parse or a pml that you want to verify.")
		}
	case "commit": // produce a list of commit from given list of projects
		commit(ver)

	case "sanity": // remove the .pml files that do nothing
		if len(os.Args) > 2 {
			del := false
			if len(os.Args) > 3 {
				del = true
			}
			num_unsain := sanity(ver, os.Args[2], del)

			fmt.Println("Removed a total of ", num_unsain, " files which did not contain any concurrent interactions")
			fmt.Println("Num of mutex : ", ver.unused_mutex)
			fmt.Println("Num of wg : ", ver.unused_wg)
			fmt.Println("Num of chan : ", ver.unused_chan)
		} else {
			panic("You need to provide a folder containing the .pml or a .pml file.")
		}

	default:
		panic("You need to provide a projects list as a .csv file. ie 'gomela commit projects.csv'")
	}

}

func findNumCommParam(content string) (int, int) {
	mand_params := 0
	opt_params := 0

	lines := strings.Split(content, "\n")

	for _, line := range lines {
		if strings.Contains(line, "num_mand_comm_params") {
			splitted := strings.Split(line, "num_mand_comm_params=")

			n, _ := strconv.Atoi(splitted[1])

			mand_params += n
		}

		if strings.Contains(line, "num_opt_comm_params") {
			splitted := strings.Split(line, "num_opt_comm_params=")

			n, _ := strconv.Atoi(splitted[1])

			opt_params += n
		}

	}

	return mand_params, opt_params
}

func sanity(ver *VerificationInfo, path string, del bool) int {
	unsain_file := 0

	if strings.Contains(path, ".pml") {
		if !sanityCheckFile(ver, path, del) {
			unsain_file++
		}
	} else {
		f, err := os.Stat(path)

		if err != nil {
			panic("Could not read file/folder " + path)
		}
		if f.IsDir() {
			filepath.Walk(path,
				func(fpath string, info os.FileInfo, err error) error {
					if info.IsDir() && fpath != path {
						unsain_file += sanity(ver, fpath, del)
						return filepath.SkipDir
					} else if strings.Contains(fpath, ".pml") {
						if !sanityCheckFile(ver, fpath, del) {
							unsain_file++
						}
					}
					return nil
				})
		} else {
			panic("The file provided should be a .pml file or a directory")
		}
	}

	return unsain_file
}

func sanityCheckFile(ver *VerificationInfo, path string, del bool) bool {
	data, e := ioutil.ReadFile(path)

	if e != nil {
		panic("Could not read file " + path)
	}

	model := strings.Split(string(data), "/*")[0]

	used := false
	for _, line := range strings.Split(model, "\n") {
		if strings.Contains(line, ".update!") { // add
			used = true
		}

		if strings.Contains(line, ".wait?") { // add
			used = true
		}

		if strings.Contains(line, ".Lock!") { // add
			used = true
		}

		if strings.Contains(line, ".RLock!") { // add
			used = true
		}
		if strings.Contains(line, ".Unlock!") { // add
			used = true
		}
		if strings.Contains(line, ".RUnlock!") { // add
			used = true
		}
		if strings.Contains(line, ".deq?") { // add
			used = true
		}
		if strings.Contains(line, ".rcving!") { // add
			used = true
		}
		if strings.Contains(line, ".sending!") { // add
			used = true
		}
		if strings.Contains(line, ".sync") { // add
			used = true
		}
		if strings.Contains(line, ".enq!") { // add
			used = true
		}
	}

	if !used {

		for _, line := range strings.Split(model, "\n") {
			if strings.Contains(line, "run mutexMonitor") { // Mutex
				fmt.Println(line)
				ver.unused_mutex++
			}
			if strings.Contains(line, "run wgMonitor") { // wg
				ver.unused_wg++
			}
			if strings.Contains(line, "run sync_monitor") { // Chan
				ver.unused_chan++
			}
		}
		// check whether it contains a channel, wg or mutex

		if del {
			os.Remove(path)
		}
		return false
	}
	return true
}
func commit(ver *VerificationInfo) {

	// parse multiple projects
	if len(os.Args) > 2 {
		if strings.HasSuffix(os.Args[2], ".csv") || strings.HasSuffix(os.Args[2], ".txt") {

			// parse each projects
			data, e := ioutil.ReadFile(os.Args[2])
			if e != nil {
				fmt.Printf("prevent panic by handling failure accessing a path %q: %v\n", os.Args[2], e)
				return
			}
			projects_commit := ""
			proj_listings := strings.Split(string(data), "\n")
			fmt.Println(len(proj_listings), " projects to parse")
			for _, project := range proj_listings[:len(proj_listings)-1] {
				if strings.Contains(project, ",") {
					project_info := strings.Split(project, ",")
					if len(project_info) > 1 {
						panic("Commit already present")

					} else {

						// clone repo and get commit
						commit := CloneRepoAndGetCommit(project)
						projects_commit += project + "," + commit + "\n"
					}
				} else {
					// clone repo and get commit
					commit := CloneRepoAndGetCommit(project)
					projects_commit += project + "," + commit + "\n"
				}
			}

			ioutil.WriteFile("commits.csv", []byte(projects_commit), 0664)

		} else {
			fmt.Println("Please provide a .csv or .txt file containing the list of projects to be parsed")
		}
	}
}

// genreate a model based on input and return the flags left
func model(ver *VerificationInfo) []string {
	t := time.Now().Local().Format("2006-01-02--15:04:05")
	RESULTS_FOLDER += t
	os.Mkdir(RESULTS_FOLDER, os.ModePerm)
	promela.CreateCSV(RESULTS_FOLDER)
	switch os.Args[2] {
	case "l":
		// parse multiple projects
		if len(os.Args) > 3 {
			if strings.HasSuffix(os.Args[3], ".csv") {

				// parse each projects
				data, e := ioutil.ReadFile(os.Args[3])
				if e != nil {
					panic(fmt.Sprintf("prevent panic by handling failure accessing a path %q: %v\n", os.Args[3], e))
				}
				proj_listings := strings.Split(string(data), "\n")
				fmt.Println(len(proj_listings), " projects to parse")
				for _, project := range proj_listings[:len(proj_listings)-1] {
					if strings.Contains(project, ",") {
						project_info := strings.Split(project, ",")
						if len(proj_listings) > 1 {
							parseProject(project_info[0], project_info[1], ver)
						}
					} else {
						parseProject(project, "master", ver)
					}
				}

				fmt.Println(NUM_OF_EXECUTABLE_MODELS, "/", NUM_OF_MODELS, " executable models overall.")

			} else {
				fmt.Println("Please provide a .csv file containing the list of projects to be parsed")
			}
		}
		return os.Args[3:]
	case "mp":
		path := os.Args[3]
		// PROJECTS_FOLDER = path

		files, _ := ioutil.ReadDir(path)

		for _, f := range files {
			parseFolder(path+f.Name(), ver)
		}
		return os.Args[3:]
	case "s":
		// parse project given
		parseProject(os.Args[3], "master", ver)
		return os.Args[3:]
	default:

		path := os.Args[2]
		// PROJECTS_FOLDER = path

		_, err := ioutil.ReadDir(path)

		if err != nil {
			panic("please give a valid folder to parse.")
		}
		packages := []string{}
		filepath.Walk(path, func(path string, file os.FileInfo, err error) error {

			if file.IsDir() {
				if file.Name() != "vendor" && file.Name() != "third_party" {
					path, _ = filepath.Abs(path)
					packages = append(packages, path)
				} else {
					return filepath.SkipDir
				}
			}
			return nil
		})

		inferProject(path, filepath.Base(path), "", packages, ver)
		if len(os.Args) > 3 {
			return os.Args[3:]
		}
		return []string{}
	}

	if len(os.Args) > 4 {
		return os.Args[4:]
	}

	return []string{}

}

func verify(ver *VerificationInfo, toParse string) {
	// toPrint := "Model, Opt, #states, Time (ms), Channel Safety Error, Global Deadlock, Error, Comm param info, Link,\n"

	toPrint := ""

	// check if toParse is a folder or a .pml file

	f, err := os.Stat(toParse)

	if err != nil {
		panic("The folder given cannot be parsed")
	}
	bounds_to_check := []interface{}{}
	if len(os.Args) > 3 {
		for _, b := range os.Args[3:] {
			num, err := strconv.Atoi(b)

			if err != nil {
				panic("Should provide a number for the bounds. Got : " + b)
			}

			bounds_to_check = append(bounds_to_check, num)
		}
	}

	if f.IsDir() {
		RESULTS_FOLDER = toParse
		// Print CSV
		f, err := os.OpenFile("./"+toParse+"/verification.csv",
			os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)

		if err != nil {
			fmt.Println("Could not create file verification.csv")
			return
		}
		if _, err := f.WriteString(toPrint); err != nil {
			panic(err)
		}

		projects, err := ioutil.ReadDir(RESULTS_FOLDER)
		if err != nil {
			fmt.Println("Could not read folder :", RESULTS_FOLDER)
		}

		for _, p := range projects {
			if p.IsDir() {
				//verify the models inside the projects

				models, err := ioutil.ReadDir(RESULTS_FOLDER + "/" + p.Name())
				if err != nil {
					fmt.Println("Could not read folder :", p)
				}
				VerifyModels(models, p.Name(), bounds_to_check)
			}
		}
	} else { // a single .pml has been given as arg

		path, _ := filepath.Abs("./")
		RESULTS_FOLDER = path
		VerifyModels([]os.FileInfo{f}, "", bounds_to_check)
	}

}

func parseFolder(path string, ver *VerificationInfo) {
	files, _ := ioutil.ReadDir(path)

	containsGoFile := false
	for _, f := range files {
		if strings.Contains(f.Name(), ".go") {
			containsGoFile = true
		}
	}

	if containsGoFile {
		packages := []string{}
		filepath.Walk(path, func(path string, file os.FileInfo, err error) error {
			if file.IsDir() {
				if file.Name() != "vendor" && file.Name() != "third_party" {
					path, _ = filepath.Abs(path)
					packages = append(packages, path)
				} else {
					return filepath.SkipDir
				}
			}
			return nil
		})

		inferProject(path, filepath.Base(path), "", packages, ver)

	} else {
		for _, f := range files {
			parseFolder(path+f.Name(), ver)
		}
	}
}

func parseProject(project_name string, commit string, ver *VerificationInfo) {

	fmt.Println("Infering : " + project_name)

	path_to_dir, commit_hash, err := CloneRepo(project_name, commit)

	if err == nil {
		packages := []string{}

		err = filepath.Walk(path_to_dir, func(path string, info os.FileInfo, err error) error {

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
	} else {
		fmt.Println("Could not download project ", project_name)
	}
}

type Param struct {
	Name      string
	Mandatory bool
}

func printStats() {
	if len(os.Args) > 2 {
		// read file
		data, e := ioutil.ReadFile(os.Args[2])

		if e != nil {
			panic("The file provided " + os.Args[2] + " could not be open")
		}

		// print stats

		lines := strings.Split(string(data), "\n")

		params := []Param{}

		for _, line := range lines {
			if strings.Contains(line, "//") && (strings.Contains(line, " opt ") || strings.Contains(line, " mand ")) {
				splitted := strings.Split(line, "//")
				splitted = strings.Split(splitted[1], " ")
				param := Param{Name: splitted[2], Mandatory: splitted[1] == "mand"}
				params = append(params, param)
			}
		}

		fmt.Println("Num comm params : ", len(params))
		fmt.Println("Mandatory Param : ")
		for _, param := range params {

			if param.Mandatory {
				fmt.Println(param.Name)
			}
		}

		fmt.Println("Optionnal Param : ")
		for _, param := range params {

			if !param.Mandatory {
				fmt.Println(param.Name)
			}

		}
	} else {
		panic("Please provide a .pml file : ie, gomela stats hello.pml")
	}
}

func inferProject(path string, dir_name string, commit string, packages []string, ver *VerificationInfo) {

	// Partition program
	dir_name = strings.Replace(dir_name, "/", AUTHOR_PROJECT_SEP, -1)
	f, ast_map := GenerateAst(path, packages, dir_name)

	if f != nil {
		projects_folder, _ := filepath.Abs(PROJECTS_FOLDER)
		ParseAst(f, dir_name, commit, ast_map, ver, RESULTS_FOLDER, projects_folder)

		// Have a way to give values to individual candidates and unknown parameter

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
