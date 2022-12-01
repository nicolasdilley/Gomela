package main

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

	for range ch {
		ch <- 0
	}
}
