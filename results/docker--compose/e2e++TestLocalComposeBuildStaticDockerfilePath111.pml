// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/docker/compose/blob//pkg/e2e/compose_build_test.go#L111
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLocalComposeBuildStaticDockerfilePath1110 = [1] of {int};
	run TestLocalComposeBuildStaticDockerfilePath111(child_TestLocalComposeBuildStaticDockerfilePath1110);
	run receiver(child_TestLocalComposeBuildStaticDockerfilePath1110)
stop_process:skip
}

proctype TestLocalComposeBuildStaticDockerfilePath111(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef c_test_context_mu;
	Mutexdef c_test_context_match_mu;
	run mutexMonitor(c_test_context_match_mu);
	run mutexMonitor(c_test_context_mu);
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

