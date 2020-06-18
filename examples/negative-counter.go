package main

import (
	"fmt"
	"sync"
)

// Runtime error, counter goes in negative !

func main() {
	var wg sync.WaitGroup

	a := make(chan int, 20)
	wg.Add(15)

	for i := 0; i < 20; i++ {
		go Send(a, i, &wg)
	}
	go func() {
		fmt.Println("Entered")
		wg.Wait()
		fmt.Println("1.Finishing")
	}()

	fmt.Println("Entered")
	wg.Wait()
	fmt.Println("2.Finishing")

	for i := 0; i < 20; i++ {
		fmt.Println(<-a, ".")
	}
}

func Send(a chan int, i int, wg *sync.WaitGroup) {
	a <- i
	wg.Done()
}
