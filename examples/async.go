package main

import "fmt"

func main() {
	a := make(chan int, 2)
	b := make(chan int, 2)

	go func() {
		select {
		case a <- 0:
			fmt.Println("sent a")
		case b <- 0:
			fmt.Println("sent b")
		}
	}()
	select {
	case <-a:
		fmt.Println("received a")
	case <-b:
		fmt.Println("received b")
	}

}

// PROMELA MODEL

init {
  Chandef a = Chandef{
                      send: [0] of int,
                      rcv: [0] of int,
                      capacity: 2,
                    }
  Chandef b = Chandef{
                      send: [0] of int,
                      rcv: [0] of int,
                      capacity: 2,
                    }

  run Anonymous0(a,b);

  do
  :: a.rcv?0 ->
    break
  :: b.rcv?0 ->
    break
  od
stop_process:}

proctype Anonymous0(Chandef a;Chandef b) {
  bool closed;
  int i;
  do
  :: a.send!0 ->
    break
  :: b.send!0 ->
    break
  od;
stop_process:
}

/*
* Promela chan model
 */

proctype go_chan(Chandef ch) {
  do
  :: true ->
    if
    :: ch.capacity != ch.size && ch.capacity != 0 -> // can receive and send

      if
      :: ch.send?0->
         ch.capacity++
      :: ch.rcv!0
         ch.capacity--
      fi
    :: ch.capacity == 0 -> // channel is empty
      ch.send?0
      ch.capacity++
    :: ch.capacity == ch.size -> // channel is full
      ch.rcv?0
      ch.capacity--
    fi;
  od
}
