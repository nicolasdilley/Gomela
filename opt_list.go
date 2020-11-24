package main

import "fmt"

type OptList struct {
	list [][]interface{}
}

func (l OptList) Len() int {
	return len(l.list)
}

func (l OptList) Less(opt1 int, opt2 int) bool {
	return countUnknown(l.list[opt1]) > countUnknown(l.list[opt2])
}
func (l OptList) Swap(opt1 int, opt2 int) {
	prev := l.list[opt1]
	l.list[opt1] = l.list[opt2]
	l.list[opt2] = prev
}

func countUnknown(opt []interface{}) int {
	num_of_unknown := 0
	for _, b := range opt {
		if fmt.Sprint(b) == "-2" {
			num_of_unknown++
		}
	}

	return num_of_unknown
}
