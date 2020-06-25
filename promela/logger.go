package promela

import (
	"io/ioutil"
	"log"
	"os"
	"strconv"
)

// func  CreateHtml() string {
// 	toPrint := "<html> \n" +
// 		"<head> \n" +
// 		"</head> \n" +
// 		"<body> \n" +
// 		"</h1> Features </h1>" +
// 		"<table>" +
// 		"<thead>" +
// 		"<tr>" +
// 		"<th> Project </th>" +
// 		"<th> Type </th>" +
// 		"<th> Line number </th>" +
// 		" <th> Filename </th>" +
// 		" </tr>" +
// 		"</thead>" +
// 		"<tbody>"

// 	for _, counter := range l.Counters {
// 		toPrint += "<tr>\n" +
// 			"<td>" +
// 			counter.Proj_name + "</td>\n" +
// 			"<td>" +
// 			counter.Name + "</td>\n" +
// 			"<td>" + strconv.Itoa(counter.Line) + "</td>\n" +
// 			"<td>" + "<a href=\"https://github.com/" +
// 			counter.Proj_name + "/blob/" +
// 			counter.Commit + "/" +
// 			counter.Filename + "#L" +
// 			strconv.Itoa(counter.Line) + "\">" +
// 			counter.Filename + " </a></td> \n" +
// 			"</tr>\n"
// 	}

// 	toPrint += "</tbody> \n </table>" +
// 		"</body> \n" +
// 		"</html> \n"

// 	return toPrint
// }

func CreateCSV() {
	toPrint := "Project, Fun, Type, Info, Line Num, Filename, Link,\n"

	// Print CSV
	d1 := []byte(toPrint)
	filename := "./results/log.csv"
	err := ioutil.WriteFile(filename, d1, 0644)

	if err != nil {
		panic(err)
	}
}

func PrintCounter(counter Counter) {

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
