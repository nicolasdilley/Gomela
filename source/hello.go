package main

import "github.com/nicolasdilley/gomela/source/read"

type Write struct {
	X int
}
type SWrite struct {
	X   int
	Ch3 chan int
}

func main() {

	s := SWrite{X: 0, Ch3: make(chan int)}
	w := Write{X: 0}
	r := read.Read{X: 0, Ch2: make(chan int)}
	ch := make(chan int, 0)

	r.Print(ch)
	w.Print(ch)
	s.Print()

}

func (w *Write) Print(ch chan int) {
	ch <- w.X
}

func (s *SWrite) Print() {
	<-s.Ch3
}
