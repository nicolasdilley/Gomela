package main

func main() {
	a := 1
	ch := make(chan int, a)
	ch1 := make(chan int)

	go func() {
		for range ch {
			ch1 <- 0
		}
	}()

	for i := 0; i < 1; i++ {
		ch <- i
	}
	close(ch)

	for i := 0; i < 1; i++ {
		<-ch1
	}
}
