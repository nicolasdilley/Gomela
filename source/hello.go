package v2

import (
	"sync"
)

const (
	Lis int = 3
)

func Fetch() {

	results := make(chan int, 2)
	var wg sync.WaitGroup
	for x := 0; x < Lis; x++ {
		wg.Add(1)
		<-results
	}
	for x := 0; x < Lis; x++ {
		<-results
	}
	for x := 0; x < Lis; x++ {
		<-results
	}
	a(results)
	go a(results)
}

func a(ch chan int) {
	for range iou {

	}

	for x := 0; x < test(); x++ {

	}
}
