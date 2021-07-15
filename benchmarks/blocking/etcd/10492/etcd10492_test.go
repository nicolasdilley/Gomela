package etcd10492

import (
	"context"
	"sync"
	"testing"
	"time"
)

type Checkpointer func(ctx context.Context)

type lessor struct {
	mu                 sync.RWMutex
	cp                 Checkpointer
	checkpointInterval time.Duration
}

func (le *lessor) Checkpoint() {
	le.mu.Lock() // block here
	defer le.mu.Unlock()
}

func (le *lessor) SetCheckpointer() {
	le.mu.Lock()
	defer le.mu.Unlock()

}

func (le *lessor) Renew() {
	le.mu.Lock()
	defer func() { le.mu.Unlock() }()

	if le.cp != nil {
		le.Checkpoint()
	}
}
func TestEtcd10492(t *testing.T) {
	le := &lessor{
		checkpointInterval: 0,
	}
	le.SetCheckpointer()
	le.mu.Lock()
	le.mu.Unlock()
	le.Renew()
}
