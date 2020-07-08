package promela

import (
	"io/ioutil"
	"log"
	"os"
	"strconv"
)

func CreateCSV() {
	toPrint := "Project, Fun, Type, Info, Line Num, Filename, Link,\n"

	// Print CSV
	d1 := []byte(toPrint)
	filename := "./results/log.csv"
	err := ioutil.WriteFile(filename, d1, 0644)

	if err != nil {
		panic(err)
	}

	toPrint = "Project, Fun, Type, Mandatory, Info, Line Num, Filename, Link,\n"

	// Print CSV
	d1 = []byte(toPrint)
	filename = "./results/bound.csv"
	err = ioutil.WriteFile(filename, d1, 0644)

	if err != nil {
		panic(err)
	}
}

func PrintBound(counter Counter) {

	f, err := os.OpenFile("./results/bound.csv",
		os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		log.Println(err)
	}
	defer f.Close()

	// open file
	toPrint :=
		counter.Proj_name + "," +
			counter.Fun + "," +
			counter.Name + "," +
			counter.Mandatory + "," +
			counter.Info + "," +
			strconv.Itoa(counter.Line) + "," +
			counter.Filename + ","

	if counter.Commit != "" {
		toPrint += "https://github.com/" +
			counter.Proj_name + "/blob/" +
			counter.Commit + "/" +
			counter.Filename + "#L" +
			strconv.Itoa(counter.Line)
	} else {
		toPrint += counter.Filename
	}
	toPrint += ",\n"

	if _, err := f.WriteString(toPrint); err != nil {
		log.Println(err)
	}
}

func PrintFeature(counter Counter) {

	f, err := os.OpenFile("./results/log.csv",
		os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		log.Println(err)
	}
	defer f.Close()

	// open file
	toPrint :=
		counter.Proj_name + "," +
			counter.Fun + "," +
			counter.Name + "," +
			counter.Info + "," +
			strconv.Itoa(counter.Line) + "," +
			counter.Filename + ","

	if counter.Commit != "" {
		toPrint += "https://github.com/" +
			counter.Proj_name + "/blob/" +
			counter.Commit + "/" +
			counter.Filename + "#L" +
			strconv.Itoa(counter.Line)
	} else {
		toPrint += counter.Filename
	}
	toPrint += ",\n"

	if _, err := f.WriteString(toPrint); err != nil {
		log.Println(err)
	}
}
