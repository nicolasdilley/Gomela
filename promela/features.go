package promela

import (
	"log"
	"os"
	"strconv"
	"strings"
)

type Feature struct {
	Proj_name string
	Model     string
	Fun       string
	Name      string
	Info      string
	Mandatory string
	Line      int
	Filename  string
	Commit    string
}

func CreateCSV(result_folder string) {

	log_file, _ := os.OpenFile("./"+result_folder+"/log.csv",
		os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	log.SetOutput(log_file)
	log.SetPrefix("")
	log.SetFlags(0)
	// defer log_file.Close()

	// Print CSV
	log.Printf("Project, Model, Fun, Type, Mandatory, Info, Line Num, Filename, Link")

}

func logFeature(feature Feature, m *Model) {

	name := strings.Split(
		m.Fileset.Position(m.Fun.Pos()).Filename, m.Projects_folder+"/")
	path := []string{m.Fileset.Position(m.Fun.Pos()).Filename}

	splitted := []string{""}
	if len(name) > 1 {
		splitted = strings.Split(
			name[1],
			"/")
		path = splitted[1:]
	}

	file_path := ""

	for i, p := range path {
		file_path += p

		if i < len(path)-1 {
			file_path += "/"
		}
	}

	proj_name := strings.Replace(splitted[0], AUTHOR_PROJECT_SEP, "/", -1)
	filename := "https://github.com/" + proj_name + "/blob/" + m.Commit + "/" + file_path + "#L" + strconv.Itoa(m.Fileset.Position(m.Fun.Pos()).Line)

	toPrint :=
		proj_name + "," +
			feature.Model + "," +
			feature.Fun + "," +
			feature.Name + "," +
			feature.Mandatory + "," +
			feature.Info + "," +
			strconv.Itoa(feature.Line) + "," +
			filename + ","

	toPrint += feature.Commit

	log.Println(toPrint)
}

func PrintFeatures(features []Feature, m *Model) {
	for _, feature := range features {
		logFeature(feature, m)
	}
}
