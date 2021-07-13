// Source: github.com/KaiSta/gopherlyzer
// Author: Kai Stadtmueller
// This version is slightly different from the version in the paper:
//   "Static Trace-Based Deadlock Analysis for Synchronous Mini-Go"
// by Stadtmueller et al.

package main

func philo1(forks chan int) {
	for {
		<-forks
		<-forks
		forks <- 1
		forks <- 1
	}
}

func fork1(forks chan int) {
	forks <- 1
}

func fork2(forks chan int) {
	forks <- 1
}

func main() {
	forks := make(chan int)

	go fork1(forks)
	go fork2(forks)
	go philo1(forks)

	for {
		<-forks
		<-forks
		forks <- 1
		forks <- 1
	}
}
