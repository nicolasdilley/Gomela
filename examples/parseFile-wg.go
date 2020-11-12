package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"sync"
)

func main() {
	files := ioutil.ReadDir(folder)
	var wg *sync.WaitGroup

	for _, file := range files {
		wg.Add(1)
		go parseFile(wg, file)
	}
	wg.Wait()
}

func parseFile(wg *sync.WaitGroup, file os.FileInfo) {
	fmt.Println(file.Name())
	wg.Done()
}
