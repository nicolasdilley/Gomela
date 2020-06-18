package main

import (
	"fmt"
	"sync"
)

// Works fine goroutine at line 17 and main go routines wait before all Send has been done
func main() {
	var wg sync.WaitGroup

	a := make(chan int, 20)
	wg.Add(20)

	for i := 0; i < 20; i++ {
		go Send(a, i, &wg)
	}

	go func() {
		wg.Wait()
	}()

	wg.Wait()

	for i := 0; i < 20; i++ {
		fmt.Println(<-a)
	}
}

func Send(a chan int, i int, wg *sync.WaitGroup) {
	a <- i
	wg.Add(10)
}
