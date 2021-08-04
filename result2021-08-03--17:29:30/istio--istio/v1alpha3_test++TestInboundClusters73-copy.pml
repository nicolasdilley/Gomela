// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob/9a5df21188426a6a7dd7d7503e01330a79db8a48/pilot/pkg/networking/core/v1alpha3/sidecar_simulation_test.go#L73
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestInboundClusters730 = [1] of {int};
	run TestInboundClusters73(child_TestInboundClusters730);
	run receiver(child_TestInboundClusters730)
stop_process:skip
}

proctype TestInboundClusters73(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef serviceAlt_Mutex;
	Mutexdef service_Mutex;
	int var_tt_instances = -2; // opt var_tt_instances
	int var_cmap = -2; // opt var_cmap
	int var_cases = -2; // opt var_cases
	run mutexMonitor(service_Mutex);
	run mutexMonitor(serviceAlt_Mutex);
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

