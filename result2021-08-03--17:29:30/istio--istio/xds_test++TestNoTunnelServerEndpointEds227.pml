// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob/9a5df21188426a6a7dd7d7503e01330a79db8a48/pilot/pkg/xds/eds_test.go#L227
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNoTunnelServerEndpointEds2270 = [1] of {int};
	run TestNoTunnelServerEndpointEds227(child_TestNoTunnelServerEndpointEds2270);
	run receiver(child_TestNoTunnelServerEndpointEds2270)
stop_process:skip
}

proctype TestNoTunnelServerEndpointEds227(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_addTestClientEndpoints4440 = [1] of {int};
	Mutexdef s_Listener_mu;
	Mutexdef s_Discovery_adsClientsMutex;
	Mutexdef s_Discovery_updateMutex;
	Mutexdef s_Discovery_mutex;
	run mutexMonitor(s_Discovery_mutex);
	run mutexMonitor(s_Discovery_updateMutex);
	run mutexMonitor(s_Discovery_adsClientsMutex);
	run mutexMonitor(s_Listener_mu);
	run addTestClientEndpoints444(s_Discovery_adsClientsMutex,s_Discovery_mutex,s_Discovery_updateMutex,child_addTestClientEndpoints4440);
	child_addTestClientEndpoints4440?0;
	stop_process: skip;
	child!0
}
proctype addTestClientEndpoints444(Mutexdef server_adsClientsMutex;Mutexdef server_mutex;Mutexdef server_updateMutex;chan child) {
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

