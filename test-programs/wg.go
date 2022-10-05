package main

import "sync"

func main() {
	var wg sync.WaitGroup

	wg.Add(10)

	go send(wg)
}

func send(wg sync.WaitGroup) {

	for i := 0; i < x; i++ {
		wg.Done()
	}
}
