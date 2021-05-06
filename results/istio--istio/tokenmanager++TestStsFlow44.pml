
// https://github.com/istio/istio/blob/master/security/pkg/stsservice/tokenmanager/sts_test.go#L44
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestStsFlow440 = [1] of {int};
	run TestStsFlow44(child_TestStsFlow440)
stop_process:skip
}

proctype TestStsFlow44(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_tearDownTest2990 = [1] of {int};
	Mutexdef mockBackend_mutex;
	Mutexdef mockBackend_t_context_mu;
	Mutexdef mockBackend_t_context_match_mu;
	Mutexdef mockBackend_server_mu;
	Mutexdef mockBackend_server_nextProtoOnce_m;
	Mutexdef mockBackend_server_ErrorLog_mu;
	Mutexdef mockBackend_server_TLSConfig_mutex;
	Mutexdef stsServer_stsServer_mu;
	Mutexdef stsServer_stsServer_nextProtoOnce_m;
	Mutexdef stsServer_stsServer_ErrorLog_mu;
	Mutexdef stsServer_stsServer_TLSConfig_mutex;
	run mutexMonitor(stsServer_stsServer_TLSConfig_mutex);
	run mutexMonitor(stsServer_stsServer_ErrorLog_mu);
	run mutexMonitor(stsServer_stsServer_nextProtoOnce_m);
	run mutexMonitor(stsServer_stsServer_mu);
	run mutexMonitor(mockBackend_server_TLSConfig_mutex);
	run mutexMonitor(mockBackend_server_ErrorLog_mu);
	run mutexMonitor(mockBackend_server_nextProtoOnce_m);
	run mutexMonitor(mockBackend_server_mu);
	run mutexMonitor(mockBackend_t_context_match_mu);
	run mutexMonitor(mockBackend_t_context_mu);
	run mutexMonitor(mockBackend_mutex);
	stop_process: skip;
		run tearDownTest299(stsServer_stsServer_TLSConfig_mutex,stsServer_stsServer_ErrorLog_mu,stsServer_stsServer_nextProtoOnce_m,stsServer_stsServer_mu,mockBackend_server_TLSConfig_mutex,mockBackend_server_ErrorLog_mu,mockBackend_server_nextProtoOnce_m,mockBackend_server_mu,mockBackend_t_context_match_mu,mockBackend_t_context_mu,mockBackend_mutex,child_tearDownTest2990);
	child_tearDownTest2990?0;
	child!0
}
proctype tearDownTest299(Mutexdef stsServer_stsServer_TLSConfig_mutex;Mutexdef stsServer_stsServer_ErrorLog_mu;Mutexdef stsServer_stsServer_nextProtoOnce_m;Mutexdef stsServer_stsServer_mu;Mutexdef backend_server_TLSConfig_mutex;Mutexdef backend_server_ErrorLog_mu;Mutexdef backend_server_nextProtoOnce_m;Mutexdef backend_server_mu;Mutexdef backend_t_context_match_mu;Mutexdef backend_t_context_mu;Mutexdef backend_mutex;chan child) {
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

