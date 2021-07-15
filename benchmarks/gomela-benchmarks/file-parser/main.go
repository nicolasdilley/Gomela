package main

import (
	"fmt"
	"io/ioutil"
	"os"
)

func main() {

	files, err := ioutil.ReadDir(os.Args[1])
	parseFiles(files)
}

func parseFiles(files []os.FileInfo) {
	ch := make(chan int)

	for file := range files {
		go parseFile(ch, file)
	}

	for v := range ch {
		fmt.Println(v)
	}
}

func parseFile(ch chan int, file os.FileInfo) {
	ch <- 0
}
