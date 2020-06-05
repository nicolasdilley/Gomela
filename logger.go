package main

import (
	"strconv"

	"github.com/nicolasdilley/gomela/promela"
)

type Logger struct {
	Counters []promela.Counter
}

func (l *Logger) PrintHTML() string {
	toPrint := "<html> \n" +
		"<head> \n" +
		"</head> \n" +
		"<body> \n" +
		"</h1> Features </h1>" +
		"<table>" +
		"<thead>" +
		"<tr>" +
		"<th> Project </th>" +
		"<th> Type </th>" +
		"<th> Line number </th>" +
		" <th> Filename </th>" +
		" </tr>" +
		"</thead>" +
		"<tbody>"

	for _, counter := range l.Counters {
		toPrint += "<tr>\n" +
			"<td>" +
			counter.Proj_name + "</td>\n" +
			"<td>" +
			counter.Name + "</td>\n" +
			"<td>" + strconv.Itoa(counter.Line) + "</td>\n" +
			"<td>" + "<a href=\"https://github.com/" +
			counter.Proj_name + "/blob/" +
			counter.Commit + "/" +
			counter.Filename + "#L" +
			strconv.Itoa(counter.Line) + "\">" +
			counter.Filename + " </a></td> \n" +
			"</tr>\n"
	}

	toPrint += "</tbody> \n </table>" +
		"</body> \n" +
		"</html> \n"

	return toPrint
}

func (l *Logger) PrintCSV() string {
	toPrint := "Project, Fun, Type, Info, Line Num, Filename, Link,\n"

	for _, counter := range l.Counters {
		toPrint +=
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
	}

	return toPrint
}
