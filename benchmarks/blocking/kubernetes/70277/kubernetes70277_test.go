package kubernetes70277

import (
	"testing"
	"time"
)

var ForerverTestTimeout = time.Second * 20

func TestKubernetes70277(t *testing.T) {
	stopCh := make(chan struct{})
	defer close(stopCh)
	interval := time.Millisecond
	timeout := ForerverTestTimeout

	ch := make(chan struct{})
	go func() {
		defer close(ch)

		tick := time.NewTicker(interval)
		defer tick.Stop()

		timer := time.NewTimer(timeout)

		defer timer.Stop()

		for {
			select {
			case <-tick.C:
				select {
				case ch <- struct{}{}:
				default:
				}
			case <-timer.C:
				return
			case <-stopCh:
				return
			}
		}
	}()

	<-stopCh // block here
}
