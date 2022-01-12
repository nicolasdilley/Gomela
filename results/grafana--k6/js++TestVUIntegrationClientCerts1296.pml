// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grafana/k6/blob//js/runner_test.go#L1296
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestVUIntegrationClientCerts12960 = [1] of {int};
	run TestVUIntegrationClientCerts1296(child_TestVUIntegrationClientCerts12960);
	run receiver(child_TestVUIntegrationClientCerts12960)
stop_process:skip
}

proctype TestVUIntegrationClientCerts1296(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RegisterBuiltinMetrics1021 = [1] of {int};
	Mutexdef registry_l;
	chan child_AnonymousTestVUIntegrationClientCerts135513490 = [1] of {int};
	Mutexdef srv_mu;
	Mutexdef srv_nextProtoOnce_m;
	Mutexdef srv_ErrorLog_mu;
	Mutexdef srv_TLSConfig_mutex;
	int var_runners = -2; // opt var_runners
	run mutexMonitor(srv_TLSConfig_mutex);
	run mutexMonitor(srv_ErrorLog_mu);
	run mutexMonitor(srv_nextProtoOnce_m);
	run mutexMonitor(srv_mu);
	run AnonymousTestVUIntegrationClientCerts13551349(srv_TLSConfig_mutex,srv_ErrorLog_mu,srv_nextProtoOnce_m,srv_mu,child_AnonymousTestVUIntegrationClientCerts135513490);
	run receiver(child_AnonymousTestVUIntegrationClientCerts135513490);
	run mutexMonitor(registry_l);
	run RegisterBuiltinMetrics102(registry_l,child_RegisterBuiltinMetrics1021);
	child_RegisterBuiltinMetrics1021?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestVUIntegrationClientCerts13551349(Mutexdef srv_TLSConfig_mutex;Mutexdef srv_ErrorLog_mu;Mutexdef srv_nextProtoOnce_m;Mutexdef srv_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

