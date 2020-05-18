package main

import (
	"strconv"

	"github.com/nicolasdilley/gomela/promela"
)

type Logger struct {
	Proj_name string
	Counters  []promela.Counter
}

func (l *Logger) Print() string {
	toPrint := "<html> \n" +
		"<head> \n" +
		"</head> \n" +
		"<body> \n" +
		"</h1> " + l.Proj_name + "</h1>" +
		"<table>" +
		"<thead>" +
		"<tr>" +
		"<th> Name </th>" +
		"<th> Line number </th>" +
		" <th> Filename </th>" +
		" </tr>" +
		"</thead>" +
		"<tbody>"

	for _, counter := range l.Counters {
		toPrint += "<tr>\n" +
			"<td>" +
			counter.Name + "</td>\n" +
			"<td>" + strconv.Itoa(counter.Line) + "</td>\n" +
			"<td>" + "<a href=\"https://github.com/" +
			l.Proj_name + "/blob/" +
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
