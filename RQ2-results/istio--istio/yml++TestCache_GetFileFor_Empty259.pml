
// https://github.com/istio/istio/blob/master/pkg/test/util/yml/cache_test.go#L259
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCache_GetFileFor_Empty2590 = [1] of {int};
	run TestCache_GetFileFor_Empty259(child_TestCache_GetFileFor_Empty2590)
stop_process:skip
}

proctype TestCache_GetFileFor_Empty259(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetFileFor1530 = [1] of {int};
	Mutexdef c_mu;
	run mutexMonitor(c_mu);
	run GetFileFor153(c_mu,child_GetFileFor1530);
	child_GetFileFor1530?0;
	stop_process: skip;
	child!0
}
proctype GetFileFor153(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_mu.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		c_mu.Unlock!false;
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

