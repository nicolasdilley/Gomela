package main

func main() { /*<\label{line:main}>*/
	files := getFiles()                // decl. of getFiles() omitted 
	a := make(chan string, len(files)) // create bounded buffer 'a'/*<\label{line:new-chan}>*/
	for i := 0; i < len(files); i++ {  /*<\label{line:worker-spawn}>*/
		go worker(a, files[i], i) //spawn worker() /*<\label{line:spawned-for}>*/
		go worker(a, files[i], i) //spawn worker() /*<\label{line:spawned-for}>*/
		worker(a, files[i], i)
	}
	for i := 0; i < len(files); i++ { /*<\label{line:for-loop}>*/
		<-a // receive from 'a' /*<\label{line:receive-a}>*/
	}
}
func worker(a chan int, f string, i int) {
	a <- parseFile(f, i) // send data on 'a' (decl. of parseFile() omitted)  /*<\label{line:send}>*/
}
