package main

import (
	"fmt"
	"runtime"
	"sync"
)

func DoSomeWork(t string) string {
	return t
}

func IsError(s string) bool {
	return s == "e"
}

func main() {
	fmt.Println("Number of CPUs: ", runtime.NumCPU())
	mytrees := []string{"a", "b", "c", "d", "e", "f", "g"}
	preload(mytrees, 1)
	fmt.Println("Number of goroutine: ", runtime.NumGoroutine())
	select {}
}

func preload(trees []string, n int) {
	ch := make(chan string, n)                  // create chan with capacity 'n'/*<\label{line:decl-ch}>*/
	limitCh := make(chan int, runtime.NumCPU()) /*<\label{line:decl-limitch}>*/
	for i := 0; i < runtime.NumCPU(); i++ {     /*<\label{line:decl-for}>*/
		limitCh <- 1 // send token on chan 'limitCh' /*<\label{line:decl-send-limitCh}>*/
	}
	var wg sync.WaitGroup     /*<\label{line:decl-wg}>*/
	for _, t := range trees { /*<\label{line:findall-for}>*/
		wg.Add(1)           // increment 'wg' counter  /*<\label{line:findall-add}>*/
		go func(v string) { // spawn goroutine /*<\label{line:anonym-go}>*/
			<-limitCh // receive token before starting work/*<\label{line:rcv-token}>*/
			s := DoSomeWork(v)
			ch <- s      /*<\label{line:leak-blocking-snd}>*/
			limitCh <- 1 /*<\label{line:snd-token}>*/
			wg.Done()    // decrement 'wg' counter
			fmt.Println(s + " is done")
		}(t)
	}
	go func() { // spawn goroutine /*<\label{line:go-wait}>*/
		wg.Wait() // wait for 'wg' to reach 0
		close(ch) // set 'ch' to closed
	}()
	for s := range ch { // receive message from 'ch' /*<\label{line:for-range}>*/
		if IsError(s) {
			return /*<\label{line:return}>*/
		}
	}
}
