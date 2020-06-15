package main

import "sync"

type Num struct {
	num int
}

func main() {

	wg := sync.WaitGroup{}
	ints := []int{10, 23, 23, 2323, 23232}
	a := make(chan int, ints[0])
	num := Num{num: 10}
	for i := 0; i < len(ints); i++ {
		go func() {
			<-a
		}()
	}
}

func (n *Num) Test() {
	return n.num
}
