
// https://github.com/labstack/echo/blob/master/response_test.go#L31
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestResponse_Write_FallsBackToDefaultStatus310 = [1] of {int};
	run TestResponse_Write_FallsBackToDefaultStatus31(child_TestResponse_Write_FallsBackToDefaultStatus310)
stop_process:skip
}

proctype TestResponse_Write_FallsBackToDefaultStatus31(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Write680 = [1] of {int};
	Mutexdef res_echo_AutoTLSManager_challengeMu;
	Mutexdef res_echo_AutoTLSManager_renewalMu;
	Mutexdef res_echo_AutoTLSManager_stateMu;
	Mutexdef res_echo_AutoTLSManager_client_noncesMu;
	Mutexdef res_echo_AutoTLSManager_client_cacheMu;
	Mutexdef res_echo_AutoTLSManager_clientMu;
	Mutexdef res_echo_AutoTLSManager_Client_noncesMu;
	Mutexdef res_echo_AutoTLSManager_Client_cacheMu;
	Mutexdef res_echo_TLSServer_mu;
	Mutexdef res_echo_TLSServer_nextProtoOnce_m;
	Mutexdef res_echo_TLSServer_ErrorLog_mu;
	Mutexdef res_echo_TLSServer_TLSConfig_mutex;
	Mutexdef res_echo_Server_mu;
	Mutexdef res_echo_Server_nextProtoOnce_m;
	Mutexdef res_echo_Server_ErrorLog_mu;
	Mutexdef res_echo_Server_TLSConfig_mutex;
	Mutexdef res_echo_StdLogger_mu;
	Mutexdef res_echo_startupMutex;
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
	run mutexMonitor(res_echo_startupMutex);
	run mutexMonitor(res_echo_StdLogger_mu);
	run mutexMonitor(res_echo_Server_TLSConfig_mutex);
	run mutexMonitor(res_echo_Server_ErrorLog_mu);
	run mutexMonitor(res_echo_Server_nextProtoOnce_m);
	run mutexMonitor(res_echo_Server_mu);
	run mutexMonitor(res_echo_TLSServer_TLSConfig_mutex);
	run mutexMonitor(res_echo_TLSServer_ErrorLog_mu);
	run mutexMonitor(res_echo_TLSServer_nextProtoOnce_m);
	run mutexMonitor(res_echo_TLSServer_mu);
	run mutexMonitor(res_echo_AutoTLSManager_Client_cacheMu);
	run mutexMonitor(res_echo_AutoTLSManager_Client_noncesMu);
	run mutexMonitor(res_echo_AutoTLSManager_clientMu);
	run mutexMonitor(res_echo_AutoTLSManager_client_cacheMu);
	run mutexMonitor(res_echo_AutoTLSManager_client_noncesMu);
	run mutexMonitor(res_echo_AutoTLSManager_stateMu);
	run mutexMonitor(res_echo_AutoTLSManager_renewalMu);
	run mutexMonitor(res_echo_AutoTLSManager_challengeMu);
	run Write68(res_echo_startupMutex,res_echo_StdLogger_mu,res_echo_Server_TLSConfig_mutex,res_echo_Server_ErrorLog_mu,res_echo_Server_nextProtoOnce_m,res_echo_Server_mu,res_echo_TLSServer_TLSConfig_mutex,res_echo_TLSServer_ErrorLog_mu,res_echo_TLSServer_nextProtoOnce_m,res_echo_TLSServer_mu,res_echo_AutoTLSManager_Client_cacheMu,res_echo_AutoTLSManager_Client_noncesMu,res_echo_AutoTLSManager_clientMu,res_echo_AutoTLSManager_client_cacheMu,res_echo_AutoTLSManager_client_noncesMu,res_echo_AutoTLSManager_stateMu,res_echo_AutoTLSManager_renewalMu,res_echo_AutoTLSManager_challengeMu,child_Write680);
	child_Write680?0;
	stop_process: skip;
	child!0
}
proctype Write68(Mutexdef r_echo_startupMutex;Mutexdef r_echo_StdLogger_mu;Mutexdef r_echo_Server_TLSConfig_mutex;Mutexdef r_echo_Server_ErrorLog_mu;Mutexdef r_echo_Server_nextProtoOnce_m;Mutexdef r_echo_Server_mu;Mutexdef r_echo_TLSServer_TLSConfig_mutex;Mutexdef r_echo_TLSServer_ErrorLog_mu;Mutexdef r_echo_TLSServer_nextProtoOnce_m;Mutexdef r_echo_TLSServer_mu;Mutexdef r_echo_AutoTLSManager_Client_cacheMu;Mutexdef r_echo_AutoTLSManager_Client_noncesMu;Mutexdef r_echo_AutoTLSManager_clientMu;Mutexdef r_echo_AutoTLSManager_client_cacheMu;Mutexdef r_echo_AutoTLSManager_client_noncesMu;Mutexdef r_echo_AutoTLSManager_stateMu;Mutexdef r_echo_AutoTLSManager_renewalMu;Mutexdef r_echo_AutoTLSManager_challengeMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_WriteHeader540 = [1] of {int};
	

	if
	:: true -> 
		run WriteHeader54(r_echo_startupMutex,r_echo_StdLogger_mu,r_echo_Server_TLSConfig_mutex,r_echo_Server_ErrorLog_mu,r_echo_Server_nextProtoOnce_m,r_echo_Server_mu,r_echo_TLSServer_TLSConfig_mutex,r_echo_TLSServer_ErrorLog_mu,r_echo_TLSServer_nextProtoOnce_m,r_echo_TLSServer_mu,r_echo_AutoTLSManager_Client_cacheMu,r_echo_AutoTLSManager_Client_noncesMu,r_echo_AutoTLSManager_clientMu,r_echo_AutoTLSManager_client_cacheMu,r_echo_AutoTLSManager_client_noncesMu,r_echo_AutoTLSManager_stateMu,r_echo_AutoTLSManager_renewalMu,r_echo_AutoTLSManager_challengeMu,child_WriteHeader540);
		child_WriteHeader540?0
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype WriteHeader54(Mutexdef r_echo_startupMutex;Mutexdef r_echo_StdLogger_mu;Mutexdef r_echo_Server_TLSConfig_mutex;Mutexdef r_echo_Server_ErrorLog_mu;Mutexdef r_echo_Server_nextProtoOnce_m;Mutexdef r_echo_Server_mu;Mutexdef r_echo_TLSServer_TLSConfig_mutex;Mutexdef r_echo_TLSServer_ErrorLog_mu;Mutexdef r_echo_TLSServer_nextProtoOnce_m;Mutexdef r_echo_TLSServer_mu;Mutexdef r_echo_AutoTLSManager_Client_cacheMu;Mutexdef r_echo_AutoTLSManager_Client_noncesMu;Mutexdef r_echo_AutoTLSManager_clientMu;Mutexdef r_echo_AutoTLSManager_client_cacheMu;Mutexdef r_echo_AutoTLSManager_client_noncesMu;Mutexdef r_echo_AutoTLSManager_stateMu;Mutexdef r_echo_AutoTLSManager_renewalMu;Mutexdef r_echo_AutoTLSManager_challengeMu;chan child) {
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

