package main

import "fmt"

func main() {
	ch := make(chan int)
	go func() {
		for i := 0; i < 10; i-- {
			fmt.Println(i)
		}
		ch <- 1
	}()
	fmt.Println("Received", <-ch)
}
