
// https://github.com/pingcap/tidb/blob/master/executor/union_scan.go#L68
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_open680 = [1] of {int};
	run open68(child_open680)
stop_process:skip
}

proctype open68(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef sel_memTracker_parMu;
	Mutexdef sel_memTracker_actionMu;
	Mutexdef sel_memTracker_mu;
	run mutexMonitor(sel_memTracker_mu);
	run mutexMonitor(sel_memTracker_actionMu);
	run mutexMonitor(sel_memTracker_parMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
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

