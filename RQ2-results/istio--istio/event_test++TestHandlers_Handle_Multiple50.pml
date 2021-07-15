
// https://github.com/istio/istio/blob/master/pkg/config/event/handlers_test.go#L50
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestHandlers_Handle_Multiple500 = [1] of {int};
	run TestHandlers_Handle_Multiple50(child_TestHandlers_Handle_Multiple500)
stop_process:skip
}

proctype TestHandlers_Handle_Multiple50(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef h2_mu;
	Mutexdef h1_mu;
	run mutexMonitor(h1_mu);
	run mutexMonitor(h2_mu);
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

