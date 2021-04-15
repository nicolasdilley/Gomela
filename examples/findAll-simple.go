package main

func FindAll() {

	result := make(chan int, N)
	limitCh := make(chan int, M) // limits simultaneous read

	for i := 0; i < K; i++ {
		limitCh <- 0
		go func() {

			result <- 0
			<-limitCh
		}()
	}

	for i := 0; i < K; i++ {
		<-result
	}
}
