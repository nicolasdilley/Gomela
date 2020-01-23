package main

func Producer(ch chan struct{}) {
	for i := 0; i < 10; i++ {
		ch <- struct{}{}
	}
	close(ch)
}

func Consumer(ch1, ch2 chan struct{}) {
	for {
		select {
		case <-ch1:
		case <-ch2:
		default:
		}
	}
}

func main() {
	beer := make(chan struct{}, 4)
	chips := make(chan struct{}, 4)
	cars := make(chan struct{}, 4)

	go Producer(beer)
	go Producer(chips)
	go Producer(cars)

	go Consumer(beer, chips)
	go Consumer(chips, cars)
}
