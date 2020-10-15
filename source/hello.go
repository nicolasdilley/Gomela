package main

import "fmt"


func main() {
  SIZE := 60
  ch := make(chan string) // creates a channel
  ch2 := make(chan string)
  for i := 0; i < SIZE;i++ {
    go print(ch,ch2, "hello") // spawns a goroutine that will send 'hello' on ch

  }

  for i := 0; i < SIZE;i++ {
    go print(ch,ch2, "world ") // spawns a goroutine that will send 'world' on ch
  }

  for i := 0; i < 120;i++ {
    select {
    case <-ch:
      fmt.Println("test")
    case <-ch2:
      fmt.Println("test2")
    }
  }


}

func print(ch chan string,ch1 chan string, toSend string) {
  select{
  case ch <- toSend:
  case ch1 <- toSend:
  }
}
