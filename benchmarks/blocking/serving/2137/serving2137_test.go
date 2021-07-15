package serving2137

import (
	"runtime"
	"sync"
	"testing"
)

type token struct{}

type request struct {
	lock     *sync.Mutex
	accepted chan bool
}

type Breaker struct {
	pendingRequests chan token
	activeRequests  chan token
}

func unlock(req request) {
	req.lock.Unlock()
	// Verify that function has completed
	ok := <-req.accepted
	// Requeue for next usage
	req.accepted <- ok
}

//
// G1                           G2                      G3
// b.concurrentRequests(2)
// b.concurrentRequest()
// r.lock.Lock()
//                                                      start.Done()
// start.Wait()
// b.concurrentRequest()
// r.lock.Lock()
//                              start.Done()
// start.Wait()
// unlockAll(locks)
// unlock(lc)
// req.lock.Unlock()
// ok := <-req.accepted
//                              b.Maybe()
//                              b.activeRequests <- t
//                              thunk()
//                              r.lock.Lock()
//                                                      b.Maybe()
//                                                      b.activeRequests <- t
// ----------------------------G1,G2,G3 deadlock-----------------------------
//
func TestServing2137(t *testing.T) {
	b := &Breaker{
		pendingRequests: make(chan token, 1+1),
		activeRequests:  make(chan token, 1),
	}
	runtime.Gosched()

	r := request{lock: &sync.Mutex{}, accepted: make(chan bool, 1)}
	r.lock.Lock()
	var start sync.WaitGroup
	start.Add(1)
	go func() { // G2, G3
		start.Done()

		var t token
		var result bool
		select {
		default:
			// Pending request queue is full.  Report failure.
			result = false
		case b.pendingRequests <- t:
			// Pending request has capacity.
			// Wait for capacity in the active queue.
			b.activeRequests <- t
			// Defer releasing capacity in the active and pending request queue.
			// Do the thing.
			r.lock.Lock() // Will block on locked mutex.
			r.lock.Unlock()

			<-b.activeRequests
			<-b.pendingRequests
			// Report success
			result = true
		}
		r.accepted <- result
	}()
	start.Wait() // Ensure that the go func has had a chance to execute.

	runtime.Gosched()

	r1 := request{lock: &sync.Mutex{}, accepted: make(chan bool, 1)}
	r1.lock.Lock()
	var start1 sync.WaitGroup
	start1.Add(1)
	go func() { // G2, G3
		start1.Done()

		var t token
		var result bool
		select {
		default:
			// Pending request queue is full.  Report failure.
			result = false
		case b.pendingRequests <- t:
			// Pending request has capacity.
			// Wait for capacity in the active queue.
			b.activeRequests <- t
			// Defer releasing capacity in the active and pending request queue.
			// Do the thing.
			r1.lock.Lock() // Will block on locked mutex.
			r1.lock.Unlock()

			<-b.activeRequests
			<-b.pendingRequests
			// Report success
			result = true
		}

		r1.accepted <- result
	}()
	start1.Wait() // Ensure that the go func has had a chance to execute.

	unlock(r)
	unlock(r1)

}
