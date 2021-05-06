
// https://github.com/go-kit/kit/blob/master/metrics/generic/generic_test.go#L121
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAtomicAlignment1210 = [1] of {int};
	run TestAtomicAlignment121(child_TestAtomicAlignment1210)
stop_process:skip
}

proctype TestAtomicAlignment121(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef fset_last_mutex;
	Mutexdef fset_mutex;
	run mutexMonitor(fset_mutex);
	run mutexMonitor(fset_last_mutex);
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

