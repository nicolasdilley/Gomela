
// https://github.com/kubernetes/kubernetes/blob/master/test/e2e/framework/log_test.go#L75
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFailureOutput750 = [1] of {int};
	run TestFailureOutput75(child_TestFailureOutput750)
stop_process:skip
}

proctype TestFailureOutput75(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_runTests450 = [1] of {int};
	Mutexdef fakeT_context_mu;
	Mutexdef fakeT_context_match_mu;
	run mutexMonitor(fakeT_context_match_mu);
	run mutexMonitor(fakeT_context_mu);
	run runTests45(fakeT_context_match_mu,fakeT_context_mu,child_runTests450);
	child_runTests450?0;
	stop_process: skip;
	child!0
}
proctype runTests45(Mutexdef t_context_match_mu;Mutexdef t_context_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

