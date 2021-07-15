/*
 * Project: moby
 * Issue or PR  : https://github.com/moby/moby/pull/28462
 * Buggy version: b184bdabf7a01c4b802304ac64ac133743c484be
 * fix commit-id: 89b123473774248fc3a0356dd3ce5b116cc69b29
 * Flaky: 69/100
 * Description:
 *   There are three goroutines mentioned in the bug report Moby#28405.
 * Actually, only two goroutines are needed to trigger this bug. This bug
 * is another example where lock and channel are mixed with each other.
 *
 * Moby#28405 : https://github.com/moby/moby/issues/28405
 */
package moby28462

import (
	"sync"
	"testing"
)

type State struct {
	Health *Health
}

type Container struct {
	mu    sync.Mutex
	State *State
}

type Store struct {
	ctr *Container
}

type Daemon struct {
	containers Store
}

func (d *Daemon) StateChanged() {

	d.containers.ctr.mu.Lock()
	d.updateHealthMonitorElseBranch(d.containers.ctr)
	defer d.containers.ctr.mu.Unlock()
}

func (d *Daemon) updateHealthMonitorElseBranch(c *Container) {

	c.State.Health.CloseMonitorChannel()
}

type Health struct {
	stop chan struct{}
}

func (s *Health) CloseMonitorChannel() {

	s.stop <- struct{}{}

}

func monitor(c *Container, stop chan struct{}) {
	for {
		select {
		case <-stop:
			return
		default:
			handleProbeResult(c)
		}
	}
}

func handleProbeResult(c *Container) {
	c.mu.Lock()
	defer c.mu.Unlock()
}

///
/// G1							G2
/// monitor()
/// handleProbeResult()
/// 							d.StateChanged()
/// 							c.mu.Lock()
/// 							d.updateHealthMonitorElseBranch()
/// 							h.CloseMonitorChannel()
/// 							s.stop <- struct{}{}
/// c.mu.Lock()
/// ----------------------G1,G2 deadlock------------------------
///
func TestMoby28462(t *testing.T) {

	d := &Daemon{containers: Store{ctr: &Container{
		State: &State{Health: &Health{stop: make(chan struct{})}},
	}}}
	go monitor(d.containers.ctr, d.containers.ctr.State.Health.stop) // G1
	go d.StateChanged()                                              // G2
}
