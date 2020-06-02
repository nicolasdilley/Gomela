package main

func main() {
	a := make(chan int, 20) /*<\label{line:chan-a}>*/
	
	go prod(a) 
	go prod(a) 
	go prod(a) 
	go prod(a) 
	go prod(a) 
	go prod(a) 
	go prod(a) 
	go prod(a) 
	go prod(a) 
	go prod(a) 	
	go prod(a) 
	go prod(a) 
	go prod(a) 
	go prod(a) 
	go prod(a) 
	go prod(a) 
	go prod(a) 
	go prod(a) 
	go prod(a) 
	go prod(a) 
	
	
	go cons(a) 
}
func prod(a chan int) {
	for { a <- 0 }
}
func cons(a chan int) {
	for { <-a }
}
