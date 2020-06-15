package main

func main() {
	a := make(chan int)

	Test(a)
}

func Test(a chan int) {

	var b int = 10
	for i := 0; i < b; i++ {
		go Routine(a)
		<-a
	}
}

func Routine(a chan int) {
	a <- 0
}
