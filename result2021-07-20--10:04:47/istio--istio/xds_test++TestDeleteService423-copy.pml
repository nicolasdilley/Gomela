// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob/9a5df21188426a6a7dd7d7503e01330a79db8a48/pilot/pkg/xds/eds_test.go#L423
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDeleteService4230 = [1] of {int};
	run TestDeleteService423(child_TestDeleteService4230);
	run receiver(child_TestDeleteService4230)
stop_process:skip
}

proctype TestDeleteService423(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_testEndpoints4921 = [1] of {int};
	Wgdef adscConn_RecvWg;
	Mutexdef adscConn_Registry_mutex;
	Mutexdef adscConn_mutex;
	Mutexdef adscConn_conn_lceMu;
	Mutexdef adscConn_conn_mu;
	chan child_addEdsCluster9280 = [1] of {int};
	Mutexdef s_Listener_mu;
	Mutexdef s_Discovery_adsClientsMutex;
	Mutexdef s_Discovery_updateMutex;
	Mutexdef s_Discovery_mutex;
	run mutexMonitor(s_Discovery_mutex);
	run mutexMonitor(s_Discovery_updateMutex);
	run mutexMonitor(s_Discovery_adsClientsMutex);
	run mutexMonitor(s_Listener_mu);
	run addEdsCluster928(s_Discovery_adsClientsMutex,s_Discovery_mutex,s_Discovery_updateMutex,s_Listener_mu,child_addEdsCluster9280);
	child_addEdsCluster9280?0;
	run mutexMonitor(adscConn_conn_mu);
	run mutexMonitor(adscConn_conn_lceMu);
	run mutexMonitor(adscConn_mutex);
	run mutexMonitor(adscConn_Registry_mutex);
	run wgMonitor(adscConn_RecvWg);
	run testEndpoints492(adscConn_RecvWg,adscConn_conn_lceMu,adscConn_conn_mu,adscConn_mutex,adscConn_Registry_mutex,child_testEndpoints4921);
	child_testEndpoints4921?0;
	stop_process: skip;
	child!0
}
proctype addEdsCluster928(Mutexdef s_Discovery_adsClientsMutex;Mutexdef s_Discovery_mutex;Mutexdef s_Discovery_updateMutex;Mutexdef s_Listener_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fullPush4400 = [1] of {int};
	run fullPush440(s_Discovery_adsClientsMutex,s_Discovery_mutex,s_Discovery_updateMutex,s_Listener_mu,child_fullPush4400);
	child_fullPush4400?0;
	stop_process: skip;
	child!0
}
proctype fullPush440(Mutexdef s_Discovery_adsClientsMutex;Mutexdef s_Discovery_mutex;Mutexdef s_Discovery_updateMutex;Mutexdef s_Listener_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype testEndpoints492(Wgdef adsc_RecvWg;Mutexdef adsc_conn_lceMu;Mutexdef adsc_conn_mu;Mutexdef adsc_mutex;Mutexdef adsc_Registry_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_lbe_LbEndpointslbe_LbEndpoints = -2; // opt var_lbe_LbEndpointslbe_LbEndpoints
	int var_lbe_Endpointslbe_Endpoints = -2; // opt var_lbe_Endpointslbe_Endpoints
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

