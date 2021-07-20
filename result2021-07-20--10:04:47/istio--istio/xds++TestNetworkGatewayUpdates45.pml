// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob/9a5df21188426a6a7dd7d7503e01330a79db8a48/pilot/pkg/xds/mesh_network_test.go#L45
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNetworkGatewayUpdates450 = [1] of {int};
	run TestNetworkGatewayUpdates45(child_TestNetworkGatewayUpdates450);
	run receiver(child_TestNetworkGatewayUpdates450)
stop_process:skip
}

proctype TestNetworkGatewayUpdates45(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_setupProxy4490 = [1] of {int};
	chan child_setupProxy4491 = [1] of {int};
	Mutexdef s_Listener_mu;
	Mutexdef s_Discovery_adsClientsMutex;
	Mutexdef s_Discovery_updateMutex;
	Mutexdef s_Discovery_mutex;
	int var_workloadsworkloads = -2; // opt var_workloadsworkloads
	run mutexMonitor(s_Discovery_mutex);
	run mutexMonitor(s_Discovery_updateMutex);
	run mutexMonitor(s_Discovery_adsClientsMutex);
	run mutexMonitor(s_Listener_mu);
	

	if
	:: var_workloads-1 != -3 -> 
				for(i : 0.. var_workloads-1) {
			for20: skip;
			run setupProxy449(s_Discovery_adsClientsMutex,s_Discovery_mutex,s_Discovery_updateMutex,s_Listener_mu,child_setupProxy4490);
			child_setupProxy4490?0;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for21: skip;
			run setupProxy449(s_Discovery_adsClientsMutex,s_Discovery_mutex,s_Discovery_updateMutex,s_Listener_mu,child_setupProxy4491);
			child_setupProxy4491?0;
			for21_end: skip
		:: true -> 
			break
		od;
		for21_exit: skip
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

