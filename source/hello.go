package main

func main() {
	ch := make(chan int)
	ch1 := make(chan int)

	go func() {
		ch <- 0
		<-ch1
	}()
	ch1 <- 0
	close(ch)
}
