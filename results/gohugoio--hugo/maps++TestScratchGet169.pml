
// https://github.com/gohugoio/hugo/blob/master/common/maps/scratch_test.go#L169
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestScratchGet1690 = [1] of {int};
	run TestScratchGet169(child_TestScratchGet1690)
stop_process:skip
}

proctype TestScratchGet169(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get1010 = [1] of {int};
	Mutexdef scratch_mu;
	run mutexMonitor(scratch_mu);
	run Get101(scratch_mu,child_Get1010);
	child_Get1010?0;
	stop_process: skip;
	child!0
}
proctype Get101(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_mu.RLock!false;
	c_mu.RUnlock!false;
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

