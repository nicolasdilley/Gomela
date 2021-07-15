package main

func main() {
	a := make(chan int)
	b := make(chan int)

	for i := 0; i < 3; i++ {
		go func() {
			<-b
			a <- 1
		}()
	}
	<-a
	b <- 1
}
