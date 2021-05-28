// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/istio/istio/blob/9a5df21188426a6a7dd7d7503e01330a79db8a48/pilot/pkg/networking/core/v1alpha3/cluster_builder_test.go#L1153
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestApplyUpstreamTLSSettings11530 = [1] of {int};
	run TestApplyUpstreamTLSSettings1153(child_TestApplyUpstreamTLSSettings11530);
	run receiver(child_TestApplyUpstreamTLSSettings11530)
stop_process:skip
}

proctype TestApplyUpstreamTLSSettings1153(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef push_initializeMutex;
	Mutexdef push_networksMu;
	Mutexdef push_proxyStatusMutex;
	int tests = -2; // opt tests
	run mutexMonitor(push_proxyStatusMutex);
	run mutexMonitor(push_networksMu);
	run mutexMonitor(push_initializeMutex);
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

