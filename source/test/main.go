package main

func mand(num int, opt int) {
	a := make(chan int, num)

	for i := 0; i < num; i++ {
		go opt(a, 10)
	}

	for i := 0; i < opt; i++ {
		a <- 1
	}
}

func opt(a chan int, num int) {
	for i := 0; i < num; i++ {
		<-a
	}
}
