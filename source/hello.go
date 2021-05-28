package main

import (
	"context"
	"runtime"
	"sync"
	"time"
)

// A LRWMutex is a mutual exclusion lock with timeouts.
type LRWMutex struct {
	id          string
	source      string
	isWriteLock bool
	ref         int
	mu          sync.Mutex // Mutex to prevent multiple simultaneous locks
}

func NewLRWMutex() *LRWMutex {
	return &LRWMutex{}
}

// GetRLock tries to get a read lock on lm before the timeout occurs.
func (lm *LRWMutex) GetRLock(ctx context.Context, id string, source string, timeout time.Duration) (locked bool) {

	const isWriteLock = false
	return lm.lockLoop(ctx, id, source, timeout, isWriteLock)
}

// Borrowed from rwmutex_test.go
func parallelReader(ctx context.Context, m *LRWMutex, clocked, cunlock, cdone chan bool) {
	if m.GetRLock(ctx, "", "", time.Second) {
		clocked <- true
		<-cunlock
		m.RUnlock()
		cdone <- true
	}
}

// Borrowed from rwmutex_test.go
func doTestParallelReaders(numReaders, gomaxprocs int) {
	runtime.GOMAXPROCS(gomaxprocs)
	m := NewLRWMutex()

	clocked := make(chan bool)
	cunlock := make(chan bool)
	cdone := make(chan bool)
	for i := 0; i < numReaders; i++ {
		go parallelReader(context.Background(), m, clocked, cunlock, cdone)
	}
	// Wait for all parallel RLock()s to succeed.
	for i := 0; i < numReaders; i++ {
		<-clocked
	}
	for i := 0; i < numReaders; i++ {
		cunlock <- true
	}
	// Wait for the goroutines to finish.
	for i := 0; i < numReaders; i++ {
		<-cdone
	}
}
