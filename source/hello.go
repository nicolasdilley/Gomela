package main

func release(s string) {

	c := make(chan int)

	if 1 > 2 {
		return
	}

	defer close(c)
}
