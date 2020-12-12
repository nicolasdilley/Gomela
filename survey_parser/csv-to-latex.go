package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"strconv"
	"strings"

	"github.com/montanaflynn/stats"
)

type Counter struct {
	Name      string
	Mandatory bool
}

func main() {

	if len(os.Args) > 1 {

		// pass bound.csv as first arg and features.csv as second arg

		if !strings.HasSuffix(os.Args[1], ".csv") {
			fmt.Println("please provide a .csv file")
			return
		}
		data, _ := ioutil.ReadFile(os.Args[1])
		features := strings.Split(string(data[1:len(data)-1]), "\n")

		features_map := make(map[string][]string)
		for _, line := range features {
			splitted_line := strings.Split(line, ",")

			if len(splitted_line) > 3 {
				features_map[splitted_line[1]] = append(features_map[splitted_line[1]], line)
			}
		}

		supported_models_map := parseBound(features_map) // get all the lines from the csv
		parseFeature(supported_models_map)               // get all the lines from the csv

		project_map := make(map[string][]string)
		packages_map := make(map[string][]string)

		for _, supported_models := range supported_models_map {
			for _, line := range supported_models {
				splitted_line := strings.Split(line, ",")
				project := splitted_line[0]
				packages := splitted_line[1]
				model := splitted_line[2]

				project_map[project] = append(project_map[project], model)
				packages_map[project+packages] = append(packages_map[project+packages], model)
			}
		}
		models_per_projects := []float64{}

		for _, models := range project_map {
			models_per_projects = append(models_per_projects, float64(len(models)))
		}

		models_per_packages := []float64{}

		for _, models := range packages_map {
			models_per_packages = append(models_per_packages, float64(len(models)))
		}

		models_sd, _ := stats.StandardDeviation(models_per_projects)
		models_mean, _ := stats.Mean(models_per_projects)
		models_quartiles, _ := stats.Quartile(models_per_projects)
		models_max, _ := stats.Max(models_per_projects)
		models_min, _ := stats.Min(models_per_projects)

		fmt.Println("# of models per project : ", models_mean, models_sd, models_min, models_quartiles.Q1, models_quartiles.Q2, models_quartiles.Q3, models_max)

		packages_models_sd, _ := stats.StandardDeviation(models_per_packages)
		packages_models_mean, _ := stats.Mean(models_per_packages)
		packages_models_quartiles, _ := stats.Quartile(models_per_packages)
		packages_models_max, _ := stats.Max(models_per_packages)
		packages_models_min, _ := stats.Min(models_per_packages)
		fmt.Println("# of models per packages : ", packages_models_mean, packages_models_sd, packages_models_min, packages_models_quartiles.Q1, packages_models_quartiles.Q2, packages_models_quartiles.Q3, packages_models_max)
	} else {
		fmt.Println("Please provide the .csv file (log.csv)")
	}

}

func parseBound(features_map map[string][]string) map[string][]string {
	_, err := os.Create("./bounds.latex")
	if err != nil {
		panic(err)
	}

	model_unsupported := 0
	feature_unsupported := 0
	model_errors := 0
	num_models := len(features_map)
	unsupported_models := []string{}

	for model, lines := range features_map {

		unsupported := false
		for _, line := range lines { // go through each bound of a model
			splitted_line := strings.Split(line, ",")

			info := splitted_line[5]
			if strings.Contains(info, "Not supported") || strings.Contains(info, "UNSUPPORTED") {
				feature_unsupported += 1
			} else if strings.Contains(splitted_line[3], "MODEL ERROR") {
				model_errors += 1
				unsupported = true
				break
			}

		}

		if unsupported {
			fmt.Println("et la:)")
			model_unsupported += 1
			unsupported_models = append(unsupported_models, model)
		}
	}

	for _, model := range unsupported_models {
		delete(features_map, model)
	}

	fmt.Println("Num of unsupported features = ", feature_unsupported)
	fmt.Println("Num of model errors = ", model_errors)
	fmt.Println("Num of unsupported model = ", model_unsupported, " out of ", num_models)
	// f.WriteString("\\begin{table}\n")
	// f.WriteString(" \\begin{tabular}{lccccccc}\n")
	// f.WriteStlsring("\\toprule\n   Bound & mean & std & min & 25\\% & 50\\% & 75\\% & max \\\\ \n \\midrule \n")
	return features_map
}

func parseFeature(features_map map[string][]string) {
	_, err := os.Create("./features.latex")
	if err != nil {
		panic(err)
	}

	num_channels := 0
	num_waitgroups := 0
	mand_actual_parameters := 0
	opt_actual_parameters := 0
	mand_candidate_parameters := 0
	opt_candidate_parameters := 0

	mand_comm_parameters := 0
	opt_comm_parameters := 0

	mand_struct_parameters := 0
	opt_struct_parameters := 0

	mand_func_parameters := 0
	opt_func_parameters := 0

	mand_len_parameters := 0
	opt_len_parameters := 0

	mand_integer_parameters := 0
	opt_integer_parameters := 0

	mand_var_parameters := 0
	opt_var_parameters := 0

	mand_list_parameters := 0
	opt_list_parameters := 0

	mand_map_parameters := 0
	opt_map_parameters := 0

	mand_list_item_parameters := 0
	opt_list_item_parameters := 0

	mand_ptr_parameters := 0
	opt_ptr_parameters := 0

	model_with_parameters := 0

	num_models := len(features_map)
	add_bounds := []float64{}
	chan_bounds := []float64{}
	for_bounds := []float64{}
	spawning_for_bounds := []float64{}

	for _, lines := range features_map {

		contains_param := false
		for _, line := range lines {
			splitted_line := strings.Split(line, ",")
			// pack := splitted_line[0]
			// model := splitted_line[1]
			// fun := splitted_line[2]
			feature := splitted_line[3]
			mandatory := splitted_line[4]
			info := splitted_line[5]

			if strings.Contains(feature, "new channel") {
				num_channels += 1
			}

			if strings.Contains(feature, "new WaitGroup") {
				num_waitgroups += 1
			}

			if strings.Contains(feature, "Candidate Param") {
				if mandatory == "false" {
					opt_candidate_parameters += 1
				} else {
					mand_candidate_parameters += 1
				}
			}

			if strings.Contains(feature, "Actual Param") {
				contains_param = true

				if mandatory == "false" {
					opt_actual_parameters += 1
				} else {
					mand_actual_parameters += 1
				}

			}
			if strings.Contains(feature, "Comm Param") {

				if mandatory == "false" {
					opt_comm_parameters += 1
				} else {
					mand_comm_parameters += 1

				}

			}
			if strings.Contains(feature, "Elem of a struct as a") || strings.Contains(feature, "Struct as a") {
				if mandatory == "false" {
					opt_struct_parameters += 1
				} else {
					mand_struct_parameters += 1
				}
			}
			if strings.Contains(feature, "Var as a ") {

				if mandatory == "false" {
					opt_var_parameters += 1
				} else {
					mand_var_parameters += 1
				}
			}

			if strings.Contains(feature, "Slice as a ") {

				if mandatory == "false" {
					opt_list_parameters += 1
				} else {
					mand_list_parameters += 1
				}
			}

			if strings.Contains(feature, "Map as a ") {

				if mandatory == "false" {
					opt_map_parameters += 1
				} else {
					mand_map_parameters += 1
				}
			}
			if strings.Contains(feature, "Uses an item of a list as a") {

				if mandatory == "false" {
					opt_list_item_parameters += 1
				} else {
					mand_list_item_parameters += 1
				}
			}
			if strings.Contains(feature, "len() as a ") {

				if mandatory == "false" {
					opt_len_parameters += 1
				} else {
					mand_len_parameters += 1
				}
			}
			if strings.Contains(feature, "Func as a ") {

				if mandatory == "false" {
					opt_func_parameters += 1
				} else {
					mand_func_parameters += 1
				}
			}
			if strings.Contains(feature, "Pointer as a ") {

				if mandatory == "false" {
					opt_ptr_parameters += 1
				} else {
					mand_ptr_parameters += 1
				}
			}

			if strings.Contains(feature, "Integer as a ") {
				if mandatory == "false" {
					opt_integer_parameters += 1
				} else {
					mand_integer_parameters += 1
				}
				val, err := strconv.ParseInt(info, 10, 64)
				if err != nil {
				} else {

					if strings.Contains(feature, "add") {
						add_bounds = append(add_bounds, float64(val))
					}

					if strings.Contains(feature, "chan") {
						chan_bounds = append(chan_bounds, float64(val))
					}

					if strings.Contains(feature, "spawning for upper") {
						spawning_for_bounds = append(spawning_for_bounds, float64(val))
					} else if strings.Contains(feature, "for upper") {
						for_bounds = append(for_bounds, float64(val))
					}
				}
			}

		}

		if contains_param {
			model_with_parameters += 1
		}

	}

	fmt.Println("NAME , MEAN, SD , Q1, MEDIAN , Q3, MAX")
	add_sd, _ := stats.StandardDeviation(add_bounds)
	add_mean, _ := stats.Mean(add_bounds)
	add_quartiles, _ := stats.Quartile(add_bounds)
	add_max, _ := stats.Max(add_bounds)
	add_min, _ := stats.Min(add_bounds)

	fmt.Println("Add(x)", add_mean, add_sd, add_min, add_quartiles.Q1, add_quartiles.Q2, add_quartiles.Q3, add_max)

	chan_sd, _ := stats.StandardDeviation(chan_bounds)
	chan_mean, _ := stats.Mean(chan_bounds)
	chan_quartiles, _ := stats.Quartile(chan_bounds)
	chan_max, _ := stats.Max(chan_bounds)
	chan_min, _ := stats.Min(chan_bounds)

	fmt.Println("Chan", chan_mean, chan_sd, chan_min, chan_quartiles.Q1, chan_quartiles.Q2, chan_quartiles.Q3, chan_max)

	for_sd, _ := stats.StandardDeviation(for_bounds)
	for_mean, _ := stats.Mean(for_bounds)
	for_quartiles, _ := stats.Quartile(for_bounds)
	for_max, _ := stats.Max(for_bounds)
	for_min, _ := stats.Min(for_bounds)

	fmt.Println("For upper", for_mean, for_sd, for_min, for_quartiles.Q1, for_quartiles.Q2, for_quartiles.Q3, for_max)

	// add unsupported everywhere
	// check occurences that are constants
	// check type int and Var (And add when litteral)
	// add test cases
	// When Map and List make sure its for range (and if not look at what it is )
	// Find a way to count only the comm param that remains in the model.
	// look for upper bound of for loop where spawming and not spawning.
	//
	fmt.Println("Num of chans : ", num_channels)
	fmt.Println("Num of waitgroups : ", num_waitgroups)
	fmt.Println("Num of candidate parameters : mand : ", mand_candidate_parameters, " opt : ", opt_candidate_parameters, " Total : ", opt_candidate_parameters+mand_candidate_parameters)
	fmt.Println("Num of actual parameters : mand : ", mand_actual_parameters, " opt : ", opt_actual_parameters, " Total : ", opt_actual_parameters+mand_actual_parameters)
	fmt.Println("Occurences of comm parameters : mand : ", mand_comm_parameters, " opt : ", opt_comm_parameters, " Total : ", opt_comm_parameters+mand_comm_parameters)
	fmt.Println("Integer : mand : ", mand_integer_parameters, " opt : ", opt_integer_parameters, " Total : ", opt_integer_parameters+mand_integer_parameters)
	fmt.Println("Func : mand : ", mand_func_parameters, " opt : ", opt_func_parameters, " Total : ", opt_func_parameters+mand_func_parameters)
	fmt.Println("which are len() : mand : ", mand_len_parameters, " opt : ", opt_len_parameters, " Total : ", opt_len_parameters+mand_len_parameters)
	fmt.Println("Map : mand : ", mand_map_parameters, " opt : ", opt_map_parameters, " Total : ", opt_map_parameters+mand_map_parameters)
	fmt.Println("List : mand : ", mand_list_parameters, " opt : ", opt_list_parameters, " Total : ", opt_list_parameters+mand_list_parameters)
	fmt.Println("Item of a list : mand : ", mand_list_item_parameters, " opt : ", opt_list_item_parameters, " Total : ", opt_list_item_parameters+mand_list_item_parameters)
	fmt.Println("Pointer : mand : ", mand_ptr_parameters, " opt : ", opt_ptr_parameters, " Total : ", opt_ptr_parameters+mand_ptr_parameters)
	fmt.Println("Var : mand : ", mand_var_parameters, " opt : ", opt_var_parameters, " Total : ", opt_var_parameters+mand_var_parameters)
	fmt.Println("Struct : mand : ", mand_struct_parameters, " opt : ", opt_struct_parameters, " Total : ", opt_struct_parameters+mand_struct_parameters)
	fmt.Println("Num of models : ", num_models)
	fmt.Println("model with params : ", model_with_parameters)
	fmt.Println((mand_candidate_parameters + opt_candidate_parameters + mand_actual_parameters + opt_actual_parameters), " params out of ", model_with_parameters, " models ")
	fmt.Println("# params per model (that contains at least one parameter) : ", (mand_candidate_parameters+opt_candidate_parameters+mand_actual_parameters+opt_actual_parameters)/model_with_parameters)
}
