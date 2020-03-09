package main

func main() { /*<\label{line:main}>*/
	files := getFiles()
	a := make(chan string)            /*<\label{line:new-chan}>*/
	for i := 0; i < len(files); i++ { /*<\label{line:worker-spawn}>*/
		go worker(a, files[i], i) /*<\label{line:spawned-for}>*/
	}
	for i := 0; i < len(files); i++ { /*<\label{line:for-loop}>*/
		<-a /*<\label{line:receive-a}>*/
	}
}
func worker(a chan int, f string, i int) {
	a <- parseFile(f, i) /*<\label{line:send}>*/
	a <- parseFile(f, i) /*<\label{line:goroutine-leak}>*/
}
