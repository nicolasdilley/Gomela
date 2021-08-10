package main

import "sync"

func FindAll(K int, M int) []int {
	var wg sync.WaitGroup /*<\label{line:wg}>*/
	wg.Add(K)
	found := make(chan int)
	limitCh := make(chan bool, M)

	for i := 0; i < K; i++ {
		limitCh <- true
		go func() { /*<\label{line:pss_spawn}>*/
			found <- 0 // Produce value
			wg.Done()
			<-limitCh
		}()
	}
	go func() {
		wg.Wait()    /*<\label{line:wait}>*/
		close(found) /*<\label{line:close}>*/
	}()
	var results []int
	for p := range found { /*<\label{line:found_rcv}>*/
		results = append(results, p)
	}
	return results
}

func main() {
	FindAll(3, 4)
}
