package main

import "fmt"

func main() {
	ch := make(chan int)
	go func() {
		for i := 0; i < 10; i-- {
			fmt.Println(i)
		}
	}()
	fmt.Println("Received", <-ch)
}
