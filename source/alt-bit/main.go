package main

// Labels removed (Same meaning with Minigo) (Cannot break from select in MiniGo only from for loops)

// Alternating bit - from Milner's Communication and Concurrency

import (
	"fmt"
)

func main() {
	trans := make(chan int, 1)
	ack := make(chan int, 1)
	go tx(trans, ack)
	rx(ack, trans)
}

func tx(snd chan<- int, ack <-chan int) {
	b := 0
	for {
		fmt.Printf("tx[%d]: accept\n", b)
		fmt.Printf("tx[%d]: send[%d]\n", b, b)
		snd <- b

		for { // SENDING[b]
			select {
			case x := <-ack:
				if x == b {
					fmt.Printf("tx[%d]: ack[b]\n", b)
					b = (b + 1) % 2
					break
				} else {
					fmt.Printf("tx[%d]: ack[!b]\n", b)
					b = (b + 1) % 2
					// SENDING b
				}
			case snd <- b:
				fmt.Printf("tx[%d]: timeout\n", b)
				fmt.Printf("tx[%d]: send[%d]\n", b, b)
				// SENDING b
			}
		}
	}
}

func rx(reply chan<- int, trans <-chan int) {
	b := 1
	for {
		fmt.Printf("rx[%d]: deliver\n", b)
		fmt.Printf("rx[%d]: reply[%d]\n", b, b)
		reply <- b

		for {
			select { // REPLYING[b]
			case x := <-trans:
				if x != b {
					fmt.Printf("rx[%d]: trans[!b]\n", b)
					break
				} else {
					fmt.Printf("rx[%d]: trans[b]\n", b)
					// REPLYING b
				}
			case reply <- b:
				fmt.Printf("rx[%d]: timeout\n", b)
				fmt.Printf("rx[%d]: reply[%d]\n", b, b)
				// REPLYING b
			}
		}
	}
}
