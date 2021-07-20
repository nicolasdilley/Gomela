package main

import (
	"bytes"
	"fmt"
	"io/ioutil"
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
	Spin_timing                   int64  // time in milli to verify the program
	Close_safety_error            bool   // is there any safety errors
	Send_on_close_safety_error    bool   // is there any safety errors
	Negative_counter_safety_error bool   // is there any safety errors
	Double_unlock                 bool   // is there a double lock ?
	Global_deadlock               bool   // is there any global deadlock
	Num_states                    int    // the number of states in the model
	Timeout                       bool   // Has the verification timedout
	Err                           string // if there is another error
}

const (
	MAX_NUMBER_TESTS = 256
)

func VerifyModels(models []os.FileInfo, dir_name string, bounds_to_check []interface{}) {

	if len(bounds_to_check) == 0 {
		bounds_to_check = []interface{}{0, 1, 3}
	}
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

			path := RESULTS_FOLDER + "/" + model.Name()
			if dir_name != "" {
				path, _ = filepath.Abs(RESULTS_FOLDER + "/" + dir_name + "/" + model.Name())
			}
			content, err := ioutil.ReadFile(path)
			if err != nil {
				fmt.Println("Could not read content of : ", path, err)
			} else {
				var git_link string = ""
				file_content := string(content)
				lines := strings.Split(file_content, "\n")

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
					if strings.Contains(line, "-2") && strings.Contains(line, "#define") {
						optional_params += 1
					}

					if strings.Contains(line, "github.com") && git_link == "" {
						git_link = strings.Split(line, "// ")[1]
					}
				}

				model_name := strings.Replace(filepath.Base(dir_name), "&", "/", -1) + ":" + model.Name()
				fmt.Println("there is ", optional_params, " optionnal params.")

				if len(comm_params)+optional_params > 5 {

					toPrint := filepath.Base(dir_name) + ":" + model.Name() + ",too many comm params : mand : ," + strconv.Itoa(len(comm_params)) + ", opt :," + strconv.Itoa(optional_params) + "," + ",,,,,\n"
					if _, err := f.WriteString(toPrint); err != nil {
						panic(err)
					}
				} else {

					copy_path := strings.Replace(path, ".pml", "-copy.pml", 1)
					if len(comm_params) > 0 {

						d := cartesian.Iter(bounds...)

						for bound := range d {

							toPrint := file_content
							for _, b := range bound {
								toPrint = strings.Replace(toPrint, "??", fmt.Sprint(b), 1)
							}

							ioutil.WriteFile(copy_path, []byte(toPrint), 0644)

							lines = strings.Split(toPrint, "\n")
							bound_str := []string{}
							for _, b := range bound {
								bound_str = append(bound_str, fmt.Sprint(b))
							}
							ver, ok := verifyModel(copy_path, model_name, git_link, f, comm_params, optional_params, bound_str)
							if !ok {
								os.Remove(copy_path)
								break
							}
							if optional_params > 0 {
								verifyWithOptParams(ver, copy_path, model_name, lines, git_link, f, comm_params, bound_str, optional_params, bounds_to_check)
							} else {
								os.Remove(copy_path)
							}
						}
					} else {
						ioutil.WriteFile(copy_path, []byte(file_content), 0644)
						ver, ok := verifyModel(copy_path, model_name, git_link, f, []string{}, optional_params, []string{})
						if optional_params > 0 && ok {
							verifyWithOptParams(ver, copy_path, model_name, lines, git_link, f, []string{}, []string{}, optional_params, bounds_to_check)
						} else {
							os.Remove(copy_path)
						}
					}
				}
			}
		}
	}

}

func verifyModel(path string, model_name string, git_link string, f *os.File, comm_params []string, num_opt_params int, bound []string) (*VerificationRun, bool) {

	ver := &VerificationRun{Send_on_close_safety_error: false, Close_safety_error: false, Negative_counter_safety_error: false, Global_deadlock: true, Timeout: false}

	var output bytes.Buffer
	var err_output bytes.Buffer

	// Copy file and verify the copied file

	// Verify with SPIN
	fmt.Println("verifying : ", path)
	command := exec.Command("timeout", "30", "spin", "-run", "-DVECTORSZ=4508", "-m10000000", "-w26", path, "-f")
	command.Stdout = &output
	command.Stderr = &err_output
	pre := time.Now()
	err := command.Run()
	after := time.Now()

	ver.Spin_timing = after.Sub(pre).Milliseconds()
	executable := parseResults(output.String(), ver)

	if (output.String() == "" && err_output.String() == "" && err == nil) || ver.Timeout {
		fmt.Println("Ici ", path, " : out ", output.String(), " err : ", err_output.String())
		fmt.Println(command.Stderr)
		fmt.Println(executable)
		toPrint := model_name + ",0,timeout,timeout,timeout,timeout,timeout,timeout,,," + strconv.Itoa(len(comm_params)) + "," + strconv.Itoa(num_opt_params) + ",,,\n"
		if _, err := f.WriteString(toPrint); err != nil {
			panic(err)
		}
	} else if !executable || err_output.String() != "" || err != nil {
		fmt.Println(err_output.String())
		toPrint := model_name + ",0,the model is not executable,,,,,,,," + strconv.Itoa(len(comm_params)) + "," + strconv.Itoa(num_opt_params) + ",,," + ver.Err + " : " + err_output.String()

		if err != nil {
			toPrint += " : " + err.Error()
		}

		toPrint += ",,\n"

		if f != nil {
			if _, err := f.WriteString(toPrint); err != nil {
				panic(err)
			}
		}
		return ver, executable
	} else {
		comm_par_info := ""
		fmt.Println("-------------------------------")
		fmt.Println("Result for " + model_name)
		for i, param := range comm_params {
			comm_par_info += fmt.Sprint(param, " = ", bound[i], ",")
			fmt.Println(param, " = ", bound[i])
		}
		fmt.Println("Number of states : ", ver.Num_states)
		fmt.Println("Time to verify model : ", ver.Spin_timing, " ms")
		fmt.Printf("Send on close safety error : %s.\n", colorise(ver.Send_on_close_safety_error))
		fmt.Printf("Close safety error : %s.\n", colorise(ver.Close_safety_error))
		fmt.Printf("Negative counter safety error : %s.\n", colorise(ver.Negative_counter_safety_error))
		fmt.Printf("Double unlock error : %s.\n", colorise(ver.Double_unlock))
		fmt.Printf("Model deadlock : %s.\n", colorise(ver.Global_deadlock))
		if ver.Err != "" {
			red := color.New(color.FgRed).SprintFunc()
			fmt.Printf("Error : %s.\n", red(ver.Err))
		}
		fmt.Println("-------------------------------")

		toPrint := model_name + ",0," +
			fmt.Sprintf("%d", ver.Num_states) + "," +
			fmt.Sprintf("%d", ver.Spin_timing) + "," +
			fmt.Sprintf("%t", ver.Send_on_close_safety_error) + "," +
			fmt.Sprintf("%t", ver.Close_safety_error) + "," +
			fmt.Sprintf("%t", ver.Negative_counter_safety_error) + "," +
			fmt.Sprintf("%t", ver.Double_unlock) + "," +
			fmt.Sprintf("%t", ver.Global_deadlock) + "," +
			ver.Err + "," +
			fmt.Sprint(len(comm_params)) + "," +
			fmt.Sprint(num_opt_params) + "," +
			comm_par_info + "," +
			git_link + ",\n"
		if f != nil {
			if _, err := f.WriteString(toPrint); err != nil {
				panic(err)
			}
		}
	}

	return ver, executable
}

func verifyWithOptParams(ver *VerificationRun, path string, model_name string, lines []string, git_link string, f *os.File, comm_params []string, bound []string, num_optionnal int, bounds_to_check []interface{}) {
	if (ver.Global_deadlock) && !ver.Timeout && ver.Err == "" {
		// add values to the candidates param

		opt_bounds := generateOptBounds(num_optionnal, bounds_to_check)

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
								fixed_bound += strings.Trim(new_lines[i], "\t")
								break
							}

							if strings.Contains(line, "-2") && strings.Contains(line, "#define") {
								// we found an optional param
								new_lines[i] = strings.Replace(line, "-2", fmt.Sprint(b), 1)

								fixed_bound += strings.Trim(new_lines[i], " \t")

								break
							}
						}
					}

					toPrint := ""

					for _, l1 := range new_lines { // generate new content of file with updated value for opt param
						toPrint += l1 + "\n"
					}

					os.Remove(path)
					ioutil.WriteFile(path, []byte(toPrint), 0644) // rewrite new model with updated bounds

					ver := VerificationRun{
						Send_on_close_safety_error:    false,
						Close_safety_error:            false,
						Negative_counter_safety_error: false,
						Global_deadlock:               true,
						Timeout:                       false}
					var output bytes.Buffer
					var err_output bytes.Buffer

					// Verify with SPIN
					fmt.Println("verifying : ", path)
					command := exec.Command("timeout", "30", "spin", "-run", "-DVECTORSZ=4508", "-m10000000", "-w26", path, "-f")
					command.Stdout = &output
					command.Stderr = &err_output
					pre := time.Now()
					err := command.Run()
					after := time.Now()
					ver.Spin_timing = after.Sub(pre).Milliseconds()

					executable := parseResults(output.String(), &ver)
					num_tests++
					if (output.String() == "" && err_output.String() == "" && err == nil) || ver.Timeout {
						toPrint := model_name + ",0,timeout with opt param : " + fixed_bound + ",timeout,timeout,timeout,timeout,timeout,,," + strconv.Itoa(len(comm_params)) + "," + strconv.Itoa(num_optionnal) + ",,,\n"
						if _, err := f.WriteString(toPrint); err != nil {
							panic(err)
						}
					} else if !executable || err_output.String() != "" || err != nil {
						toPrint := model_name + ",1,the model is not executable,,,,,,,," + strconv.Itoa(len(comm_params)) + "," + strconv.Itoa(num_optionnal) + ",,," + ver.Err

						if err != nil {
							toPrint += "err :" + err.Error()
						}

						toPrint += ",,\n"
						if _, err := f.WriteString(toPrint); err != nil {
							panic(err)
						}
					} else {
						comm_par_info := ""
						fmt.Println("-------------------------------")
						fmt.Println("Result for " + model_name + " with optional params")
						for i, param := range comm_params {
							comm_par_info += fmt.Sprint(param, " = ", bound[i], ",")
							fmt.Println(param, " = ", bound[i])
						}
						comm_par_info += fixed_bound + ","

						fmt.Println("Number of states : ", ver.Num_states)
						fmt.Println("Time to verify model : ", ver.Spin_timing, " ms")
						fmt.Printf("Send on close safety error : %s.\n", colorise(ver.Send_on_close_safety_error))
						fmt.Printf("Close safety error : %s.\n", colorise(ver.Close_safety_error))
						fmt.Printf("Negative counter safety error : %s.\n", colorise(ver.Negative_counter_safety_error))
						fmt.Printf("Double unlock error : %s.\n", colorise(ver.Double_unlock))
						fmt.Printf("Model deadlock : %s.\n", colorise(ver.Global_deadlock))
						if ver.Err != "" {
							red := color.New(color.FgRed).SprintFunc()
							fmt.Printf("Error : %s.\n", red(ver.Err))
						}
						fmt.Println("-------------------------------")

						toPrint := model_name + ",1," +
							fmt.Sprintf("%d", ver.Num_states) + "," +
							fmt.Sprintf("%d", ver.Spin_timing) + "," +
							fmt.Sprintf("%t", ver.Send_on_close_safety_error) + "," +
							fmt.Sprintf("%t", ver.Close_safety_error) + "," +
							fmt.Sprintf("%t", ver.Negative_counter_safety_error) + "," +
							fmt.Sprintf("%t", ver.Double_unlock) + "," +
							fmt.Sprintf("%t", ver.Global_deadlock) + "," +
							ver.Err + "," +
							fmt.Sprint(len(comm_params)) + "," +
							fmt.Sprint(num_optionnal) + "," +
							comm_par_info + "," +
							git_link + ",\n"

						if _, err := f.WriteString(toPrint); err != nil {
							panic(err)
						}

						// add if there is no bug to false alarm bounds
						if !ver.Global_deadlock {
							false_alarm_bounds = append(false_alarm_bounds, opt_bound)
						}
					}

				}

			} else {
				break
			}
		}

		os.Remove(path)
	}
}

func verifyModelWithSpecificValues(model string, params []string) {
	lines := strings.Split(model, "\n")
	replaced := 0
	for _, param := range params {

		for i, line := range lines {
			if strings.Contains(line, "-2") && strings.Contains(line, "int") && strings.Contains(line, " = ") {
				lines[i] = strings.Replace(line, "-2", param, 1)
				replaced++
				break
			}

			if strings.Contains(line, "??") {
				lines[i] = strings.Replace(line, "??", param, 1)
				replaced++
				break
			}
		}
	}

	if replaced != len(params) {
		panic(fmt.Sprintf("The number of values for comm params %d does not match the number of comm param in the model %d", len(params), replaced))
	}

	toPrint := ""

	for _, line := range lines {
		toPrint += line + "\n"
	}

	// generate new model
	ioutil.WriteFile("./temp.pml", []byte(toPrint), 0664)
	// verify it
	verifyModel("./temp.pml", os.Args[2], "", nil, []string{}, 0, params)
	// delete it
	os.Remove("./temp.pml")

}

func parseResults(result string, ver *VerificationRun) bool {

	if strings.Contains(result, "assertion violated") {

		if strings.Contains(result, "wg.Counter>=0") {
			ver.Negative_counter_safety_error = true
		}

		if strings.Contains(result, "(1==0)") {
			ver.Send_on_close_safety_error = true
		}
		if strings.Contains(result, "(0==32)") {
			ver.Double_unlock = true
		}
		if strings.Contains(result, "(2==0)") {
			ver.Close_safety_error = true
		}
		ver.Global_deadlock = false
	} else {
		if strings.Contains(result, "errors: 0") {
			ver.Global_deadlock = false
		}
		if strings.Contains(result, "too many processes") {
			ver.Err = "too many processes"
			ver.Global_deadlock = false
			ver.Negative_counter_safety_error = false
			ver.Close_safety_error = false
			ver.Send_on_close_safety_error = false
			ver.Double_unlock = false
		}

		// Calculates the number of states

		splitted := strings.Split(result, "\n")

		if strings.Contains(splitted[0], "error") || strings.Contains(splitted[0], "Error") {
			err := ""
			if strings.Contains(splitted[0], "VECTORSZ too small") {
				err = "VECTORSZ too small"
			} else {
				err = splitted[0]
			}
			ver.Err = err
			return false
		}

		if strings.Contains(splitted[len(splitted)-1], "Depth=") {
			// Its a timeout
			ver.Timeout = true
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
	}

	return true
}

func generateOptBounds(num_optionnals int, bounds_to_check []interface{}) [][]interface{} {

	bounds_to_check = append([]interface{}{-2}, bounds_to_check...)
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
