package main

import (
	"fmt"
	"os"
	"strconv"
)

func sender(a chan int, x int) {
	for i := 0; i < x; i++ {
		a <- i
	}
}

func receiver(a chan int, x int) {
	for i := 0; i < x; i++ {
		x := <-a
		fmt.Println(x)
	}
}

func main() {
	x, _ := strconv.Atoi(os.Args[1])
	a := make(chan int)
	go sender(a, x)
	receiver(a, x)
}
