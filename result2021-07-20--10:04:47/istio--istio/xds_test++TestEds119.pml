// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob/9a5df21188426a6a7dd7d7503e01330a79db8a48/pilot/pkg/xds/eds_test.go#L119
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
	chan child_TestEds1190 = [1] of {int};
	run TestEds119(child_TestEds1190);
	run receiver(child_TestEds1190)
stop_process:skip
}

proctype TestEds119(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Wgdef adscConn2_RecvWg;
	Mutexdef adscConn2_Registry_mutex;
	Mutexdef adscConn2_mutex;
	Mutexdef adscConn2_conn_lceMu;
	Mutexdef adscConn2_conn_mu;
	Wgdef adscConn_RecvWg;
	Mutexdef adscConn_Registry_mutex;
	Mutexdef adscConn_mutex;
	Mutexdef adscConn_conn_lceMu;
	Mutexdef adscConn_conn_mu;
	Mutexdef s_Listener_mu;
	Mutexdef s_Discovery_adsClientsMutex;
	Mutexdef s_Discovery_updateMutex;
	Mutexdef s_Discovery_mutex;
	run mutexMonitor(s_Discovery_mutex);
	run mutexMonitor(s_Discovery_updateMutex);
	run mutexMonitor(s_Discovery_adsClientsMutex);
	run mutexMonitor(s_Listener_mu);
	run mutexMonitor(adscConn_conn_mu);
	run mutexMonitor(adscConn_conn_lceMu);
	run mutexMonitor(adscConn_mutex);
	run mutexMonitor(adscConn_Registry_mutex);
	run wgMonitor(adscConn_RecvWg);
	run mutexMonitor(adscConn2_conn_mu);
	run mutexMonitor(adscConn2_conn_lceMu);
	run mutexMonitor(adscConn2_mutex);
	run mutexMonitor(adscConn2_Registry_mutex);
	run wgMonitor(adscConn2_RecvWg);
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

