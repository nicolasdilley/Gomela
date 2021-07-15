
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/images/image_manager_test.go#L260
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPullAndListImageWithPodAnnotations2600 = [1] of {int};
	run TestPullAndListImageWithPodAnnotations260(child_TestPullAndListImageWithPodAnnotations2600)
stop_process:skip
}

proctype TestPullAndListImageWithPodAnnotations260(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef fakeRuntime_T_context_mu;
	Mutexdef fakeRuntime_T_context_match_mu;
	run mutexMonitor(fakeRuntime_T_context_match_mu);
	run mutexMonitor(fakeRuntime_T_context_mu);
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

