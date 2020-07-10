package examples

func main() {
	x := 10
	ch := make(chan int)

	for i := 0; i < x; i++ { // x is optional
		<-ch
	}
	a(ch, x) // x is  mandatory

}

func a(ch chan int, x int) {
	for i := 0; i < x; i++ {
		go func() {
			a <- x
		}()
	}
}
