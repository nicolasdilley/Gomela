// Source: github.com/KaiSta/gopherlyzer
// Author: Kai Stadtmueller

package main

func sel(x, y chan bool) {
	z := make(chan bool)
	go func() { z <- (<-x) }()
	go func() { z <- (<-y) }()
	<-z
}

func main() {
	x := make(chan bool)
	y := make(chan bool)
	go func() { x <- true }()
	go func() { y <- true }()
	sel(x, y)
	sel(x, y)
}
