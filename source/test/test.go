package main

func main() {
	a := make(chan int)

	for i := 0; i < 10; i++ {
		b(a)
	}
}

func b(a chan int) {
	a <- c(a)
}

func c(a chan int) {
	go d(a)
}

func d(a chan int) {
	b(a)
}
