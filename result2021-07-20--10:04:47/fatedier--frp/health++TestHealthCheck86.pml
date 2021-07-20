// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/fatedier/frp/blob/2408f1df04ad9128ee31a013799f5790dbda5cb3/tests/ci/health/health_test.go#L86
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestHealthCheck860 = [1] of {int};
	run TestHealthCheck86(child_TestHealthCheck860);
	run receiver(child_TestHealthCheck860)
stop_process:skip
}

proctype TestHealthCheck86(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestHealthCheck2962821 = [1] of {int};
	chan child_AnonymousTestHealthCheck2862820 = [1] of {int};
	Mutexdef mu;
	Wgdef wait;
	Mutexdef healthMu;
	run mutexMonitor(healthMu);
	healthMu.Lock!false;
	healthMu.Unlock!false;
	healthMu.Lock!false;
	healthMu.Unlock!false;
	run wgMonitor(wait);
	run mutexMonitor(mu);
	wait.update!2;
	run AnonymousTestHealthCheck286282(wait,healthMu,mu,child_AnonymousTestHealthCheck2862820);
	run receiver(child_AnonymousTestHealthCheck2862820);
	run AnonymousTestHealthCheck296282(wait,healthMu,mu,child_AnonymousTestHealthCheck2962821);
	run receiver(child_AnonymousTestHealthCheck2962821);
	wait.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestHealthCheck286282(Wgdef wait;Mutexdef healthMu;Mutexdef mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	mu.Lock!false;
	mu.Unlock!false;
		defer1: skip;
	wait.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousTestHealthCheck296282(Wgdef wait;Mutexdef healthMu;Mutexdef mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	mu.Lock!false;
	mu.Unlock!false;
		defer1: skip;
	wait.update!-1;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

proctype mutexMonitor(Mutexdef m) {
bool locked = false;
do
:: true ->
	if
	:: m.Counter > 0 ->
		if 
		:: m.RUnlock?false -> 
			m.Counter = m.Counter - 1;
		:: m.RLock?false -> 
			m.Counter = m.Counter + 1;
		fi;
	:: locked ->
		m.Unlock?false;
		locked = false;
	:: else ->	 end:	if
		:: m.Unlock?false ->
			assert(0==32);		:: m.Lock?false ->
			locked =true;
		:: m.RUnlock?false ->
			assert(0==32);		:: m.RLock?false ->
			m.Counter = m.Counter + 1;
		fi;
	fi;
od
}

proctype receiver(chan c) {
c?0
}

