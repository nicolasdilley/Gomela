package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"sync"
)

func main() {
	files := getFiles(os.Args[1])
	var wg *sync.WaitGroup

	wg.Add(len(files))
	for _, file := range files {
		go parseFile(ch, file)
	}
	wg.Wait()
}

func getFiles(folder string) []os.FileInfo {
	files, err := ioutil.ReadDir(folder)

	return files
}

func parseFile(wg *sync.WaitGroup, file os.FileInfo) {
	fmt.Println(file.Name())
	wg.Done()
}
