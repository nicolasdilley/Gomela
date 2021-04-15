package main

import (
	"fmt"
	"os"
)

func main() {
	files := getFiles()
	ch := make(chan string)

	for i := 0; i < len(files); i++ {
		go readFile(ch, file)
	}

	for i := 0; i < x; i++ {
		file_content := <-ch
		fmt.Println(file_content)
	}

}

func readFile(ch chan string, file os.FileInfo) {
	ch <- parseFile(file)
}
