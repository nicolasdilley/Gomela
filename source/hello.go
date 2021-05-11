package main

func (p *pool) release(s string) {

	ch := make(chan int, n)

	ch <- 0
	ch <- 0

	<-ch
	<-ch
}
