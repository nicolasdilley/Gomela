
// https://github.com/ethereum/go-ethereum/blob/master/core/vm/runtime/runtime_test.go#L251
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBlockhash2510 = [1] of {int};
	run TestBlockhash251(child_TestBlockhash2510)
stop_process:skip
}

proctype TestBlockhash251(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef __snaps_lock;
	Mutexdef __snaps_triedb_lock;
	run mutexMonitor(__snaps_triedb_lock);
	run mutexMonitor(__snaps_lock);
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

