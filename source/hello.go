package main

import (
	"fmt"
)

func main() {
	files := getFiles()

	ch := make(chan string, len(files))

	for i := 0; i < len(files); i++ {
		go readFile(ch, files[i])
	}

	for i := 0; i < 3; i++ {
		file_content := <-ch
		fmt.Println(file_content)
	}
}

func readFile(ch chan string, file string) {
	ch <- parseFile(file)
}
