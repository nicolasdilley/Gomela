package test

import (
	"fmt"
	"time"
)

func main() {
	a := make(chan int)

	select {
	case <-a:
		fmt.Println("A")
	case <-time.After(1000):
		fmt.Println("b")
	}
}
