package promela

import (
	"io/ioutil"
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

func CreateCSV() {
	toPrint := "Project, Model, Fun, Type, Mandatory, Info, Line Num, Filename, Link,\n"

	// Print CSV
	d1 := []byte(toPrint)
	filename := "./results/log.csv"
	err := ioutil.WriteFile(filename, d1, 0644)

	if err != nil {
		panic(err)
	}

}
func (m *Model) AddFeature(feature Feature) {
	feature.Model = m.Model
	m.Features = append(m.Features, feature)
}

func (m *Model) AddBound(feature Feature) {
	feature.Model = m.Model
	m.Features = append(m.Features, feature)
}

func PrintFeatures(m *Model, features []Feature) {
	f, err := os.OpenFile("./results/log.csv",
		os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		log.Println(err)
	}
	defer f.Close()
	for _, ch := range m.Chans {
		m.AddFeature(Feature{
			Proj_name: m.Project_name,
			Fun:       m.Fun.Name.String(),
			Name:      "new channel",
			Info:      "Name :" + ch.Name.Name,
			Mandatory: "false",
			Line:      ch.Chan.Line,
			Commit:    m.Commit,
			Filename:  ch.Chan.Filename,
		})
	}
	for _, wg := range m.WaitGroups {
		m.AddFeature(Feature{
			Proj_name: m.Project_name,
			Fun:       m.Fun.Name.String(),
			Name:      "new WaitGroup",
			Info:      "Name :" + wg.Name.Name,
			Mandatory: "false",
			Line:      wg.Wait.Line,
			Commit:    m.Commit,
			Filename:  wg.Wait.Filename,
		})
	}

	for _, feature := range features {
		// open file
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
		toPrint += ",\n"

		if _, err := f.WriteString(toPrint); err != nil {
			log.Println(err)
		}
	}
}
