package syncthing5795_test

import (
	"sync"
	"testing"
)

type message interface{}

type ClusterConfig struct{}

type Model interface {
	ClusterConfig(message, *rawConnection)
}

type TestModel struct {
	ccFn func()
}

func (t *TestModel) ClusterConfig(msg message, c *rawConnection) {
	c.Close()
}

func newTestModel() *TestModel {
	return &TestModel{}
}

type Connection interface {
	Start()
	Close()
}

type rawConnection struct {
	receiver Model

	inbox                 chan message
	dispatcherLoopStopped chan struct{}
	closed                chan struct{}
	closeOnce             sync.Once
}

func (c *rawConnection) Start() {
	go c.readerLoop()
	go func() {
		c.dispatcherLoop()
	}()
}

func (c *rawConnection) readerLoop() {
	for {
		select {
		case <-c.closed:
			return
		default:
		}
	}
}

func (c *rawConnection) dispatcherLoop() {
	defer close(c.dispatcherLoopStopped)
	var msg message
	for {
		select {
		case msg = <-c.inbox:
		case <-c.closed:
			return
		}
		switch msg := msg.(type) {
		case *ClusterConfig:
			c.receiver.ClusterConfig(msg, c)
		default:
			return
		}
	}
}

func (c *rawConnection) internalClose() {
	close(c.closed)
	<-c.dispatcherLoopStopped
}

func (c *rawConnection) Close() {
	c.internalClose() // FIX: go c.internalClose()
}

func TestSyncthing5795(t *testing.T) {
	m := newTestModel()
	c := &rawConnection{
		dispatcherLoopStopped: make(chan struct{}),
		closed:                make(chan struct{}),
		inbox:                 make(chan message),
		receiver:              m,
	}

	c.Start()
	c.inbox <- &ClusterConfig{}

	<-c.dispatcherLoopStopped
}
