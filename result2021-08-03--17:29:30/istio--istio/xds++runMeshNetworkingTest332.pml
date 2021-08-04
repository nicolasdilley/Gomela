// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob/9a5df21188426a6a7dd7d7503e01330a79db8a48/pilot/pkg/xds/mesh_network_test.go#L332
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_runMeshNetworkingTest3320 = [1] of {int};
	run runMeshNetworkingTest332(child_runMeshNetworkingTest3320);
	run receiver(child_runMeshNetworkingTest3320)
stop_process:skip
}

proctype runMeshNetworkingTest332(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Test3932 = [1] of {int};
	chan child_Test3933 = [1] of {int};
	chan child_setupProxy4490 = [1] of {int};
	chan child_setupProxy4491 = [1] of {int};
	Mutexdef s_Listener_mu;
	Mutexdef s_Discovery_adsClientsMutex;
	Mutexdef s_Discovery_updateMutex;
	Mutexdef s_Discovery_mutex;
	int var_tt_workloads = -2; // opt var_tt_workloads
	int var_tt_kubeObjects = -2; // opt var_tt_kubeObjects
	run mutexMonitor(s_Discovery_mutex);
	run mutexMonitor(s_Discovery_updateMutex);
	run mutexMonitor(s_Discovery_adsClientsMutex);
	run mutexMonitor(s_Listener_mu);
	

	if
	:: var_tt_workloads-1 != -3 -> 
				for(i : 0.. var_tt_workloads-1) {
			for30: skip;
			run setupProxy449(s_Discovery_adsClientsMutex,s_Discovery_mutex,s_Discovery_updateMutex,s_Listener_mu,child_setupProxy4490);
			child_setupProxy4490?0;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for31: skip;
			run setupProxy449(s_Discovery_adsClientsMutex,s_Discovery_mutex,s_Discovery_updateMutex,s_Listener_mu,child_setupProxy4491);
			child_setupProxy4491?0;
			for31_end: skip
		:: true -> 
			break
		od;
		for31_exit: skip
	fi;
	

	if
	:: var_tt_workloads-1 != -3 -> 
				for(i : 0.. var_tt_workloads-1) {
			for40: skip;
			run Test393(s_Discovery_adsClientsMutex,s_Discovery_mutex,s_Discovery_updateMutex,s_Listener_mu,child_Test3932);
			child_Test3932?0;
			for40_end: skip
		};
		for40_exit: skip
	:: else -> 
		do
		:: true -> 
			for41: skip;
			run Test393(s_Discovery_adsClientsMutex,s_Discovery_mutex,s_Discovery_updateMutex,s_Listener_mu,child_Test3933);
			child_Test3933?0;
			for41_end: skip
		:: true -> 
			break
		od;
		for41_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype setupProxy449(Mutexdef s_Discovery_adsClientsMutex;Mutexdef s_Discovery_mutex;Mutexdef s_Discovery_updateMutex;Mutexdef s_Listener_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Test393(Mutexdef s_Discovery_adsClientsMutex;Mutexdef s_Discovery_mutex;Mutexdef s_Discovery_updateMutex;Mutexdef s_Listener_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_w_expectations = -2; // opt var_w_expectations
	

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

