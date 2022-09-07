package main

var x int = 3

func main() {
	ch := make(chan int, 10)

	go send(ch)
	go rcv(ch)
}

func send(ch chan int) {

	for i := 0; i < x; i++ {
		ch <- 0
	}
}

func rcv(ch chan int) {

	<-ch

	//	panic("Here")
}
