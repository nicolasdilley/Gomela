package read

type Read struct {
	X   int
	Ch2 chan int
}

func (r *Read) Print(ch chan int) {
	<-ch
	<-r.Ch2
}
