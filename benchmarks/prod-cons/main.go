package main

func Producer(ch chan int) {
	for i := 0; i < 5; i++ {
		ch <- i // Send i to ch
	}
	close(ch) // No further values accepted at ch
}

func Consumer(ch1, ch2 chan int) {
	for {
		select {
		case x := <-ch1: // Either receive from ch1
			print(x)
		case x := <-ch2: // ... or receive from ch2
			print(x)
		}
	}
}

func main() {
	ch1, ch2 := make(chan int), make(chan int)
	go Producer(ch1)
	go Producer(ch2)
	Consumer(ch1, ch1)
}
