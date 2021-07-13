package istio16224

import (
	"sync"
	"testing"
)

type Event int

type Handler func(Event)

type configstoreMonitor struct {
	handlers []Handler
	eventCh  chan Event
}

func (c *controller) Run(stop <-chan struct{}, done chan bool, lock *sync.Mutex) {
	c.monitor.Run(stop, done, lock)
}

func (m *configstoreMonitor) Run(stop <-chan struct{}, done chan bool, lock *sync.Mutex) {
	for {
		select {
		case <-stop:
			if _, ok := <-m.eventCh; ok {
				close(m.eventCh)
			}
			return
		case _, ok := <-m.eventCh:
			if ok {
				lock.Lock()
				done <- true
				lock.Unlock()
			}
		}
	}
}

func (m *configstoreMonitor) ScheduleProcessEvent(configEvent Event) {
	m.eventCh <- configEvent
}

type controller struct {
	monitor *configstoreMonitor
}

func (c *controller) Create() {
	c.monitor.ScheduleProcessEvent(Event(0))
}

func TestIstio16224(t *testing.T) {
	controller := &controller{monitor: &configstoreMonitor{
		eventCh: make(chan Event),
	}}
	done := make(chan bool)
	lock := &sync.Mutex{}

	stop := make(chan struct{})
	go controller.Run(stop, done, lock)

	controller.Create()

	lock.Lock()
	lock.Unlock()
	<-done

	close(stop)
}
