
// https://github.com/istio/istio/blob/master/galley/pkg/config/testing/fixtures/accumulator_test.go#L26
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAccumulator260 = [1] of {int};
	run TestAccumulator26(child_TestAccumulator260)
stop_process:skip
}

proctype TestAccumulator26(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Handle321 = [1] of {int};
	chan child_Handle320 = [1] of {int};
	Mutexdef a_mu;
	run mutexMonitor(a_mu);
	run Handle32(a_mu,child_Handle320);
	child_Handle320?0;
	run Handle32(a_mu,child_Handle321);
	child_Handle321?0;
	stop_process: skip;
	child!0
}
proctype Handle32(Mutexdef a_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	a_mu.Lock!false;
	stop_process: skip;
		a_mu.Unlock!false;
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

