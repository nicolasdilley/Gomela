
// https://github.com/labstack/echo/blob/master/binder_test.go#L131
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFormFieldBinder1310 = [1] of {int};
	run TestFormFieldBinder131(child_TestFormFieldBinder1310)
stop_process:skip
}

proctype TestFormFieldBinder131(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewContext3290 = [1] of {int};
	Mutexdef e_AutoTLSManager_challengeMu;
	Mutexdef e_AutoTLSManager_renewalMu;
	Mutexdef e_AutoTLSManager_stateMu;
	Mutexdef e_AutoTLSManager_client_noncesMu;
	Mutexdef e_AutoTLSManager_client_cacheMu;
	Mutexdef e_AutoTLSManager_clientMu;
	Mutexdef e_AutoTLSManager_Client_noncesMu;
	Mutexdef e_AutoTLSManager_Client_cacheMu;
	Mutexdef e_TLSServer_mu;
	Mutexdef e_TLSServer_nextProtoOnce_m;
	Mutexdef e_TLSServer_ErrorLog_mu;
	Mutexdef e_TLSServer_TLSConfig_mutex;
	Mutexdef e_Server_mu;
	Mutexdef e_Server_nextProtoOnce_m;
	Mutexdef e_Server_ErrorLog_mu;
	Mutexdef e_Server_TLSConfig_mutex;
	Mutexdef e_StdLogger_mu;
	Mutexdef e_startupMutex;
	run mutexMonitor(e_startupMutex);
	run mutexMonitor(e_StdLogger_mu);
	run mutexMonitor(e_Server_TLSConfig_mutex);
	run mutexMonitor(e_Server_ErrorLog_mu);
	run mutexMonitor(e_Server_nextProtoOnce_m);
	run mutexMonitor(e_Server_mu);
	run mutexMonitor(e_TLSServer_TLSConfig_mutex);
	run mutexMonitor(e_TLSServer_ErrorLog_mu);
	run mutexMonitor(e_TLSServer_nextProtoOnce_m);
	run mutexMonitor(e_TLSServer_mu);
	run mutexMonitor(e_AutoTLSManager_Client_cacheMu);
	run mutexMonitor(e_AutoTLSManager_Client_noncesMu);
	run mutexMonitor(e_AutoTLSManager_clientMu);
	run mutexMonitor(e_AutoTLSManager_client_cacheMu);
	run mutexMonitor(e_AutoTLSManager_client_noncesMu);
	run mutexMonitor(e_AutoTLSManager_stateMu);
	run mutexMonitor(e_AutoTLSManager_renewalMu);
	run mutexMonitor(e_AutoTLSManager_challengeMu);
	run NewContext329(e_startupMutex,e_StdLogger_mu,e_Server_TLSConfig_mutex,e_Server_ErrorLog_mu,e_Server_nextProtoOnce_m,e_Server_mu,e_TLSServer_TLSConfig_mutex,e_TLSServer_ErrorLog_mu,e_TLSServer_nextProtoOnce_m,e_TLSServer_mu,e_AutoTLSManager_Client_cacheMu,e_AutoTLSManager_Client_noncesMu,e_AutoTLSManager_clientMu,e_AutoTLSManager_client_cacheMu,e_AutoTLSManager_client_noncesMu,e_AutoTLSManager_stateMu,e_AutoTLSManager_renewalMu,e_AutoTLSManager_challengeMu,child_NewContext3290);
	child_NewContext3290?0;
	stop_process: skip;
	child!0
}
proctype NewContext329(Mutexdef e_startupMutex;Mutexdef e_StdLogger_mu;Mutexdef e_Server_TLSConfig_mutex;Mutexdef e_Server_ErrorLog_mu;Mutexdef e_Server_nextProtoOnce_m;Mutexdef e_Server_mu;Mutexdef e_TLSServer_TLSConfig_mutex;Mutexdef e_TLSServer_ErrorLog_mu;Mutexdef e_TLSServer_nextProtoOnce_m;Mutexdef e_TLSServer_mu;Mutexdef e_AutoTLSManager_Client_cacheMu;Mutexdef e_AutoTLSManager_Client_noncesMu;Mutexdef e_AutoTLSManager_clientMu;Mutexdef e_AutoTLSManager_client_cacheMu;Mutexdef e_AutoTLSManager_client_noncesMu;Mutexdef e_AutoTLSManager_stateMu;Mutexdef e_AutoTLSManager_renewalMu;Mutexdef e_AutoTLSManager_challengeMu;chan child) {
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

