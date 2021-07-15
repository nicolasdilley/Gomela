package cockroach35931

import (
	"sync"
	"testing"
)

type RowReceiver interface {
	Push()
}

type inboundStreamInfo struct {
	receiver RowReceiver
}

type RowChannel struct {
	dataChan chan struct{}
}

func (rc *RowChannel) Push() {
	rc.dataChan <- struct{}{}
}

type flowEntry struct {
	flow           *Flow
	inboundStreams map[int]*inboundStreamInfo
}

type flowRegistry struct {
	sync.Mutex
	flows map[int]*flowEntry
}

func (fr *flowRegistry) getEntryLocked(id int) *flowEntry {
	entry, ok := fr.flows[id]
	if !ok {
		entry = &flowEntry{}
		fr.flows[id] = entry
	}
	return entry
}

type Flow struct {
	id             int
	flowRegistry   *flowRegistry
	inboundStreams map[int]*inboundStreamInfo
}

func (f *Flow) cancel(left *RowChannel, right *RowChannel) {
	left.Push()
	right.Push()
}

func makeFlowRegistry() *flowRegistry {
	return &flowRegistry{
		flows: make(map[int]*flowEntry),
	}
}

func TestCockroach35931(t *testing.T) {
	fr := makeFlowRegistry()

	left := &RowChannel{dataChan: make(chan struct{}, 1)}
	right := &RowChannel{dataChan: make(chan struct{}, 1)}

	left.Push()

	flow := &Flow{
		id:           0,
		flowRegistry: fr,
	}

	flow.cancel(left, right)
}
