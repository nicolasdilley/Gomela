package promela

import (
	"io/ioutil"
)

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

func (m *Model) PrintBound(counter Counter) {
	counter.Model = m.Model
	m.Features = append(m.Features, counter)

}

func (m *Model) PrintFeature(counter Counter) {
	counter.Model = m.Model
	m.Features = append(m.Features, counter)

}
