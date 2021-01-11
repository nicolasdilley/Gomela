package main

import (
	"bytes"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"sort"
	"strconv"
	"strings"
	"time"

	"github.com/fatih/color"
	cartesian "github.com/schwarmco/go-cartesian-product"
)

type VerificationRun struct {
	Spin_timing      int64  // time in milli to verify the program
	Safety_error     bool   // is there any safety errors
	Global_deadlock  bool   // is there any global deadlock
	Partial_deadlock bool   // is there any partial deadlock
	Num_states       int    // the number of states in the model
	Timeout          bool   // Has the verification timedout
	Err              string // if there is another error
}

const (
	MAX_NUMBER_TESTS = 256
)

func VerifyModels(models []os.FileInfo, dir_name string) {
	// Print CSV
	f, err := os.OpenFile("./"+RESULTS_FOLDER+"/verification.csv",
		os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	defer f.Close()

	if err != nil {
		fmt.Println("Could not open file verification.csv")
		return
	}

	// verify each model
	for _, model := range models {
		if strings.HasSuffix(model.Name(), ".pml") { // make sure its a .pml file
			fmt.Println("Verifying model : " + model.Name())
			path, _ := filepath.Abs(RESULTS_FOLDER + "/" + dir_name + "/" + model.Name())

			content, err := ioutil.ReadFile(path)

			if err != nil {
				fmt.Println("Could not read content of : ", path, err)
			} else {
				file_content := string(content)
				lines := strings.Split(file_content, "\n")

				bounds_to_check := []interface{}{0, 1, 3}
				bounds := [][]interface{}{}
				comm_params := []string{} // the name of the mandatory param

				optional_params := 0 // number of optional parameters
				for _, line := range lines {
					if strings.Contains(line, "??") {
						define := strings.Split(line, " ")
						comm_params = append(comm_params, define[1])
						bounds = append(bounds, bounds_to_check)
					}
					if strings.Contains(line, "-2") && strings.Contains(line, "int") && strings.Contains(line, " = ") {
						optional_params += 1
					}
				}

				model_name := filepath.Base(dir_name) + ":" + model.Name()
				fmt.Println("there is ", optional_params, " optionnal params.")
				if len(comm_params) == 0 {
					ver := verifyModel(path, model_name, f, []string{}, []string{})
					if optional_params > 0 {
						verifyWithOptParams(ver, path, model_name, lines, f, []string{}, []string{}, optional_params)
					}
				} else if len(comm_params) > 5 {
					toPrint := filepath.Base(dir_name) + ":" + model.Name() + ",too many comm params : " + strconv.Itoa(len(comm_params)) + ",,,,,\n"
					if _, err := f.WriteString(toPrint); err != nil {
						panic(err)
					}
				} else {

					d := cartesian.Iter(bounds...)

					for bound := range d {
						toPrint := file_content
						for _, b := range bound {
							toPrint = strings.Replace(toPrint, "??", fmt.Sprint(b), 1)
						}

						err := os.Remove(path)
						if err != nil {
							log.Fatal(err)
						}
						ioutil.WriteFile(path, []byte(toPrint), 0644)

						lines = strings.Split(toPrint, "\n")
						bound_str := []string{}
						for _, b := range bound {
							bound_str = append(bound_str, fmt.Sprint(b))
						}
						ver := verifyModel(path, model_name, f, comm_params, bound_str)
						if optional_params > 0 {
							verifyWithOptParams(ver, path, model_name, lines, f, comm_params, bound_str, optional_params)
						}
					}
				}
			}
		}
	}

}

func verifyModel(path string, model_name string, f *os.File, comm_params []string, bound []string) *VerificationRun {

	ver := &VerificationRun{Safety_error: true, Partial_deadlock: true, Global_deadlock: true, Timeout: true}
	var output bytes.Buffer

	// Verify with SPIN
	command := exec.Command("timeout", "30", "spin", "-run", "-DVECTORSZ=4508", "-m100000000", "-w26", path, "-f")
	command.Stdout = &output
	pre := time.Now()
	command.Run()
	after := time.Now()

	ver.Spin_timing = after.Sub(pre).Milliseconds()

	if output.String() == "" {
		toPrint := model_name + ",timeout,timeout,timeout,timeout,timeout,\n"
		if _, err := f.WriteString(toPrint); err != nil {
			panic(err)
		}
	} else {
		ver.Timeout = false
		executable := parseResults(output.String(), ver)
		toPrint := model_name + ",0,the model is not executable,,,,,\n"
		if executable {
			comm_par_info := ""
			fmt.Println("-------------------------------")
			fmt.Println("Result for " + model_name)
			for i, param := range comm_params {
				comm_par_info += fmt.Sprint(param, " = ", bound[i], ",")
				fmt.Println(param, " = ", bound[i])
			}
			fmt.Println("Number of states : ", ver.Num_states)
			fmt.Println("Time to verify model : ", ver.Spin_timing, " ms")
			fmt.Printf("Channel safety error : %s.\n", colorise(ver.Safety_error))
			fmt.Printf("Global deadlock : %s.\n", colorise(ver.Global_deadlock))
			if ver.Err != "" {
				red := color.New(color.FgRed).SprintFunc()
				fmt.Printf("Error : %s.\n", red(ver.Err))
			}
			fmt.Println("-------------------------------")

			toPrint = model_name + ",0," + fmt.Sprintf("%d", ver.Num_states) + "," + fmt.Sprintf("%d", ver.Spin_timing) + "," + fmt.Sprintf("%t", ver.Safety_error) + "," + fmt.Sprintf("%t", ver.Global_deadlock) + "," + ver.Err + "," + comm_par_info + ",\n"

		}

		if _, err := f.WriteString(toPrint); err != nil {
			panic(err)
		}
	}
	return ver
}

func verifyWithOptParams(ver *VerificationRun, path string, model_name string, lines []string, f *os.File, comm_params []string, bound []string, num_optionnal int) {
	if ver.Global_deadlock && !ver.Timeout && ver.Err == "" {
		// add values to the candidates param

		opt_bounds := generateOptBounds(num_optionnal)

		num_tests := 0
		false_alarm_bounds := [][]interface{}{}
		for _, opt_bound := range opt_bounds {

			if num_tests < MAX_NUMBER_TESTS {
				fixed_bound := ""
				// check if the bound has been checked previously
				if !isSuperSeededBy(opt_bound, false_alarm_bounds) {
					new_lines := make([]string, len(lines))
					copy(new_lines, lines)

					for _, b := range opt_bound {
						for i, line := range new_lines {
							if strings.Contains(line, "-2") && strings.Contains(line, "int") && strings.Contains(line, " = ") {
								// we found an optional param
								line = strings.Replace(line, "-2", fmt.Sprint(b), 1)
								new_lines[i] = strings.Replace(line, " = ", "=", 1)
								fixed_bound += strings.Trim(new_lines[i]+" ", "\t")
								break
							}
						}
					}

					err := os.Remove(path) // delete previous model
					if err != nil {
						log.Fatal(err)
					}

					toPrint := ""

					for _, l1 := range new_lines { // generate new content of file with updated value for opt param
						toPrint += l1 + "\n"
					}

					ioutil.WriteFile(path, []byte(toPrint), 0644) // rewrite new model with updated bounds

					ver := VerificationRun{Safety_error: true, Partial_deadlock: true, Global_deadlock: true, Timeout: true}
					var output bytes.Buffer

					// Verify with SPIN
					command := exec.Command("timeout", "30", "spin", "-run", "-DVECTORSZ=4508", "-m10000000", "-w26", path, "-f")
					command.Stdout = &output
					pre := time.Now()
					command.Run()
					after := time.Now()

					ver.Spin_timing = after.Sub(pre).Milliseconds()

					num_tests++
					if output.String() == "" {
						toPrint := model_name + ",timeout with opt param : " + fixed_bound + ",timeout,timeout,timeout,timeout,\n"
						if _, err := f.WriteString(toPrint); err != nil {
							panic(err)
						}
					} else {
						ver.Timeout = false
						executable := parseResults(output.String(), &ver)

						if executable {
							comm_par_info := ""
							fmt.Println("-------------------------------")
							fmt.Println("Result for " + model_name + " with optional params")
							for i, param := range comm_params {
								comm_par_info += fmt.Sprint(param, " = ", bound[i], ",")
								fmt.Println(param, " = ", bound[i])
							}
							comm_par_info += fixed_bound + ","
							fmt.Println(fixed_bound)

							fmt.Println("Number of states : ", ver.Num_states)
							fmt.Println("Time to verify model : ", ver.Spin_timing, " ms")
							fmt.Printf("Channel safety error : %s.\n", colorise(ver.Safety_error))
							fmt.Printf("Global deadlock : %s.\n", colorise(ver.Global_deadlock))
							if ver.Err != "" {
								red := color.New(color.FgRed).SprintFunc()
								fmt.Printf("Error : %s.\n", red(ver.Err))
							}
							fmt.Println("-------------------------------")

							toPrint := model_name + ",1," + fmt.Sprintf("%d", ver.Num_states) + "," + fmt.Sprintf("%d", ver.Spin_timing) + "," + fmt.Sprintf("%t", ver.Safety_error) + "," + fmt.Sprintf("%t", ver.Global_deadlock) + "," + ver.Err + "," + comm_par_info + ",\n"
							if _, err := f.WriteString(toPrint); err != nil {
								panic(err)
							}

							// add if there is no bug to false alarm bounds
							if !ver.Global_deadlock {
								false_alarm_bounds = append(false_alarm_bounds, opt_bound)
							}
						}
					}

				}

			} else {
				break
			}
		}
	}
}

func parseResults(result string, ver *VerificationRun) bool {

	if !strings.Contains(result, "assertion violated") {
		ver.Safety_error = false
	}
	if strings.Contains(result, "errors: 0") {
		ver.Global_deadlock = false
	}
	if strings.Contains(result, "too many processes") {
		ver.Err = "too many processes"
		ver.Global_deadlock = false
		ver.Safety_error = false
	}

	// Calculates the number of states

	splitted := strings.Split(result, "\n")

	if strings.Contains(splitted[0], "error") || strings.Contains(splitted[0], "Error") {
		fmt.Println("The model is not executable : ")

		for _, line := range splitted {
			fmt.Println(line)
		}
		ver.Err = splitted[0]
		return false
	}
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

	return true
}

func generateOptBounds(num_optionnals int) [][]interface{} {
	bounds_to_check := []interface{}{-2, 0, 1, 3}
	bounds := [][]interface{}{}
	for i := 0; i < num_optionnals; i++ {
		bounds = append(bounds, bounds_to_check)
	}
	d := cartesian.Iter(bounds...)

	optList := OptList{list: [][]interface{}{}}

	for bound := range d {
		optList.list = append(optList.list, bound)
	}

	sort.Sort(optList)
	return optList.list[1:]
}

// (*,2,3) superseeds (1,2,3)
func isSuperSeededBy(bound []interface{}, bounds [][]interface{}) bool {
	found := false
	for _, super_bounds := range bounds {
		superseeds := false
		for i, super_bound := range super_bounds {
			if bound[i] != super_bound {
				if fmt.Sprint(super_bound) == "-2" {
					superseeds = true
				} else {
					superseeds = false
					break
				}
			} else {
				superseeds = true
			}
		}
		if superseeds {
			found = true
			break
		}
	}

	return found
}
