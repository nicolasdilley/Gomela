package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"sort"
	"strconv"
	"strings"

	"github.com/montanaflynn/stats"
	"github.com/nicolasdilley/gomela/promela"
)

type Counter struct {
	Name      string
	Mandatory bool
}
type Project struct {
	Name     string
	Packages []Package
}

type Package struct {
	Name   string
	Models []string
}

type ProjectList struct {
	Projects []Project
}

const (
	NUM_TOP_PROJECTS   = 5
	AUTHOR_PROJECT_SEP = "--"
)

func main() {

	if len(os.Args) > 1 {

		// pass bound.csv as first arg and features.csv as second arg

		if !strings.HasSuffix(os.Args[1], ".csv") {
			fmt.Println("please provide a .csv file")
			return
		}
		data, _ := ioutil.ReadFile(os.Args[1])
		features := strings.Split(string(data[:len(data)-1]), "\n")

		features_map := make(map[string][]string)
		others_map := make(map[string]bool)
		for _, line := range features[1:] {
			splitted_line := strings.Split(line, ",")

			if len(splitted_line) > 3 {
				features_map[splitted_line[0]+splitted_line[1]] = append(features_map[splitted_line[0]+splitted_line[1]], line)
				others_map[splitted_line[0]] = true
			} else {
				others_map[splitted_line[0]] = false
			}
		}
		printProjectList(features[1:])
		unparsedProjects(others_map)
		supported_models_map := parseBound(features_map) // get all the lines from the csv
		parseFeature(supported_models_map)               // get all the lines from the csv
		project_map := ProjectList{Projects: []Project{}}

		for model, supported_models := range supported_models_map {
			for _, line := range supported_models {
				splitted_line := strings.Split(line, ",")
				project := splitted_line[0]
				splitted := strings.Split(splitted_line[1], AUTHOR_PROJECT_SEP)

				packages := splitted[0]
				if len(splitted) > 2 {
					fmt.Println("have a model with two $")

					for i, pack := range splitted[:len(splitted)-1] {
						if pack != "" && i != 0 {
							packages += AUTHOR_PROJECT_SEP
						}
						packages += pack

					}
				}
				project_map.addPackage(project, packages, model)
			}
		}

		models_per_projects := []float64{}
		models_per_packages := []float64{}

		sort.Slice(project_map.Projects, func(i, j int) bool {
			num_models_i := 0

			for _, pack := range project_map.Projects[i].Packages {
				num_models_i += len(pack.Models)
			}
			num_models_j := 0

			for _, pack := range project_map.Projects[j].Packages {
				num_models_j += len(pack.Models)
			}
			return num_models_i < num_models_j

		})

		for i, j := 0, len(project_map.Projects)-1; i < j; i, j = i+1, j-1 {
			project_map.Projects[i], project_map.Projects[j] = project_map.Projects[j], project_map.Projects[i]
		}

		overall_num_models := 0
		for _, project := range project_map.Projects {
			num_models := 0

			for _, pack := range project.Packages {
				num_models += len(pack.Models)
				models_per_packages = append(models_per_packages, float64(len(pack.Models)))
			}
			overall_num_models += num_models
			models_per_projects = append(models_per_projects, float64(num_models))
		}

		models_sd, _ := stats.StandardDeviation(models_per_projects)
		models_mean, _ := stats.Mean(models_per_projects)
		models_quartiles, _ := stats.Quartile(models_per_projects)
		models_max, _ := stats.Max(models_per_projects)
		models_min, _ := stats.Min(models_per_projects)
		fmt.Println("num of models: ", overall_num_models)
		fmt.Println("# of models per project : ", models_mean, models_sd, models_min, models_quartiles.Q1, models_quartiles.Q2, models_quartiles.Q3, models_max)

		packages_models_sd, _ := stats.StandardDeviation(models_per_packages)
		packages_models_mean, _ := stats.Mean(models_per_packages)
		packages_models_quartiles, _ := stats.Quartile(models_per_packages)
		packages_models_max, _ := stats.Max(models_per_packages)
		packages_models_min, _ := stats.Min(models_per_packages)
		fmt.Println("# of models per packages : ", packages_models_mean, packages_models_sd, packages_models_min, packages_models_quartiles.Q1, packages_models_quartiles.Q2, packages_models_quartiles.Q3, packages_models_max)

		fmt.Println("Top 5 projects :")

		for i := 0; i < NUM_TOP_PROJECTS; i++ {
			num_models := numOfModels(project_map.Projects[i])
			fmt.Println(i+1, ": ", project_map.Projects[i].Name, "# of models = ", num_models, "# of packages = ", len(project_map.Projects[i].Packages), "# of models per packages = ", float64(num_models)/float64(len(project_map.Projects[i].Packages)))
		}
	} else {
		fmt.Println("Please provide the .csv file (log.csv)")
	}
	parseVerificationResults()

}

func printProjectList(lines []string) {

	project_map := make(map[string]string) // a map of the projects and their commit
	for _, line := range lines {

		splitted_line := strings.Split(line, ",")
		if _, ok := project_map[splitted_line[0]]; !ok && len(splitted_line) > 7 {
			commit := splitted_line[len(splitted_line)-1]
			project_map[splitted_line[0]] = commit
		}
	}

	ioutil.WriteFile("projects-commit.csv", []byte(""), 0644)

	file, err := os.OpenFile("projects-commit.csv", os.O_APPEND|os.O_WRONLY, 0644)
	if err != nil {
		log.Println(err)
	}
	defer file.Close()
	for project, commit := range project_map {
		file.WriteString(project + "," + commit + "\n")
	}
}

func parseBound(features_map map[string][]string) map[string][]string {
	model_unsupported := 0
	feature_unsupported := 0
	model_errors := 0
	num_models := len(features_map)

	unsupported_models := []string{}

	channel_returned := 0
	wg_returned := 0
	rcv_chan := 0
	find_decl := 0
	range_on_chan := 0
	func_as_var := 0
	chan_in_for := 0
	wg_in_for := 0
	send_chan := 0
	defer_in_blockstmt := 0
	notify := 0
	select_no_branch := 0
	unknown_arg := 0
	unparsable_function_name := 0
	unparsable_arg := 0

	for model, lines := range features_map {

		unsupported := false
		for _, line := range lines { // go through each feature of a model
			splitted_line := strings.Split(line, ",")
			if strings.Contains(splitted_line[3], "MODEL ERROR") {
				model_errors += 1

				if strings.Contains(splitted_line[3], promela.RETURN_CHAN) {
					channel_returned++
				} else if strings.Contains(splitted_line[3], promela.RETURN_WG) {
					wg_returned++
				} else if strings.Contains(splitted_line[3], promela.UNKNOWN_RCV) {
					rcv_chan++
				} else if strings.Contains(splitted_line[3], promela.UNKNOWN_DECL) {
					find_decl++
				} else if strings.Contains(splitted_line[3], promela.UNKNOWN_RANGE) {
					range_on_chan++
				} else if strings.Contains(splitted_line[3], promela.UNKNOWN_ARG) {
					unknown_arg++
				} else if strings.Contains(splitted_line[3], promela.UNPARSABLE_FUNCTION_NAME) {
					unparsable_function_name++
				} else if strings.Contains(splitted_line[3], promela.UNPARSABLE_ARG) {
					unparsable_arg++
				} else if strings.Contains(splitted_line[3], promela.FUNC_DECLARED_AS_VAR) {
					func_as_var++
				} else if strings.Contains(splitted_line[3], promela.CHAN_IN_FOR) {
					chan_in_for++
				} else if strings.Contains(splitted_line[3], promela.UNKNOWN_SEND) {
					send_chan++
				} else if strings.Contains(splitted_line[3], promela.WAITGROUP_IN_FOR) {
					wg_in_for++
				} else if strings.Contains(splitted_line[3], "Defer stmt") {
					defer_in_blockstmt++
				} else if strings.Contains(splitted_line[3], promela.UNKNOWN_GO_FUNC) {
					find_decl++
				} else if strings.Contains(splitted_line[3], promela.UNKNOWN_NOTIFY) {
					notify++
				} else if strings.Contains(splitted_line[3], promela.SELECT_WITH_NO_BRANCH) {
					select_no_branch++
				} else {
					fmt.Println(splitted_line[3])
				}

				unsupported = true
				break
			} else if strings.Contains(splitted_line[5], "Not supported") || strings.Contains(splitted_line[5], "UNSUPPORTED") {
				feature_unsupported += 1
			}

		}
		if unsupported {
			model_unsupported += 1
			unsupported_models = append(unsupported_models, model)
		}
	}

	for _, model := range unsupported_models {
		delete(features_map, model)
	}

	fmt.Println("# of models returning a channel : ", channel_returned)
	fmt.Println("# of models returning a Waitgroup : ", wg_returned)
	fmt.Println("# of models receive on unknown chan : ", rcv_chan)
	fmt.Println("# of models send on unknown chan : ", send_chan)
	fmt.Println("# of models cannot find decl : ", find_decl)
	fmt.Println("# of models function declared as var : ", func_as_var)
	fmt.Println("# of models channel in for : ", chan_in_for)
	fmt.Println("# of models range on unknown chan : ", range_on_chan)
	fmt.Println("# of models cant find notify : ", notify)
	fmt.Println("# of models select without branch : ", select_no_branch)
	fmt.Println("# of models defer stmts inside if, select or switch : ", defer_in_blockstmt)

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
	num_done_in_for := 0

	chan_bound := 0
	add_bound := 0
	for_bound := 0

	num_models := len(features_map)

	add_bounds := []float64{}
	chan_bounds := []float64{}
	for_bounds := []float64{}
	spawning_for_bounds := []float64{}

	comm_param_per_models := []float64{}

	for model, lines := range features_map {

		contains_param := false
		num_comm_par := 0

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

			if strings.Contains(feature, "chan bound") && !strings.Contains(feature, "len") {
				chan_bound += 1
			}

			if strings.Contains(feature, "add bound") && !strings.Contains(feature, "len") {
				add_bound += 1
			}

			if strings.Contains(feature, "range bound") && !strings.Contains(feature, "len") {
				for_bound += 1
			}

			if strings.Contains(feature, "for upper bound") && !strings.Contains(feature, "len") {
				for_bound += 1
			}

			if strings.Contains(feature, "for lower bound") && !strings.Contains(feature, "len") {
				for_bound += 1
			}

			if strings.Contains(feature, "new WaitGroup") {
				num_waitgroups += 1
			}

			if strings.Contains(feature, "Candidate Param") {
				num_comm_par++
				contains_param = true
				if mandatory == "false" {
					opt_candidate_parameters += 1
				} else {
					mand_candidate_parameters += 1
				}
			}

			if strings.Contains(feature, "Actual Param") {
				num_comm_par++

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

			if strings.Contains(feature, "List as a") {
				if mandatory == "false" {
					opt_list_parameters += 1
				} else {
					mand_list_parameters += 1
				}
			}

			if strings.Contains(feature, "Map as a ") {
				if !strings.Contains(feature, "range") {
					fmt.Println("not a range map : ", feature)
				}
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

			if strings.Contains(feature, "Done in for") {
				num_done_in_for += 1
			}

		}

		if contains_param {

			if num_comm_par > 10 {
				fmt.Println(model, " ", num_comm_par)
			}
			model_with_parameters += 1
			comm_param_per_models = append(comm_param_per_models, float64(num_comm_par))
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

	comm_param_per_models_sd, _ := stats.StandardDeviation(comm_param_per_models)
	comm_param_per_models_mean, _ := stats.Mean(comm_param_per_models)
	comm_param_per_models_quartiles, _ := stats.Quartile(comm_param_per_models)
	comm_param_per_models_max, _ := stats.Max(comm_param_per_models)
	comm_param_per_models_min, _ := stats.Min(comm_param_per_models)

	fmt.Println("Comm param per models ", comm_param_per_models_mean, comm_param_per_models_sd, comm_param_per_models_min, comm_param_per_models_quartiles.Q1, comm_param_per_models_quartiles.Q2, comm_param_per_models_quartiles.Q3, comm_param_per_models_max)

	fmt.Println("Num of chan bounds: ", chan_bound)
	fmt.Println("Num of add bounds: ", add_bound)
	fmt.Println("Num of for bounds: ", for_bound)
	// add unsupported everywhere
	// check occurences that are constaxnts
	// check type int and Var (And add when litteral)
	// add test cases
	// When Map and List make sure its for range (and if not look at what it is )
	// Find a way to count only the comm param that remains in the model.
	// look for upper bound of for loop where spawming and not spawning.

	// Average number of opt and mand parameters ####
	// count GD per model also
	// count CS per model also

	// look at the model taht contain at least one GD or CS
	// assign a score for each model based on the number of model that have a global deadlock
	// Look at the one which are close to 0.5 first.
	// look at the model that contain only error

	fmt.Println("Num of chans : ", num_channels)
	fmt.Println("Num of waitgroups : ", num_waitgroups)
	fmt.Println("Num of models : ", num_models)
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
	fmt.Println("Num of Done() in for : ", num_done_in_for)
	fmt.Println("Num of models : ", num_models)
	fmt.Println("model with params : ", model_with_parameters)
	fmt.Println(float64((mand_candidate_parameters+opt_candidate_parameters+mand_actual_parameters+opt_actual_parameters))/float64(model_with_parameters), " params out of ", model_with_parameters, " models with at least one comm param")
	fmt.Println((float64(mand_candidate_parameters+mand_actual_parameters))/float64(model_with_parameters), " mand params out of ", model_with_parameters, " models with at least one comm param")
	fmt.Println(float64((opt_candidate_parameters+opt_actual_parameters))/float64(model_with_parameters), " opt params out of ", model_with_parameters, " models with at least one comm param")
	fmt.Println("# params per model (that contains at least one parameter) : ", float64((mand_candidate_parameters+opt_candidate_parameters+mand_actual_parameters+opt_actual_parameters))/float64(model_with_parameters))
}

func parseVerificationResults() {
	if len(os.Args) > 3 {
		if !strings.HasSuffix(os.Args[3], ".csv") {
			fmt.Println("please provide a .csv file for the list of verification.csv")
			return
		}
		data, _ := ioutil.ReadFile(os.Args[3])
		verification := strings.Split(string(data[:len(data)-1]), "\n")

		verification_map := make(map[string][]string)

		num_tests := len(verification) - 1
		num_gd := 0
		num_cs := 0
		false_alarms := 0
		total_time := 0
		for _, line := range verification {
			splitted_line := strings.Split(line, ",")
			verification_map[splitted_line[0]] = append(verification_map[splitted_line[0]], line)
			// model := splitted_line[0]
			opt := splitted_line[1] == "1"
			// num_states := splitted_line[2]

			time, err := strconv.Atoi(splitted_line[3])
			cs_error := splitted_line[4] == "true"
			gd_error := splitted_line[5] == "true"
			if err == nil {
				total_time += time
			}
			if cs_error {
				num_cs++
			} else if gd_error {
				num_gd++
			} else {
				if opt {
					false_alarms++
				}
			}
		}

		scores := make(map[string][]float64)
		num_models_with_score_that_are_not_one_not_zero := 0
		for model, verifications := range verification_map {
			gd_score := 0
			cs_score := 0

			for _, v := range verifications {
				splitted_line := strings.Split(v, ",")
				cs_error := splitted_line[4] == "true"
				gd_error := splitted_line[5] == "true"
				if cs_error {
					cs_score++
				} else if gd_error {
					gd_score++
				}
			}

			if float64(cs_score)/float64(len(verifications)) != 0.0 && float64(cs_score)/float64(len(verifications)) != 1.0 {
				num_models_with_score_that_are_not_one_not_zero++
			} else if float64(gd_score)/float64(len(verifications)) != 0.0 && float64(gd_score)/float64(len(verifications)) != 1.0 {
				num_models_with_score_that_are_not_one_not_zero++
			}
			scores[model] = append(scores[model], []float64{float64(cs_score) / float64(len(verifications)), float64(gd_score) / float64(len(verifications))}...)
		}

		ioutil.WriteFile("scores.csv", []byte("Project, Channel safety score, Global deadlock score, \n"), 0644)
		file, err := os.OpenFile("scores.csv", os.O_APPEND|os.O_WRONLY, 0644)
		if err != nil {
			log.Println(err)
		}
		defer file.Close()

		gb_scores_frequency := make(map[string]int)
		cs_scores_frequency := make(map[string]int)

		for model, scores := range scores {
			toPrint := fmt.Sprint(model + ",")
			if scores[0] == 0.0 {
				cs_scores_frequency["0"]++
			} else if scores[0] < 0.2 {
				cs_scores_frequency["0 - 0.2"]++
			} else if scores[0] < 0.4 {
				cs_scores_frequency["0.2 - 0.4"]++
			} else if scores[0] < 0.6 {
				cs_scores_frequency["0.4 - 0.6"]++
			} else if scores[0] < 0.8 {
				cs_scores_frequency["0.6 - 0.8"]++
			} else if scores[0] < 1.0 {
				cs_scores_frequency["0.8 - 1"]++
			} else {
				cs_scores_frequency["1"]++
			}

			if scores[1] == 0.0 {
				gb_scores_frequency["0"]++
			} else if scores[1] == 1.0 {
				gb_scores_frequency["1"]++
			} else if scores[1] < 0.2 {
				gb_scores_frequency["0 - 0.2"]++
			} else if scores[1] < 0.4 {
				gb_scores_frequency["0.2 - 0.4"]++
			} else if scores[1] < 0.6 {
				gb_scores_frequency["0.4 - 0.6"]++
			} else if scores[1] < 0.8 {
				gb_scores_frequency["0.6 - 0.8"]++
			} else {
				gb_scores_frequency["0.8 - 1"]++
			}

			for _, score := range scores {
				toPrint += fmt.Sprint(score) + ","
			}
			//Append second line

			if _, err := file.WriteString(toPrint + "\n"); err != nil {
				log.Fatal(err)
			}
		}

		ioutil.WriteFile("se_frequence_scores.csv", []byte("Safety Error Score, Frequency \n"), 0644)
		se_file, err := os.OpenFile("se_frequence_scores.csv", os.O_APPEND|os.O_WRONLY, 0644)
		if err != nil {
			log.Println(err)
		}

		// Print frequency score
		// Print cs score
		for score, frequency := range cs_scores_frequency {
			if _, err := se_file.WriteString(score + "," + fmt.Sprint(frequency) + "\n"); err != nil {
				log.Fatal(err)
			}
		}

		ioutil.WriteFile("gb_frequence_scores.csv", []byte("Global Deadlock Score, Frequency \n"), 0644)
		gb_file, err := os.OpenFile("gb_frequence_scores.csv", os.O_APPEND|os.O_WRONLY, 0644)
		if err != nil {
			log.Println(err)
		}

		// Print frequency score
		// PRint gb score
		for score, frequency := range gb_scores_frequency {

			if _, err := gb_file.WriteString(score + "," + fmt.Sprint(frequency) + "\n"); err != nil {
				log.Fatal(err)
			}
		}

		fmt.Println("# of models with score > 0 and < 1 : ", num_models_with_score_that_are_not_one_not_zero)
		fmt.Println("# of verification : ", num_tests)
		fmt.Println("# of global deadlock : ", num_gd)
		fmt.Println("# of channel error : ", num_cs)
		fmt.Println("# of false alarms : ", false_alarms)
		fmt.Println("# of average verification time : ", total_time/num_tests)
		fmt.Println("Total verification time: ", total_time)

	}
}

func (p *ProjectList) addPackage(project_name, package_name string, model_name string) {
	found := false
	index := 0
	for i, project := range p.Projects {
		if project.Name == project_name {
			found = true
			index = i
			break
		}
	}
	if !found {
		p.Projects = append(p.Projects, Project{Name: project_name, Packages: []Package{}})
		index = len(p.Projects) - 1
	}

	package_found := false
	package_index := 0

	for i, packages := range p.Projects[index].Packages {
		if packages.Name == package_name {
			package_found = true
			package_index = i
			break
		}

	}

	if !package_found {
		p.Projects[index].Packages = append(p.Projects[index].Packages, Package{Name: package_name, Models: []string{}})
		package_index = len(p.Projects[index].Packages) - 1
	}

	model_found := false

	for _, model := range p.Projects[index].Packages[package_index].Models {
		if model == model_name {
			model_found = true
			break
		}
	}

	if !model_found {
		p.Projects[index].Packages[package_index].Models = append(p.Projects[index].Packages[package_index].Models, model_name)
	}

}

func unparsedProjects(models map[string]bool) {

	if len(os.Args) > 2 {
		// The projects.txt list has been given
		if !strings.HasSuffix(os.Args[2], ".txt") {
			fmt.Println("please provide a .txt file for the list of projects")
			return
		}
		data, _ := ioutil.ReadFile(os.Args[2])
		projects := strings.Split(string(data[:len(data)-1]), "\n")
		unparsed_project := []string{}

		toPrint := ""
		// return which projects where not parsed
		for _, project := range projects {
			if _, ok := models[project]; !ok {
				unparsed_project = append(unparsed_project, project)
				toPrint += project + "\n"
			}
		}

		ioutil.WriteFile("projects-left.txt", []byte(toPrint), 0644)
		fmt.Println("Num of projects without models : ", len(unparsed_project))
	}
	could_not_parse := 0
	for _, parsed := range models {
		if !parsed {
			could_not_parse++
		}
	}

	fmt.Println("Num of unparsable projects : ", could_not_parse, "/", len(models)-1)
}

func numOfModels(project Project) int {
	num_models := 0
	for _, pack := range project.Packages {
		num_models += len(pack.Models)
	}

	return num_models
}
