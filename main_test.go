package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"os/exec"
	"path/filepath"
	"strconv"
	"strings"
	"testing"
)

const (
	test_projects    = "test_projects.csv"
	gl_test_filename = "testmodels/gl_test.csv"
)

type Model struct {
	Name            string
	commit          string
	numParams       int
	glScore         string
	SendScore       string
	CloseScore      string
	NegCounterScore string
}

func TestMain(t *testing.T) {

	fmt.Println("Parsing GL models")

	// Go through each of the 141 GL model and test them individually
	data, _ := ioutil.ReadFile(gl_test_filename)
	projects := make(map[string][]Model) // map of projects and their
	lines := strings.Split(string(data), "\n")
	for _, line := range lines[:len(lines)-1] {
		splitted := strings.Split(line, ",")

		model_line := splitted[0]

		project := strings.ReplaceAll(strings.Split(model_line, ":")[0], AUTHOR_PROJECT_SEP, "/")

		num_params, _ := strconv.Atoi(splitted[2])
		send_score := truncate(splitted[3])
		close_score := truncate(splitted[4])
		neg_counter_score := truncate(splitted[5])
		gl_score := truncate(strings.Split(splitted[6], "\r")[0])

		model := Model{
			Name:            strings.Split(splitted[0], ":")[1],
			commit:          splitted[1],
			numParams:       num_params,
			glScore:         gl_score,
			SendScore:       send_score,
			CloseScore:      close_score,
			NegCounterScore: neg_counter_score,
		}

		projects[project] = append(projects[project], model)
	}

	// remove all results2021* results
	fmt.Println("Removing result2021 folders")
	filepath.Walk(".", func(path string, file os.FileInfo, err error) error {
		if file.IsDir() {
			if strings.Contains(file.Name(), "result20") {
				os.RemoveAll(path)
			}

			if file.Name() != "." {
				return filepath.SkipDir
			}
		} else {
			if strings.Contains(file.Name(), ".trail") {
				os.Remove(path)
			}
		}

		return nil
	})

	projects_list := ""
	for p, m := range projects {
		projects_list += p + "," + m[0].commit + "\n"
	}
	ioutil.WriteFile(test_projects, []byte(projects_list), 0766)

	fmt.Println("Building gomela")
	building := exec.Command("go", "build")
	building.Stderr = os.Stdout
	building.Stdout = os.Stdout
	building.Run()

	fmt.Println("Starting the modelling phase")
	modelling := exec.Command("./gomela", "-l", test_projects)
	modelling.Stderr = os.Stdout
	modelling.Stdout = os.Stdout
	err := modelling.Run()

	if err != nil {
		fmt.Println("there was an error while modelling the projects: ", err)
	}
	result_folder_path := ""
	fmt.Println("Looking for the result folder")
	filepath.Walk(".", func(path string, file os.FileInfo, err error) error {
		if file.IsDir() {
			if strings.Contains(file.Name(), "result20") {
				result_folder_path = path
			}
			if file.Name() != "." {
				return filepath.SkipDir
			}
		}

		return nil
	})

	if result_folder_path == "" {
		t.Errorf("Could not find result folder")
		t.Fail()
	}
	RESULTS_FOLDER = result_folder_path

	folders, err := ioutil.ReadDir(result_folder_path)

	if err != nil {
		t.Errorf("Could not look at the number of file in %s", result_folder_path)
		t.Fail()
	}
	if len(folders)-2 != len(projects) {
		t.Errorf("The number of projects modelled is not equal to number of input project! Inputted %d projects and got %d back", len(projects), len(folders)-2)

		not_found := []string{}
		for p, _ := range projects {
			found := false
			for _, m := range folders {
				if strings.ReplaceAll(p, "/", AUTHOR_PROJECT_SEP) == m.Name() {
					found = true
					break
				}

				if !found {
					not_found = append(not_found, p)
				}
			}

			// fmt.Println("The projects not found are :")
			// for _, s := range not_found {
			// 	fmt.Println(s)
			// }
		}
	}

	fmt.Println("Removing uneeded models")

	projects_to_verify := make(map[string][]os.FileInfo)
	filepath.Walk(result_folder_path, func(dir_path string, dir_file os.FileInfo, err error) error {
		if dir_file.IsDir() && dir_file.Name() != result_folder_path {
			filepath.Walk(dir_path, func(path string, file os.FileInfo, err error) error {
				if !file.IsDir() {
					found := false
					if models, ok := projects[strings.ReplaceAll(dir_file.Name(), AUTHOR_PROJECT_SEP, "/")]; ok {
						for _, m := range models {
							if file.Name() == m.Name {
								found = true
								break
							}
						}
					} else {
						t.Errorf("Could not find project %s", strings.ReplaceAll(dir_file.Name(), AUTHOR_PROJECT_SEP, "/"))
					}

					if !found {
						os.Remove(path)
					}
				}
				return nil
			})
			models, err1 := ioutil.ReadDir(dir_path)

			if err1 != nil {
				t.Errorf("Could not read dir %s ", dir_path)
			}
			projects_to_verify[dir_file.Name()] = models
			return filepath.SkipDir
		}

		return nil
	})

	fmt.Println("Verifying all models")
	for p, models := range projects_to_verify {
		VerifyModels(models, p)
	}

	fmt.Println("Testing that all models are reported as deadlocks")
	survey_parser := exec.Command("./survey_parser/survey_parser", "./"+RESULTS_FOLDER+"/log.csv", "./projects.txt", "./"+RESULTS_FOLDER+"/verification.csv")

	survey_parser.Run()

	scores, err2 := ioutil.ReadFile("./scores.csv")
	if err2 != nil {
		t.Fatal("could not open scores.csv")
	}

	result_projects := make(map[string][]Model)
	score_lines := strings.Split(string(scores), "\n")
	for _, line := range score_lines[:len(score_lines)-1] {
		splitted := strings.Split(line, ",")

		model_line := splitted[0]

		project := strings.ReplaceAll(strings.Split(model_line, ":")[0], AUTHOR_PROJECT_SEP, "/")

		num_params, _ := strconv.Atoi(splitted[2])
		send_score := truncate(splitted[3])
		close_score := truncate(splitted[4])
		neg_counter_score := truncate(splitted[5])
		gl_score := truncate(strings.Split(splitted[6], "\r")[0])

		model := Model{
			Name:            strings.Split(splitted[0], ":")[1],
			commit:          splitted[1],
			numParams:       num_params,
			glScore:         gl_score,
			SendScore:       send_score,
			CloseScore:      close_score,
			NegCounterScore: neg_counter_score,
		}

		result_projects[project] = append(result_projects[project], model)
	}

	for p, models := range projects {
		if result_models, ok := result_projects[p]; ok {
			for _, model := range models {
				var result *Model
				for _, result_model := range result_models {
					if model.Name == result_model.Name {
						result = &result_model
						break
					}
				}

				if result == nil {
					t.Errorf("Could not find model %s in project %s ", model.Name, p)
					t.Fail()
				} else {

					if result.numParams != model.numParams {
						t.Errorf("Model %s was expected to have %d parameters but had %d", model.Name, model.numParams, result.numParams)
					}
					if result.glScore != model.glScore {
						t.Errorf("Model %s was expected to have a GL score of %s but had a score of %s", model.Name, model.glScore, result.glScore)
					}
					if result.SendScore != model.SendScore {
						t.Errorf("Model %s was expected to have a send score of %s but had a score of %s", model.Name, model.SendScore, result.SendScore)
					}
					if result.CloseScore != model.CloseScore {
						t.Errorf("Model %s was expected to have a close score of %s but had a score of %s", model.Name, model.CloseScore, result.CloseScore)
					}
					if result.NegCounterScore != model.NegCounterScore {
						t.Errorf("Model %s was expected to have a neg counter score of %s but had a score of %s", model.Name, model.NegCounterScore, result.NegCounterScore)
					}
				}
			}
		} else {
			t.Errorf("Project " + p + "did not generate any models.")
		}
	}
}

func truncate(s string) string {

	new_s := s
	if len(s) > 4 {
		new_s = s[:4]
	}
	return new_s
}
