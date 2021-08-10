// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob/9a5df21188426a6a7dd7d7503e01330a79db8a48/pilot/pkg/networking/core/v1alpha3/cluster_builder_test.go#L2123
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_newH2TestCluster21230 = [1] of {int};
	run newH2TestCluster2123(child_newH2TestCluster21230);
	run receiver(child_newH2TestCluster21230)
stop_process:skip
}

proctype newH2TestCluster2123(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_setH2Options5720 = [1] of {int};
	Mutexdef cb_push_initializeMutex;
	Mutexdef cb_push_networksMu;
	Mutexdef cb_push_proxyStatusMutex;
	run mutexMonitor(cb_push_proxyStatusMutex);
	run mutexMonitor(cb_push_networksMu);
	run mutexMonitor(cb_push_initializeMutex);
	run setH2Options572(cb_push_initializeMutex,cb_push_networksMu,cb_push_proxyStatusMutex,child_setH2Options5720);
	child_setH2Options5720?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype setH2Options572(Mutexdef cb_push_initializeMutex;Mutexdef cb_push_networksMu;Mutexdef cb_push_proxyStatusMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

