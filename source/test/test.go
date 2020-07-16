package main

const a int = 10

func main() {
	ch := make(chan int, a)
	b(ch, a)
}

func b(ch2 chan int, a int) {
	// c(time.After(32), a)
	c(ch2, <-ch2)
	ch2 <- 1
}

func c(ch1 chan int, i int) {
	u := make(chan int, i)
	ch1 <- 1
}

func test() {
	a := make(chan int)

	c(a, 10)
}
