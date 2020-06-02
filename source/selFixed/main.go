// Source: github.com/KaiSta/gopherlyzer
// Author: Kai Stadtmueller

package main

func selFixed(x, y chan bool) {
	select {
	case _ = <-x:
	case _ = <-y:
	}
}

func main() {
	x := make(chan bool)
	y := make(chan bool)
	go func() { x <- true }()
	go func() { y <- true }()
	selFixed(x, y)
	selFixed(x, y)
}
