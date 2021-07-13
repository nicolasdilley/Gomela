package main

import "fmt"

func main() {
	ch := make(chan string) // creates a channel

	go print(ch, "hello") // spawns a goroutine that will send 'hello' on ch

	fmt.Println(<-ch) // prints what is received from ch

	go print(ch, "world ") // spawns a goroutine that will send 'world' on ch

	fmt.Println(<-ch) // prints what is received from ch
}

func print(ch chan string, toSend string) {
	ch <- toSend // send the value of toSend on ch
}
