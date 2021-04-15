package main

import "sync"

func preloadSimplified() {
	ch := make(chan int, N)          // The number of token that you want to parse
	workTokens := make(chan bool, M) // M here might be # of cores
	for i := 0; i < M; i++ {         // Activating the number of thread that EXECUTE concurrently
		workTokens <- true
	}
	wg := &sync.WaitGroup{}

	for range K {
		wg.Add(1)
		go func() {
			defer wg.Done()
			// wait for a token before starting work
			<-workTokens // Dont start executing before a worker is available
			// return it when done
			defer func() { workTokens <- true }()

			ch <- t
		}()
	}

	go func() {
		wg.Wait()
		close(ch)
		close(workTokens)
	}()

	for t := range ch {
		err := parseResponse(t)
		if err != nil {
			return
		}
	}

}
