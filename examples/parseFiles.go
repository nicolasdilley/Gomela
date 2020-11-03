package main

import (
	"fmt"
	"io/ioutil"
	"os"
)

func main() {
	files := getFiles(os.Args[1])
	ch := make(chan int, len(files))

	for _, file := range files {
		go parseFile(ch, file)
	}

	for range files {
		<-ch
	}
}

func getFiles(folder string) []os.FileInfo {
	files, err := ioutil.ReadDir(folder)

	return files
}

func parseFile(ch chan int, file os.FileInfo) {
	fmt.Println(file.Name())
	ch <- 0
}
