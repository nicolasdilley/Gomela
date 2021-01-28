package main

import "sync"

func main() {
	errChan := make(chan int)

	wg = new(*sync.WaitGroup)

	var t Test

	wg.Add(1)
	errChan <- 0
}

type Test struct {
	c chan int
	w sync.WaitGroup
}
