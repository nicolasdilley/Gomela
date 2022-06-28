// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grafana/k6/blob//js/runner_test.go#L1041
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestVUIntegrationTLSConfig10410 = [1] of {int};
	run TestVUIntegrationTLSConfig1041(child_TestVUIntegrationTLSConfig10410);
	run receiver(child_TestVUIntegrationTLSConfig10410)
stop_process:skip
}

proctype TestVUIntegrationTLSConfig1041(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RegisterBuiltinMetrics1020 = [1] of {int};
	Mutexdef registry_l;
	int var_runners = -2; // opt var_runners
	int var_testdata = -2; // opt var_testdata
	int var_build_Default_ReleaseTags = -2; // opt var_build_Default_ReleaseTags
	run mutexMonitor(registry_l);
	run RegisterBuiltinMetrics102(registry_l,child_RegisterBuiltinMetrics1020);
	child_RegisterBuiltinMetrics1020?0;
	stop_process: skip;
	child!0
}
proctype RegisterBuiltinMetrics102(Mutexdef registry_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

proctype receiver(chan c) {
c?0
}
