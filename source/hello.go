package main

import "fmt"

func release(s string) {

	c := make(chan int)
	b := make(chan int)
	defer close(c)

	for i := 0; i < n; i++ {
		go a(c, b)
	}

	for i := 0; i < m; i++ {
		c <- 0
	}

	select {
	case <-c:
		b <- 0
	case <-b:
		fmt.Println("Received b")
	}

}

func a(c chan int, b chan int) {
	select {
	case <-c:
		b <- 0
	case <-b:
		fmt.Println("Received b")
		break
	}
}
