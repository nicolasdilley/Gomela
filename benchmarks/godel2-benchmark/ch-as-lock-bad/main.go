// +build ignore

package main

import "fmt"

func main() {
	var x int
	ch := make(chan int, 1)
	go f(&x, ch)
	<-ch
	x = 1
	ch <- 0
	<-ch
	fmt.Println("x is", x)
	ch <- 0
}

func f(x *int, ch chan int) {
	<-ch
	*x = -1
	ch <- 0
}
