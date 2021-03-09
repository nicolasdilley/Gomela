package test1

func maniac(ch chan int) bool {
	close(ch)
	return false
}
