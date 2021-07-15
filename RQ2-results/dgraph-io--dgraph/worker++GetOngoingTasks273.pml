
// https://github.com/dgraph-io/dgraph/blob/master/worker/draft.go#L273
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
	chan child_GetOngoingTasks2730 = [1] of {int};
	run GetOngoingTasks273(child_GetOngoingTasks2730)
stop_process:skip
}

proctype GetOngoingTasks273(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Wgdef n_cdcTracker_closer_waiting;
	Mutexdef n_opsLock;
	Wgdef n_closer_waiting;
	run wgMonitor(n_closer_waiting);
	run mutexMonitor(n_opsLock);
	run wgMonitor(n_cdcTracker_closer_waiting);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	n_opsLock.Lock!false;
	goto stop_process;
	stop_process: skip;
		n_opsLock.Unlock!false;
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

