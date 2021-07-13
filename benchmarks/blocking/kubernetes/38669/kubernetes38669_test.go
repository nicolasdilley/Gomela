package kubernetes38669

import (
	"sync"
	"testing"
)

type Event int
type watchCacheEvent int

type cacheWatcher struct {
	sync.Mutex
	input   chan watchCacheEvent
	result  chan Event
	stopped bool
}

func (c *cacheWatcher) process(initEvents []watchCacheEvent) {
	for _, event := range initEvents {
		c.sendWatchCacheEvent(&event)
	}
	defer close(c.result)
	defer c.Stop()
	for {
		_, ok := <-c.input
		if !ok {
			return
		}
	}
}

func (c *cacheWatcher) sendWatchCacheEvent(event *watchCacheEvent) {
	c.result <- Event(*event)
}

func (c *cacheWatcher) Stop() {
	c.stop()
}

func (c *cacheWatcher) stop() {
	c.Lock()
	defer c.Unlock()
	if !c.stopped {
		c.stopped = true
		close(c.input)
	}
}

func TestKubernetes38669(t *testing.T) {
	initEvents := []watchCacheEvent{1, 2}
	watcher := &cacheWatcher{
		input:   make(chan watchCacheEvent, 0),
		result:  make(chan Event, 0),
		stopped: false,
	}
	go watcher.process(initEvents)
	watcher.Stop()
}
