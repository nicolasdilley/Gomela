
// https://github.com/labstack/echo/blob/master/context_test.go#L388
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContext_JSON_CommitsCustomResponseCode3880 = [1] of {int};
	run TestContext_JSON_CommitsCustomResponseCode388(child_TestContext_JSON_CommitsCustomResponseCode3880)
stop_process:skip
}

proctype TestContext_JSON_CommitsCustomResponseCode388(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_JSON4891 = [1] of {int};
	chan child_NewContext3290 = [1] of {int};
	Mutexdef c_lock;
	Mutexdef c_echo_AutoTLSManager_challengeMu;
	Mutexdef c_echo_AutoTLSManager_renewalMu;
	Mutexdef c_echo_AutoTLSManager_stateMu;
	Mutexdef c_echo_AutoTLSManager_client_noncesMu;
	Mutexdef c_echo_AutoTLSManager_client_cacheMu;
	Mutexdef c_echo_AutoTLSManager_clientMu;
	Mutexdef c_echo_AutoTLSManager_Client_noncesMu;
	Mutexdef c_echo_AutoTLSManager_Client_cacheMu;
	Mutexdef c_echo_TLSServer_mu;
	Mutexdef c_echo_TLSServer_nextProtoOnce_m;
	Mutexdef c_echo_TLSServer_ErrorLog_mu;
	Mutexdef c_echo_TLSServer_TLSConfig_mutex;
	Mutexdef c_echo_Server_mu;
	Mutexdef c_echo_Server_nextProtoOnce_m;
	Mutexdef c_echo_Server_ErrorLog_mu;
	Mutexdef c_echo_Server_TLSConfig_mutex;
	Mutexdef c_echo_StdLogger_mu;
	Mutexdef c_echo_startupMutex;
	Mutexdef c_response_echo_AutoTLSManager_challengeMu;
	Mutexdef c_response_echo_AutoTLSManager_renewalMu;
	Mutexdef c_response_echo_AutoTLSManager_stateMu;
	Mutexdef c_response_echo_AutoTLSManager_client_noncesMu;
	Mutexdef c_response_echo_AutoTLSManager_client_cacheMu;
	Mutexdef c_response_echo_AutoTLSManager_clientMu;
	Mutexdef c_response_echo_AutoTLSManager_Client_noncesMu;
	Mutexdef c_response_echo_AutoTLSManager_Client_cacheMu;
	Mutexdef c_response_echo_TLSServer_mu;
	Mutexdef c_response_echo_TLSServer_nextProtoOnce_m;
	Mutexdef c_response_echo_TLSServer_ErrorLog_mu;
	Mutexdef c_response_echo_TLSServer_TLSConfig_mutex;
	Mutexdef c_response_echo_Server_mu;
	Mutexdef c_response_echo_Server_nextProtoOnce_m;
	Mutexdef c_response_echo_Server_ErrorLog_mu;
	Mutexdef c_response_echo_Server_TLSConfig_mutex;
	Mutexdef c_response_echo_StdLogger_mu;
	Mutexdef c_response_echo_startupMutex;
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
	run mutexMonitor(c_response_echo_startupMutex);
	run mutexMonitor(c_response_echo_StdLogger_mu);
	run mutexMonitor(c_response_echo_Server_TLSConfig_mutex);
	run mutexMonitor(c_response_echo_Server_ErrorLog_mu);
	run mutexMonitor(c_response_echo_Server_nextProtoOnce_m);
	run mutexMonitor(c_response_echo_Server_mu);
	run mutexMonitor(c_response_echo_TLSServer_TLSConfig_mutex);
	run mutexMonitor(c_response_echo_TLSServer_ErrorLog_mu);
	run mutexMonitor(c_response_echo_TLSServer_nextProtoOnce_m);
	run mutexMonitor(c_response_echo_TLSServer_mu);
	run mutexMonitor(c_response_echo_AutoTLSManager_Client_cacheMu);
	run mutexMonitor(c_response_echo_AutoTLSManager_Client_noncesMu);
	run mutexMonitor(c_response_echo_AutoTLSManager_clientMu);
	run mutexMonitor(c_response_echo_AutoTLSManager_client_cacheMu);
	run mutexMonitor(c_response_echo_AutoTLSManager_client_noncesMu);
	run mutexMonitor(c_response_echo_AutoTLSManager_stateMu);
	run mutexMonitor(c_response_echo_AutoTLSManager_renewalMu);
	run mutexMonitor(c_response_echo_AutoTLSManager_challengeMu);
	run mutexMonitor(c_echo_startupMutex);
	run mutexMonitor(c_echo_StdLogger_mu);
	run mutexMonitor(c_echo_Server_TLSConfig_mutex);
	run mutexMonitor(c_echo_Server_ErrorLog_mu);
	run mutexMonitor(c_echo_Server_nextProtoOnce_m);
	run mutexMonitor(c_echo_Server_mu);
	run mutexMonitor(c_echo_TLSServer_TLSConfig_mutex);
	run mutexMonitor(c_echo_TLSServer_ErrorLog_mu);
	run mutexMonitor(c_echo_TLSServer_nextProtoOnce_m);
	run mutexMonitor(c_echo_TLSServer_mu);
	run mutexMonitor(c_echo_AutoTLSManager_Client_cacheMu);
	run mutexMonitor(c_echo_AutoTLSManager_Client_noncesMu);
	run mutexMonitor(c_echo_AutoTLSManager_clientMu);
	run mutexMonitor(c_echo_AutoTLSManager_client_cacheMu);
	run mutexMonitor(c_echo_AutoTLSManager_client_noncesMu);
	run mutexMonitor(c_echo_AutoTLSManager_stateMu);
	run mutexMonitor(c_echo_AutoTLSManager_renewalMu);
	run mutexMonitor(c_echo_AutoTLSManager_challengeMu);
	run mutexMonitor(c_lock);
	run NewContext329(e_startupMutex,e_StdLogger_mu,e_Server_TLSConfig_mutex,e_Server_ErrorLog_mu,e_Server_nextProtoOnce_m,e_Server_mu,e_TLSServer_TLSConfig_mutex,e_TLSServer_ErrorLog_mu,e_TLSServer_nextProtoOnce_m,e_TLSServer_mu,e_AutoTLSManager_Client_cacheMu,e_AutoTLSManager_Client_noncesMu,e_AutoTLSManager_clientMu,e_AutoTLSManager_client_cacheMu,e_AutoTLSManager_client_noncesMu,e_AutoTLSManager_stateMu,e_AutoTLSManager_renewalMu,e_AutoTLSManager_challengeMu,child_NewContext3290);
	child_NewContext3290?0;
	run JSON489(c_response_echo_startupMutex,c_response_echo_StdLogger_mu,c_response_echo_Server_TLSConfig_mutex,c_response_echo_Server_ErrorLog_mu,c_response_echo_Server_nextProtoOnce_m,c_response_echo_Server_mu,c_response_echo_TLSServer_TLSConfig_mutex,c_response_echo_TLSServer_ErrorLog_mu,c_response_echo_TLSServer_nextProtoOnce_m,c_response_echo_TLSServer_mu,c_response_echo_AutoTLSManager_Client_cacheMu,c_response_echo_AutoTLSManager_Client_noncesMu,c_response_echo_AutoTLSManager_clientMu,c_response_echo_AutoTLSManager_client_cacheMu,c_response_echo_AutoTLSManager_client_noncesMu,c_response_echo_AutoTLSManager_stateMu,c_response_echo_AutoTLSManager_renewalMu,c_response_echo_AutoTLSManager_challengeMu,c_echo_startupMutex,c_echo_StdLogger_mu,c_echo_Server_TLSConfig_mutex,c_echo_Server_ErrorLog_mu,c_echo_Server_nextProtoOnce_m,c_echo_Server_mu,c_echo_TLSServer_TLSConfig_mutex,c_echo_TLSServer_ErrorLog_mu,c_echo_TLSServer_nextProtoOnce_m,c_echo_TLSServer_mu,c_echo_AutoTLSManager_Client_cacheMu,c_echo_AutoTLSManager_Client_noncesMu,c_echo_AutoTLSManager_clientMu,c_echo_AutoTLSManager_client_cacheMu,c_echo_AutoTLSManager_client_noncesMu,c_echo_AutoTLSManager_stateMu,c_echo_AutoTLSManager_renewalMu,c_echo_AutoTLSManager_challengeMu,c_lock,child_JSON4891);
	child_JSON4891?0;
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
proctype JSON489(Mutexdef c_response_echo_startupMutex;Mutexdef c_response_echo_StdLogger_mu;Mutexdef c_response_echo_Server_TLSConfig_mutex;Mutexdef c_response_echo_Server_ErrorLog_mu;Mutexdef c_response_echo_Server_nextProtoOnce_m;Mutexdef c_response_echo_Server_mu;Mutexdef c_response_echo_TLSServer_TLSConfig_mutex;Mutexdef c_response_echo_TLSServer_ErrorLog_mu;Mutexdef c_response_echo_TLSServer_nextProtoOnce_m;Mutexdef c_response_echo_TLSServer_mu;Mutexdef c_response_echo_AutoTLSManager_Client_cacheMu;Mutexdef c_response_echo_AutoTLSManager_Client_noncesMu;Mutexdef c_response_echo_AutoTLSManager_clientMu;Mutexdef c_response_echo_AutoTLSManager_client_cacheMu;Mutexdef c_response_echo_AutoTLSManager_client_noncesMu;Mutexdef c_response_echo_AutoTLSManager_stateMu;Mutexdef c_response_echo_AutoTLSManager_renewalMu;Mutexdef c_response_echo_AutoTLSManager_challengeMu;Mutexdef c_echo_startupMutex;Mutexdef c_echo_StdLogger_mu;Mutexdef c_echo_Server_TLSConfig_mutex;Mutexdef c_echo_Server_ErrorLog_mu;Mutexdef c_echo_Server_nextProtoOnce_m;Mutexdef c_echo_Server_mu;Mutexdef c_echo_TLSServer_TLSConfig_mutex;Mutexdef c_echo_TLSServer_ErrorLog_mu;Mutexdef c_echo_TLSServer_nextProtoOnce_m;Mutexdef c_echo_TLSServer_mu;Mutexdef c_echo_AutoTLSManager_Client_cacheMu;Mutexdef c_echo_AutoTLSManager_Client_noncesMu;Mutexdef c_echo_AutoTLSManager_clientMu;Mutexdef c_echo_AutoTLSManager_client_cacheMu;Mutexdef c_echo_AutoTLSManager_client_noncesMu;Mutexdef c_echo_AutoTLSManager_stateMu;Mutexdef c_echo_AutoTLSManager_renewalMu;Mutexdef c_echo_AutoTLSManager_challengeMu;Mutexdef c_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_json4791 = [1] of {int};
	run json479(c_response_echo_startupMutex,c_response_echo_StdLogger_mu,c_response_echo_Server_TLSConfig_mutex,c_response_echo_Server_ErrorLog_mu,c_response_echo_Server_nextProtoOnce_m,c_response_echo_Server_mu,c_response_echo_TLSServer_TLSConfig_mutex,c_response_echo_TLSServer_ErrorLog_mu,c_response_echo_TLSServer_nextProtoOnce_m,c_response_echo_TLSServer_mu,c_response_echo_AutoTLSManager_Client_cacheMu,c_response_echo_AutoTLSManager_Client_noncesMu,c_response_echo_AutoTLSManager_clientMu,c_response_echo_AutoTLSManager_client_cacheMu,c_response_echo_AutoTLSManager_client_noncesMu,c_response_echo_AutoTLSManager_stateMu,c_response_echo_AutoTLSManager_renewalMu,c_response_echo_AutoTLSManager_challengeMu,c_echo_startupMutex,c_echo_StdLogger_mu,c_echo_Server_TLSConfig_mutex,c_echo_Server_ErrorLog_mu,c_echo_Server_nextProtoOnce_m,c_echo_Server_mu,c_echo_TLSServer_TLSConfig_mutex,c_echo_TLSServer_ErrorLog_mu,c_echo_TLSServer_nextProtoOnce_m,c_echo_TLSServer_mu,c_echo_AutoTLSManager_Client_cacheMu,c_echo_AutoTLSManager_Client_noncesMu,c_echo_AutoTLSManager_clientMu,c_echo_AutoTLSManager_client_cacheMu,c_echo_AutoTLSManager_client_noncesMu,c_echo_AutoTLSManager_stateMu,c_echo_AutoTLSManager_renewalMu,c_echo_AutoTLSManager_challengeMu,c_lock,child_json4791);
	child_json4791?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype json479(Mutexdef c_response_echo_startupMutex;Mutexdef c_response_echo_StdLogger_mu;Mutexdef c_response_echo_Server_TLSConfig_mutex;Mutexdef c_response_echo_Server_ErrorLog_mu;Mutexdef c_response_echo_Server_nextProtoOnce_m;Mutexdef c_response_echo_Server_mu;Mutexdef c_response_echo_TLSServer_TLSConfig_mutex;Mutexdef c_response_echo_TLSServer_ErrorLog_mu;Mutexdef c_response_echo_TLSServer_nextProtoOnce_m;Mutexdef c_response_echo_TLSServer_mu;Mutexdef c_response_echo_AutoTLSManager_Client_cacheMu;Mutexdef c_response_echo_AutoTLSManager_Client_noncesMu;Mutexdef c_response_echo_AutoTLSManager_clientMu;Mutexdef c_response_echo_AutoTLSManager_client_cacheMu;Mutexdef c_response_echo_AutoTLSManager_client_noncesMu;Mutexdef c_response_echo_AutoTLSManager_stateMu;Mutexdef c_response_echo_AutoTLSManager_renewalMu;Mutexdef c_response_echo_AutoTLSManager_challengeMu;Mutexdef c_echo_startupMutex;Mutexdef c_echo_StdLogger_mu;Mutexdef c_echo_Server_TLSConfig_mutex;Mutexdef c_echo_Server_ErrorLog_mu;Mutexdef c_echo_Server_nextProtoOnce_m;Mutexdef c_echo_Server_mu;Mutexdef c_echo_TLSServer_TLSConfig_mutex;Mutexdef c_echo_TLSServer_ErrorLog_mu;Mutexdef c_echo_TLSServer_nextProtoOnce_m;Mutexdef c_echo_TLSServer_mu;Mutexdef c_echo_AutoTLSManager_Client_cacheMu;Mutexdef c_echo_AutoTLSManager_Client_noncesMu;Mutexdef c_echo_AutoTLSManager_clientMu;Mutexdef c_echo_AutoTLSManager_client_cacheMu;Mutexdef c_echo_AutoTLSManager_client_noncesMu;Mutexdef c_echo_AutoTLSManager_stateMu;Mutexdef c_echo_AutoTLSManager_renewalMu;Mutexdef c_echo_AutoTLSManager_challengeMu;Mutexdef c_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_writeContentType2201 = [1] of {int};
	run writeContentType220(c_response_echo_startupMutex,c_response_echo_StdLogger_mu,c_response_echo_Server_TLSConfig_mutex,c_response_echo_Server_ErrorLog_mu,c_response_echo_Server_nextProtoOnce_m,c_response_echo_Server_mu,c_response_echo_TLSServer_TLSConfig_mutex,c_response_echo_TLSServer_ErrorLog_mu,c_response_echo_TLSServer_nextProtoOnce_m,c_response_echo_TLSServer_mu,c_response_echo_AutoTLSManager_Client_cacheMu,c_response_echo_AutoTLSManager_Client_noncesMu,c_response_echo_AutoTLSManager_clientMu,c_response_echo_AutoTLSManager_client_cacheMu,c_response_echo_AutoTLSManager_client_noncesMu,c_response_echo_AutoTLSManager_stateMu,c_response_echo_AutoTLSManager_renewalMu,c_response_echo_AutoTLSManager_challengeMu,c_echo_startupMutex,c_echo_StdLogger_mu,c_echo_Server_TLSConfig_mutex,c_echo_Server_ErrorLog_mu,c_echo_Server_nextProtoOnce_m,c_echo_Server_mu,c_echo_TLSServer_TLSConfig_mutex,c_echo_TLSServer_ErrorLog_mu,c_echo_TLSServer_nextProtoOnce_m,c_echo_TLSServer_mu,c_echo_AutoTLSManager_Client_cacheMu,c_echo_AutoTLSManager_Client_noncesMu,c_echo_AutoTLSManager_clientMu,c_echo_AutoTLSManager_client_cacheMu,c_echo_AutoTLSManager_client_noncesMu,c_echo_AutoTLSManager_stateMu,c_echo_AutoTLSManager_renewalMu,c_echo_AutoTLSManager_challengeMu,c_lock,child_writeContentType2201);
	child_writeContentType2201?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype writeContentType220(Mutexdef c_response_echo_startupMutex;Mutexdef c_response_echo_StdLogger_mu;Mutexdef c_response_echo_Server_TLSConfig_mutex;Mutexdef c_response_echo_Server_ErrorLog_mu;Mutexdef c_response_echo_Server_nextProtoOnce_m;Mutexdef c_response_echo_Server_mu;Mutexdef c_response_echo_TLSServer_TLSConfig_mutex;Mutexdef c_response_echo_TLSServer_ErrorLog_mu;Mutexdef c_response_echo_TLSServer_nextProtoOnce_m;Mutexdef c_response_echo_TLSServer_mu;Mutexdef c_response_echo_AutoTLSManager_Client_cacheMu;Mutexdef c_response_echo_AutoTLSManager_Client_noncesMu;Mutexdef c_response_echo_AutoTLSManager_clientMu;Mutexdef c_response_echo_AutoTLSManager_client_cacheMu;Mutexdef c_response_echo_AutoTLSManager_client_noncesMu;Mutexdef c_response_echo_AutoTLSManager_stateMu;Mutexdef c_response_echo_AutoTLSManager_renewalMu;Mutexdef c_response_echo_AutoTLSManager_challengeMu;Mutexdef c_echo_startupMutex;Mutexdef c_echo_StdLogger_mu;Mutexdef c_echo_Server_TLSConfig_mutex;Mutexdef c_echo_Server_ErrorLog_mu;Mutexdef c_echo_Server_nextProtoOnce_m;Mutexdef c_echo_Server_mu;Mutexdef c_echo_TLSServer_TLSConfig_mutex;Mutexdef c_echo_TLSServer_ErrorLog_mu;Mutexdef c_echo_TLSServer_nextProtoOnce_m;Mutexdef c_echo_TLSServer_mu;Mutexdef c_echo_AutoTLSManager_Client_cacheMu;Mutexdef c_echo_AutoTLSManager_Client_noncesMu;Mutexdef c_echo_AutoTLSManager_clientMu;Mutexdef c_echo_AutoTLSManager_client_cacheMu;Mutexdef c_echo_AutoTLSManager_client_noncesMu;Mutexdef c_echo_AutoTLSManager_stateMu;Mutexdef c_echo_AutoTLSManager_renewalMu;Mutexdef c_echo_AutoTLSManager_challengeMu;Mutexdef c_lock;chan child) {
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

