package main

import (
	"fmt"
	"time"
)

func Fork(fork chan int) {
	for {
		fork <- 1
		<-fork
	}
}

// philosophers (infinite recursive).
func phil(fork1, fork2 chan int, id int) {
	var x1, x2 int
	for {
		select {
		case x1 = <-fork1:
			select {
			case x2 = <-fork2:
				fmt.Printf("phil %d got both fork\n", id)
				fork1 <- x1
				fork2 <- x2
			default:
				fork1 <- x1
			}
		case x1 = <-fork2:
			select {
			case x2 = <-fork1:
				fmt.Printf("phil %d got both fork\n", id)
				fork2 <- x1
				fork1 <- x2
			default:
				fork2 <- x1
			}
		}
	}
}

func main() {
	fork1 := make(chan int)
	fork2 := make(chan int)
	fork3 := make(chan int)
	fork4 := make(chan int)
	fork5 := make(chan int)
	go phil(fork1, fork2, 0) // deadlock if phil(fork2, fork1, 0)
	go phil(fork2, fork3, 1)
	go phil(fork3, fork4, 2)
	go phil(fork4, fork5, 2)
	go phil(fork5, fork1, 2)
	go Fork(fork1)
	go Fork(fork2)
	go Fork(fork3)
	go Fork(fork4)
	go Fork(fork5)
	time.Sleep(10 * time.Second)
}
