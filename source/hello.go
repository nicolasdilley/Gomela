package main

func release(s string) {

	c := make(chan int, n)

	for i := 0; i < k; i++ {
		<-c
	}
	if 1 > 2 {
		return
	}

	go a(c, g)

	defer close(c)
}

func a(c chan int, g int) {
	for i := 0; i < g; i++ {
		<-c
	}
}
