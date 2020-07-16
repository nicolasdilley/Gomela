package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"strconv"
	"strings"
)

type Counter struct {
	Name      string
	Mandatory bool
}

func main() {

	if len(os.Args) > 1 {

		// pass bound.csv as first arg and features.csv as second arg
		data, _ := ioutil.ReadFile(os.Args[1])
		features := strings.Split(string(data[1:len(data)-1]), "\n")

		features_map := make(map[string][]string)

		for _, line := range features {
			splitted_line := strings.Split(line, ",")
			pack := splitted_line[0]
			model := splitted_line[1]
			features_map[pack+model] = append(features_map[pack+model], line)
		}

		parseBound(features_map)   // get all the lines from the csv
		parseFeature(features_map) // get all the lines from the csv

	} else {
		fmt.Println("Please provide the .csv file (log.csv)")
	}
}

func parseBound(features_map map[string][]string) {
	_, err := os.Create("./bounds.latex")
	if err != nil {
		panic(err)
	}

	model_unsupported := 0
	feature_unsupported := 0
	num_models := len(features_map)

	for _, lines := range features_map {

		unsupported := false

		for _, line := range lines { // go through each bound of a model
			splitted_line := strings.Split(line, ",")
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

func parseFeature(features_map map[string][]string) {
	_, err := os.Create("./features.latex")
	if err != nil {
		panic(err)
	}

	num_channels := 0
	num_waitgroups := 0
	actual_parameters := 0
	candidate_parameters := 0

	model_with_parameters := 0

	num_models := len(features_map)
	add_bounds := []float64{}
	chan_bounds := []float64{}
	for_bounds := []float64{}

	for _, lines := range features_map {

		contains_param := false
		for _, line := range lines {
			splitted_line := strings.Split(line, ",")
			// pack := splitted_line[0]
			// model := splitted_line[1]
			// fun := splitted_line[2]
			feature := splitted_line[3]
			// mandatory := splitted_line[4]
			info := splitted_line[5]

			if strings.Contains(feature, "new channel") {
				num_channels += 1
			}

			if strings.Contains(feature, "new WaitGroup") {
				num_waitgroups += 1
			}

			if strings.Contains(feature, "Candidate param") {
				contains_param = true
				candidate_parameters += 1
			}

			if strings.Contains(feature, "Comm param") {
				contains_param = true
				actual_parameters += 1
			}

			if strings.Contains(feature, "Integer as a ") {

				val, err := strconv.ParseInt(info, 10, 64)
				if err != nil {
				} else {

					if strings.Contains(feature, "add") {
						add_bounds = append(add_bounds, val)
					}

					if strings.Contains(feature, "chan") {
						chan_bounds = append(add_bounds, val)
					}

					if strings.Contains(feature, "for") {
						for_bounds = append(add_bounds, val)
					}

				}
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
	fmt.Println(candidate_parameters+actual_parameters, " params out of ", model_with_parameters, " models ")
	fmt.Println("# params per model : ", (candidate_parameters+actual_parameters)/model_with_parameters)
}
