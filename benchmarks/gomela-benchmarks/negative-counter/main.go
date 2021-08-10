package main

import "sync"

func main() {
	var wg sync.WaitGroup /*<\label{line:neg-wg-decl}>*/
	// code omitted
	for range someList { /*<\label{line:neg-for-range}>*/
		go func() { /*<\label{line:neg-wg-go}>*/
			// code omitted
			wg.Done() // triggers a run-time panic /*<\label{line:neg-wg-done}>*/
		}()
		wg.Add(1) /*<\label{line:neg-wg-add}>*/
	}
	wg.Wait() /*<\label{line:neg-wg-wait}>*/
}
