package cockroach2448

import (
	"testing"
	"time"
)

type Stopper struct {
	Done chan bool
}

func (s *Stopper) ShouldStop() <-chan bool {
	return s.Done
}

type EventMembershipChangeCommitted struct {
	Callback func()
}
type MultiRaft struct {
	stopper      *Stopper
	Events       chan interface{}
	callbackChan chan func()
}

// sendEvent can be invoked many times
func sendEvent(event interface{}, events chan interface{}, done chan bool) {
	/// FIX:
	/// Let event append a event queue instead of pending here
	select {
	case events <- event: // Waiting for events consumption
	case <-done:
	}
}

func start(events chan interface{}, callbackChan chan func(), done chan bool) {
	for {
		select {
		case <-done:
			return
		case cb := <-callbackChan:
			cb()
		default:
			handleWriteResponse(events, callbackChan, done)
		}
	}
}
func handleWriteResponse(events chan interface{}, callbackChan chan func(), done chan bool) {
	processCommittedEntry(events, callbackChan, done)
}

func processCommittedEntry(events chan interface{}, callbackChan chan func(), done chan bool) {
	select {
	case events <- nil: // Waiting for events consumption
	case <-done:
	}
}

func processRaft(events chan interface{}, callbackChan chan func(), done chan bool) {
	for {
		select {
		case <-events:
			select {
			case callbackChan <- func() { // Waiting for callbackChan consumption
				time.Sleep(time.Nanosecond)
			}:
			case <-done:
			}
		case <-done:
			return
		}
	}
}

func TestCockroach2448(t *testing.T) {
	done := make(chan bool)
	events := make(chan interface{})
	callbackChan := make(chan func())

	go processRaft(events, callbackChan, done) // G1
	go start(events, callbackChan, done)       // G2
}
