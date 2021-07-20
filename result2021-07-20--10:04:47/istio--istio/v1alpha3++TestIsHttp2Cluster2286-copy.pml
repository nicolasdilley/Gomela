// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob/9a5df21188426a6a7dd7d7503e01330a79db8a48/pilot/pkg/networking/core/v1alpha3/cluster_builder_test.go#L2286
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestIsHttp2Cluster22860 = [1] of {int};
	run TestIsHttp2Cluster2286(child_TestIsHttp2Cluster22860);
	run receiver(child_TestIsHttp2Cluster22860)
stop_process:skip
}

proctype TestIsHttp2Cluster2286(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef cb_push_initializeMutex;
	Mutexdef cb_push_networksMu;
	Mutexdef cb_push_proxyStatusMutex;
	int var_teststests = -2; // opt var_teststests
	run mutexMonitor(cb_push_proxyStatusMutex);
	run mutexMonitor(cb_push_networksMu);
	run mutexMonitor(cb_push_initializeMutex);
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

