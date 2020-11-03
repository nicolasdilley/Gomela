package main

func main() {
	b := make(chan int, test)

	go a(b)
}

func a(d chan int) {
	c := make(chan int, len(files))

	for range files {
		d <- 0
	}

	<-c
}
