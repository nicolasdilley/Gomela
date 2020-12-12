package promela

import (
	"log"
	"os"
	"strconv"
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

func logFeature(feature Feature) {
	toPrint :=
		feature.Proj_name + "," +
			feature.Model + "," +
			feature.Fun + "," +
			feature.Name + "," +
			feature.Mandatory + "," +
			feature.Info + "," +
			strconv.Itoa(feature.Line) + "," +
			feature.Filename + ","

	if feature.Commit != "" {
		toPrint += "https://github.com/" +
			feature.Proj_name + "/blob/" +
			feature.Commit + "/" +
			feature.Filename + "#L" +
			strconv.Itoa(feature.Line)
	} else {
		toPrint += feature.Filename
	}
	log.Println(toPrint)
}

func PrintFeatures(features []Feature) {
	for _, feature := range features {
		logFeature(feature)
	}
}
