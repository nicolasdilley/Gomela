package main

import (
	"fmt"
	"sync"
)

func test() {
	var wg *sync.WaitGroup
	b := make(chan int)
	a(wg)
}

func a(wg *sync.WaitGroup) {
	wg.Add(1)
	fmt.Println("test")
}
