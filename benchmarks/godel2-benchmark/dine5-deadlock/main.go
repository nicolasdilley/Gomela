// +build ignore

package main

import (
	"fmt"
	"sync"
	"time"
)


func phil(m1, m2 *sync.Mutex, f1, f2 *int, id int) {
	for {
		m1.Lock()
		fmt.Printf("Phil %d got left fork", id)
		*f1 += 1
		m2.Lock()
		fmt.Printf("Phil %d right fork", id)
		*f2 += 1
		m2.Unlock()
		m1.Unlock()
	}
}

func main() {
	m1 := new(sync.Mutex)
	m2 := new(sync.Mutex)
	m3 := new(sync.Mutex)
	m4 := new(sync.Mutex)
	m5 := new(sync.Mutex)
	var f1, f2, f3, f4, f5 int;
	go phil(m1, m2, &f1, &f2, 0)
	go phil(m2, m3, &f2, &f3, 1)
	go phil(m3, m4, &f3, &f4, 2)
	go phil(m4, m5, &f4, &f5, 3)
	go phil(m5, m1, &f5, &f1, 4)
	time.Sleep(10*time.Second)
}
