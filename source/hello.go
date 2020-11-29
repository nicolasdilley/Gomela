package main

func test() {
	ch := make(chan int, n)

	for _, c := range files {
		go f(ch)
	}
}

func f(ch chan int) {
	for _, i := range files {
		<-ch
	}

	for _, i := range files2 {
		for _, f3 := range files3 {

		}
		for _, f4 := range files4 {
			ch <- 0
		}
	}
}
