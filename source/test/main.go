package main

func mand(num int, opt int) {
	a := make(chan int, num)

	num_2 := 0
	for i := 0; i < num_2; i++ {
		go opt(a, num)
	}

	for i := 0; i < opt; i++ {
		a <- 1
	}
}

func opt(a chan int, num int) {
	for i := 0; i < num; i++ {
		<-a
	}

	for i := 0; i < <-a; i++ {
		<-a
	}
}
