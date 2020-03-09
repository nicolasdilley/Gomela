package main

func main() {
	a := make(chan int, k) /*<\label{line:chan-a}>*/
	//b := make(chan int) /*<\label{line:chan-b}>*/
	for i := 0; i < m; i++ { /*<\label{line:worker-spawn}>*/
		go prod(a) /*<\label{line:spawned-prod}>*/
	}
	for i := 0; i < n; i++ { /*<\label{line:for-loop}>*/
		go cons(a) /*<\label{line:spawned-cons}>*/
	}
	//close(b) /*<\label{line:closing-b}>*/
}
func prod(a chan int) {
	for { a <- 0 }
}
func cons(a chan int) {
	for { <-a }
}