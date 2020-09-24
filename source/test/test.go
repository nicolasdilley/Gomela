package main

func main() {
	files := importFiles()

	a := make(chan int, len(files))

	processFiles(a, files)
}

func processFiles(a chan int, files []int) {
	for _, file := range files {
		<-a
	}
}
