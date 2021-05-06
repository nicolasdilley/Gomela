package main

import (
	"fmt"
)

func main() {

	ch := make(chan int, 3)

	fmt.Println("test")
	go func() {
		for range ch {
			fmt.Println("Hello")
		}
	}()

	for i := 0; i < 3; i++ {
		ch <- i
	}
	close(ch)

}
