
// https://github.com/gohugoio/hugo/blob/master/common/maps/scratch_test.go#L191
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestScratchGetSortedMapValues1910 = [1] of {int};
	run TestScratchGetSortedMapValues191(child_TestScratchGetSortedMapValues1910)
stop_process:skip
}

proctype TestScratchGetSortedMapValues191(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetSortedMapValues1330 = [1] of {int};
	Mutexdef scratch_mu;
	run mutexMonitor(scratch_mu);
	run GetSortedMapValues133(scratch_mu,child_GetSortedMapValues1330);
	child_GetSortedMapValues1330?0;
	stop_process: skip;
	child!0
}
proctype GetSortedMapValues133(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_mu.RLock!false;
	

	if
	:: true -> 
		c_mu.RUnlock!false;
		goto stop_process
	:: true;
	fi;
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

