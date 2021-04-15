package main

func sendclose(c chan int) {
	c <- 1
	close(c)
}

func main() {
	ch := make(chan int)
	go sendclose(ch)
	<-ch
	close(ch)
}
