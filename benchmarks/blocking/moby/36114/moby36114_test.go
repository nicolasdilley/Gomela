/*
 * Project: moby
 * Issue or PR  : https://github.com/moby/moby/pull/36114
 * Buggy version: 6d4d3c52ae7c3f910bfc7552a2a673a8338e5b9f
 * fix commit-id: a44fcd3d27c06aaa60d8d1cbce169f0d982e74b1
 * Flaky: 100/100
 * Description:
 *   This is a double lock bug. The the lock for the
 * struct svm has already been locked when calling
 * svm.hotRemoveVHDsAtStart()
 */
package moby36114

import (
	"sync"
	"testing"
)

type serviceVM struct {
	mu sync.Mutex
}

func (svm *serviceVM) hotAddVHDsAtStart() {
	svm.mu.Lock()
	defer svm.mu.Unlock()
	svm.hotRemoveVHDsAtStart()
}

func (svm *serviceVM) hotRemoveVHDsAtStart() {
	svm.mu.Lock() // Double lock here
	defer svm.mu.Unlock()
}

func TestMoby36114(t *testing.T) {
	s := &serviceVM{}
	go s.hotAddVHDsAtStart()
}
