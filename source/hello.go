package main

import (
	"fmt"
	"sync"
)

func (op *softmaxOp) do(shp tensor.Shape, axis int, input, output interface{}) {
	workers := make(chan int)
	var wg sync.WaitGroup

	for b := 0; b < datalen; b += blockSize {
		wg.Add(1)
		switch data := input.(type) {
		case []float64:
			go func(data, output []float64, dimSize, dimStride int, wg *sync.WaitGroup) {
				workers <- struct{}{}
				op.f64skernel(data, output, inner, ostride, dimSize, dimStride)
				wg.Done()
				<-workers
			}(newdata, newoutput, dimSize, dimStride, &wg)
		case []float32:
			go func(data, output []float32, dimSize, dimStride int, wg *sync.WaitGroup) {
				workers <- struct{}{}
				wg.Done()
				<-workers
			}(newdata, newoutput, dimSize, dimStride, &wg)
		default:
			panic(fmt.Sprintf("tensor of %T not handled for softmax diff ", data))

		}
	}
	wg.Wait()
}
