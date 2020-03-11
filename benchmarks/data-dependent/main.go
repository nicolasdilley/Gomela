package main

func main() {
	a := make(chan int)

	go send(a)

	if true { /*<\label{line:if1}>*/
		a <- 0
	} else {}
}

func send(a chan int) {
	if true { /*<\label{line:if2}>*/
		<-a
	} else {}
}
