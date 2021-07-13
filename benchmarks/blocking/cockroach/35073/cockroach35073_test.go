package cockroach35073

import (
	"sync"
	"sync/atomic"
	"testing"
)

type ConsumerStatus uint32

const (
	NeedMoreRows ConsumerStatus = iota
	DrainRequested
	ConsumerClosed
)

const rowChannelBufSize = 16
const outboxBufRows = 16

type rowSourceBase struct {
	consumerStatus ConsumerStatus
}

func (rb *rowSourceBase) consumerClosed() {
	atomic.StoreUint32((*uint32)(&rb.consumerStatus), uint32(ConsumerClosed))
}

type RowChannelMsg int

type RowChannel struct {
	rowSourceBase
	dataChan chan RowChannelMsg
}

func (rc *RowChannel) ConsumerClosed() {
	rc.consumerClosed()
	select {
	case <-rc.dataChan:
	default:
	}
}

func (rc *RowChannel) Push() ConsumerStatus {
	consumerStatus := ConsumerStatus(
		atomic.LoadUint32((*uint32)(&rc.consumerStatus)))
	switch consumerStatus {
	case NeedMoreRows:
		rc.dataChan <- RowChannelMsg(0)
	case DrainRequested:
	case ConsumerClosed:
	}
	return consumerStatus
}

func (m *RowChannel) start(wg *sync.WaitGroup) {
	wg.Add(1)

	go m.run(wg)
}

func (m *RowChannel) run(wg *sync.WaitGroup) {
	m.mainLoop()
	wg.Done()
}

func (m *RowChannel) mainLoop() {
	return
}

func TestCockroach35073(t *testing.T) {
	rc := RowChannel{dataChan: make(chan RowChannelMsg, rowChannelBufSize)}

	var wg sync.WaitGroup
	for i := 0; i < outboxBufRows; i++ {
		rc.Push()
	}

	var blockedPusherWg sync.WaitGroup
	blockedPusherWg.Add(1)
	go func() {
		rc.Push()
		blockedPusherWg.Done()
	}()

	rc.start(&wg)

	wg.Wait()
	rc.Push()
}
