package main

import (
	"fmt"
	"sync"
)

// Works fine .Add(-1) == .Done()
func main() {
	var wg sync.WaitGroup

	a := make(chan int, 20)
	wg.Add(20)

	for i := 0; i < 20; i++ {
		go Send(a, i, &wg)
	}

	fmt.Println("Entered")
	wg.Wait()
	fmt.Println("2.Finishing")

	for i := 0; i < 20; i++ {
		fmt.Println(<-a, ".")
	}
}

func Send(a chan int, i int, wg *sync.WaitGroup) {
	a <- i
	wg.Add(-1)
}
