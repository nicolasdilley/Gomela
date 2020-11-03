package main

import (
	"bytes"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"strconv"
	"strings"

	"github.com/fatih/color"
	cartesian "github.com/schwarmco/go-cartesian-product"
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
			path, _ := filepath.Abs(RESULTS_FOLDER + "/" + filepath.Base(dir_name) + "/" + model.Name())

			content, err := ioutil.ReadFile(path)

			if err != nil {
				fmt.Println("Could not read content of : ", path, err)
			} else {

				lines := strings.Split(string(content), "\n")

				bounds_to_check := []interface{}{0, 1, 3}
				bounds := [][]interface{}{}
				comm_params := []string{} // a map containing all the comm par
				for _, line := range lines {
					if strings.Contains(line, "??") {
						define := strings.Split(line, " ")
						comm_params = append(comm_params, define[1])
						bounds = append(bounds, bounds_to_check)
					}
				}

				if len(comm_params) == 0 {
					verifyModel(path, filepath.Base(dir_name)+":"+model.Name(), f, []string{}, []string{})
				} else if len(comm_params) > 5 {
					toPrint := filepath.Base(dir_name) + ":" + model.Name() + ",too many comm params : " + strconv.Itoa(len(comm_params)) + ",,,,,\n"
					if _, err := f.WriteString(toPrint); err != nil {
						panic(err)
					}
				} else {

					d := cartesian.Iter(bounds...)

					lines = lines[len(comm_params):]
					for bound := range d {
						defines := ""
						for i, param := range comm_params {
							defines += "#define " + param + " " + fmt.Sprint(bound[i]) + "\n"
						}

						toPrint := defines

						for _, line := range lines {
							toPrint += line + "\n"
						}
						err := os.Remove(path)
						if err != nil {
							log.Fatal(err)
						}
						ioutil.WriteFile(path, []byte(toPrint), 0644)

						bound_str := []string{}
						for _, b := range bound {
							bound_str = append(bound_str, fmt.Sprint(b))
						}
						verifyModel(path, filepath.Base(dir_name)+":"+model.Name(), f, comm_params, bound_str)
					}
				}
			}
		}
	}

}

func verifyModel(path string, model_name string, f *os.File, comm_params []string, bound []string) {

	ver := VerificationRun{Safety_error: true, Partial_deadlock: true, Global_deadlock: true}
	var output bytes.Buffer

	// Verify with SPIN
	command := exec.Command("timeout", "30", "spin", "-run", "-DVECTORSZ=4500", "-m10000000", "-w26", path, "-f")
	command.Stdout = &output
	command.Run()

	if output.String() == "" {
		toPrint := model_name + ",timeout,timeout,timeout,timeout,timeout,\n"
		if _, err := f.WriteString(toPrint); err != nil {
			panic(err)
		}
	} else {
		executable := parseResults(output.String(), &ver)
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

			toPrint := model_name + "," + fmt.Sprintf("%d", ver.Num_states) + "," + fmt.Sprintf("%d", ver.Spin_timing) + "," + fmt.Sprintf("%t", ver.Safety_error) + "," + fmt.Sprintf("%t", ver.Global_deadlock) + "," + ver.Err + "," + comm_par_info + ",\n"
			if _, err := f.WriteString(toPrint); err != nil {
				panic(err)
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
	}

	// Calculates the number of states

	splitted := strings.Split(result, "\n")

	if strings.Contains(splitted[0], "error") || strings.Contains(splitted[0], "Error") {
		fmt.Println("The model is not executable : ")
		fmt.Println(splitted[0])
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
