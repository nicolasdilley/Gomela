package main

func main() { /*<\label{line:main}>*/
	files := getFiles()               
	a := make(chan string, len(files)) 
	for i := 0; i < len(files); i++ {  /*<\label{line:worker-spawn}>*/
		go worker(a, files[i], i) /*<\label{line:spawned-for}>*/
	}
	for i := 0; i < len(files); i++ { /*<\label{line:for-loop}>*/
		<-a /*<\label{line:receive-a}>*/
		<-a  /*<\label{line:deadlock}>*/
	}
}
func worker(a chan int, f string, i int) {
	a <- parseFile(f, i)  /*<\label{line:send}>*/
}
