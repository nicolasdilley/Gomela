// type = ALL
// bounds = 10
package main

import "sync"

func main() {
	for i := 0; i < 1000; i++ {
		var wg sync.WaitGroup
		wg.Wait()
	}

}

func rec(mu *sync.Mutex, i int) {

	if i > 0 {
		mu.Unlock()
		rec(mu, i-1)
	}
}
