package main

import (
	"runtime"
	"sync"
)

func preload(trees []string, n int) {
	ch := make(chan string, n)                  // new chan with capacity n/*<\label{line:decl-ch}>*/
	limitCh := make(chan int, runtime.NumCPU()) /*<\label{line:decl-limitch}>*/
	for i := 0; i < runtime.NumCPU(); i++ {     /*<\label{line:decl-for}>*/
		limitCh <- 1 // send token on chan limitCh /*<\label{line:decl-send-limitCh}>*/
	}
	var wg sync.WaitGroup     /*<\label{line:decl-wg}>*/
	for _, t := range trees { /*<\label{line:findall-for}>*/
		wg.Add(1)           // increment wg counter  /*<\label{line:findall-add}>*/
		go func(v string) { // spawn goroutine /*<\label{line:anonym-go}>*/
			<-limitCh // receive token before starting work/*<\label{line:rcv-token}>*/
			s := DoSomeWork(v)
			ch <- s      /*<\label{line:leak-blocking-snd}>*/
			limitCh <- 1 // return token /*<\label{line:snd-token}>*/
			wg.Done()    // decrement wg counter
		}(t)
	}
	go func() { // spawn goroutine /*<\label{line:go-wait}>*/
		wg.Wait() // wait for wg to reach 0
		close(ch) // set ch to closed
	}()
	for s := range ch { // receive message from ch /*<\label{line:for-range}>*/
		if IsError(s) {
			return /*<\label{line:return}>*/
		}
	}
}
