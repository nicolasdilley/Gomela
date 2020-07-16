package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"strings"
)

func main() {

	if len(os.Args) > 2 {

		// pass bound.csv as first arg and features.csv as second arg
		bound_data, _ := ioutil.ReadFile(os.Args[1])
		feature_data, _ := ioutil.ReadFile(os.Args[2])
		bounds := strings.Split(string(bound_data), "\n")
		features := strings.Split(string(feature_data), "\n")

		all_lines := append(bounds[1:len(bounds)-1], features[1:len(features)-1]...)

		bound_map := make(map[string][]string)

		for _, line := range all_lines {
			splitted_line := strings.Split(line, ",")
			pack := splitted_line[0]
			model := splitted_line[1]
			bound_map[pack+model] = append(bound_map[pack+model], line)
		}

		parseBound(bound_map)   // get all the lines from the csv
		parseFeature(bound_map) // get all the lines from the csv

	} else {
		fmt.Println("Please provide the .csv files (bound + features)")
	}
}

func parseBound(bound_map map[string][]string) {
	_, err := os.Create("./bounds.latex")
	if err != nil {
		panic(err)
	}

	model_unsupported := 0
	feature_unsupported := 0
	num_models := len(bound_map)

	for _, lines := range bound_map {

		unsupported := false

		for _, line := range lines { // go through each bound of a model
			splitted_line := strings.Split(line, ",")
			// pack := splitted_line[0]
			// model := splitted_line[1]
			// feature := splitted_line[2]
			// mandatory := splitted_line[3]
			info := splitted_line[5]

			if strings.Contains(info, "Not supported") || strings.Contains(info, "UNSUPPORTED") {
				feature_unsupported += 1
				unsupported = true
			}
		}

		if unsupported {
			model_unsupported += 1
		}
	}

	fmt.Println("Num of unsupported features = ", feature_unsupported)
	fmt.Println("Num of unsupported model = ", model_unsupported, " out of ", num_models)
	// f.WriteString("\\begin{table}\n")
	// f.WriteString(" \\begin{tabular}{lccccccc}\n")
	// f.WriteStlsring("\\toprule\n   Bound & mean & std & min & 25\\% & 50\\% & 75\\% & max \\\\ \n \\midrule \n")

}

func parseFeature(bound_map map[string][]string) {
	_, err := os.Create("./features.latex")
	if err != nil {
		panic(err)
	}

	num_channels := 0
	num_waitgroups := 0
	actual_parameters := 0
	candidate_parameters := 0

	model_with_parameters := 0

	num_models := len(bound_map)

	for _, lines := range bound_map {
		contains_param := false
		for _, line := range lines {

			if strings.Contains(line, "new channel") {
				num_channels += 1
			}

			if strings.Contains(line, "new WaitGroup") {
				num_waitgroups += 1
			}

			if strings.Contains(line, "Candidate param") {
				contains_param = true
				candidate_parameters += 1
			}

			if strings.Contains(line, "Comm param") {
				contains_param = true
				actual_parameters += 1
			}

		}

		if contains_param {
			model_with_parameters += 1
		}

	}

	fmt.Println("Num of chans : ", num_channels)
	fmt.Println("Num of waitgroups : ", num_waitgroups)
	fmt.Println("Num of candidate parameters : ", candidate_parameters)
	fmt.Println("Num of actual parameters : ", actual_parameters)
	fmt.Println("Num of waitgroups : ", num_models)
	fmt.Println("model with params : ", model_with_parameters)
	fmt.Println("# params per model : ", candidate_parameters+actual_parameters, " params out of ", model_with_parameters, " models ")
	fmt.Println("# params per model : ", (candidate_parameters+actual_parameters)/model_with_parameters)
}
