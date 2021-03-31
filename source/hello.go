package cockroach24808

import (
	"sync"
	"testing"
)

type Compactor struct {
	ch chan struct{}
}

type Stopper struct {
	stop    sync.WaitGroup
	stopper chan struct{}
}

func (c *Compactor) Start(stopper *Stopper) {
	c.ch <- struct{}{}
	stopper.stop.Add(1)

	go func() {
		defer stopper.stop.Done()

		for {
			select {
			case <-stopper.stopper:
				return
			case <-c.ch:
			}
		}
	}()

}

func TestCockroach24808(t *testing.T) {
	stopper := &Stopper{
		stopper: make(chan struct{}),
	}
	defer close(stopper.stopper)

	compactor := &Compactor{ch: make(chan struct{}, 1)}
	compactor.ch <- struct{}{}

	compactor.Start(stopper)
}
