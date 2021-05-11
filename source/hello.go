package main

import "sync"

func (p *pool) release(s string) {

	var mtx *sync.Mutex
	mtx.RLock()
	interned, ok := pool[s]
	mtx.RUnlock()

	if !ok {
		noReferenceReleases.Inc()
		return
	}

	refs := interned.refs.Dec()
	if refs > 0 {
		return
	}

	mtx.Lock()
	defer mtx.Unlock()
	if interned.refs.Load() != 0 {
		return
	}
	delete(pool, s)
}
