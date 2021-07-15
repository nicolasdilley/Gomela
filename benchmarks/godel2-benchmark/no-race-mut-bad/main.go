// +build ignore

package main

import (
	"fmt"
	"sync"
)

func Writer(mut *sync.Mutex, x *int) {
	mut.Lock()	// Missing Unlock, if acquires teh lock first -> Deadlock
	*x++
}

func main() {
	m1 := new(sync.Mutex)
	m2 := new(sync.Mutex)
	var x, y int
	Writer(m1, &x)
	Writer(m2, &y)
	m1.Lock()
	fmt.Println("x is", x)
	m1.Unlock()
	m2.Lock()
	fmt.Println("y is", y)
	m2.Unlock()
}
