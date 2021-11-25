package worker

import (
	"fmt"
)

func worker(j int, x chan<- int, y <-chan int) { /*<\label{line:worker-begin}>*/
	for {
		select {
		case x <- j: // send
		case <-y:
			return // receive
		}
	}
} /*<\label{line:worker-end}>*/
func main() {
	a := make(chan int) /*<\label{line:worker-newchan-a}>*/
	b := make(chan int) /*<\label{line:worker-newchan-b}>*/

	for i := 0; i < 30; i++ { /*<\label{line:bounded-for}>*/
		go worker(i, a, b) /*<\label{line:worker-spawn}>*/
	}
	for i := 0; i < 10; i++ {
		k := <-a       // receive /*<\label{line:worker-read}>*/
		fmt.Println(k) /*<\label{line:worker-print}>*/
	}
	close(b) /*<\label{line:worker-close}>*/
}
