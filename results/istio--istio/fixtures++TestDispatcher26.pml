
// https://github.com/istio/istio/blob/master/galley/pkg/config/testing/fixtures/listener_test.go#L26
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDispatcher260 = [1] of {int};
	run TestDispatcher26(child_TestDispatcher260)
stop_process:skip
}

proctype TestDispatcher26(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Dispatch290 = [1] of {int};
	Mutexdef h1_mu;
	run mutexMonitor(h1_mu);
	run Dispatch29(h1_mu,child_Dispatch290);
	child_Dispatch290?0;
	stop_process: skip;
	child!0
}
proctype Dispatch29(Mutexdef handler_mu;chan child) {
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

