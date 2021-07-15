
// https://github.com/kubernetes/minikube/blob/master/pkg/minikube/service/service_test.go#L827
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestWaitAndMaybeOpenService8270 = [1] of {int};
	run TestWaitAndMaybeOpenService827(child_TestWaitAndMaybeOpenService8270)
stop_process:skip
}

proctype TestWaitAndMaybeOpenService827(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef defaultAPI_t_context_mu;
	Mutexdef defaultAPI_t_context_match_mu;
	run mutexMonitor(defaultAPI_t_context_match_mu);
	run mutexMonitor(defaultAPI_t_context_mu);
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

