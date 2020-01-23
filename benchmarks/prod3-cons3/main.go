package main

func Producer(ch1, ch2 chan struct{}) {
	for {
		if 2 == 0 {
			ch1 <- struct{}{}
		} else {
			ch2 <- struct{}{}
		}
	}
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
	beer := make(chan struct{}, 1)
	chips := make(chan struct{}, 1)
	cars := make(chan struct{}, 1)
	bikes := make(chan struct{}, 1)

	go Producer(beer, chips)
	go Producer(chips, cars)
	go Producer(cars, bikes)

	go Consumer(beer, chips)
	go Consumer(chips, cars)
	go Consumer(cars, bikes)
}
