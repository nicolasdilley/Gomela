// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/GoogleContainerTools/skaffold/blob//pkg/skaffold/deploy/kustomize/kustomize_test.go#L206
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestKustomizeCleanup2060 = [1] of {int};
	run TestKustomizeCleanup206(child_TestKustomizeCleanup2060);
	run receiver(child_TestKustomizeCleanup2060)
stop_process:skip
}

proctype TestKustomizeCleanup206(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef tmpDir_t_context_mu;
	Mutexdef tmpDir_t_context_match_mu;
	int var_tests = -2; // opt var_tests
	run mutexMonitor(tmpDir_t_context_match_mu);
	run mutexMonitor(tmpDir_t_context_mu);
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

proctype receiver(chan c) {
c?0
}

