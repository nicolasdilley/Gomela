#define not_found_1694  -2
#define not_found_1695  -2
#define not_found_1696  -2

// https://github.com/labstack/echo/blob/master/router_test.go#L1689
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRouterParamNames16890 = [1] of {int};
	run TestRouterParamNames1689(child_TestRouterParamNames16890)
stop_process:skip
}

proctype TestRouterParamNames1689(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Add652 = [1] of {int};
	chan child_Add651 = [1] of {int};
	chan child_Add650 = [1] of {int};
	Mutexdef r_echo_AutoTLSManager_challengeMu;
	Mutexdef r_echo_AutoTLSManager_renewalMu;
	Mutexdef r_echo_AutoTLSManager_stateMu;
	Mutexdef r_echo_AutoTLSManager_client_noncesMu;
	Mutexdef r_echo_AutoTLSManager_client_cacheMu;
	Mutexdef r_echo_AutoTLSManager_clientMu;
	Mutexdef r_echo_AutoTLSManager_Client_noncesMu;
	Mutexdef r_echo_AutoTLSManager_Client_cacheMu;
	Mutexdef r_echo_TLSServer_mu;
	Mutexdef r_echo_TLSServer_nextProtoOnce_m;
	Mutexdef r_echo_TLSServer_ErrorLog_mu;
	Mutexdef r_echo_TLSServer_TLSConfig_mutex;
	Mutexdef r_echo_Server_mu;
	Mutexdef r_echo_Server_nextProtoOnce_m;
	Mutexdef r_echo_Server_ErrorLog_mu;
	Mutexdef r_echo_Server_TLSConfig_mutex;
	Mutexdef r_echo_StdLogger_mu;
	Mutexdef r_echo_startupMutex;
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
	run mutexMonitor(r_echo_startupMutex);
	run mutexMonitor(r_echo_StdLogger_mu);
	run mutexMonitor(r_echo_Server_TLSConfig_mutex);
	run mutexMonitor(r_echo_Server_ErrorLog_mu);
	run mutexMonitor(r_echo_Server_nextProtoOnce_m);
	run mutexMonitor(r_echo_Server_mu);
	run mutexMonitor(r_echo_TLSServer_TLSConfig_mutex);
	run mutexMonitor(r_echo_TLSServer_ErrorLog_mu);
	run mutexMonitor(r_echo_TLSServer_nextProtoOnce_m);
	run mutexMonitor(r_echo_TLSServer_mu);
	run mutexMonitor(r_echo_AutoTLSManager_Client_cacheMu);
	run mutexMonitor(r_echo_AutoTLSManager_Client_noncesMu);
	run mutexMonitor(r_echo_AutoTLSManager_clientMu);
	run mutexMonitor(r_echo_AutoTLSManager_client_cacheMu);
	run mutexMonitor(r_echo_AutoTLSManager_client_noncesMu);
	run mutexMonitor(r_echo_AutoTLSManager_stateMu);
	run mutexMonitor(r_echo_AutoTLSManager_renewalMu);
	run mutexMonitor(r_echo_AutoTLSManager_challengeMu);
	run Add65(r_echo_startupMutex,r_echo_StdLogger_mu,r_echo_Server_TLSConfig_mutex,r_echo_Server_ErrorLog_mu,r_echo_Server_nextProtoOnce_m,r_echo_Server_mu,r_echo_TLSServer_TLSConfig_mutex,r_echo_TLSServer_ErrorLog_mu,r_echo_TLSServer_nextProtoOnce_m,r_echo_TLSServer_mu,r_echo_AutoTLSManager_Client_cacheMu,r_echo_AutoTLSManager_Client_noncesMu,r_echo_AutoTLSManager_clientMu,r_echo_AutoTLSManager_client_cacheMu,r_echo_AutoTLSManager_client_noncesMu,r_echo_AutoTLSManager_stateMu,r_echo_AutoTLSManager_renewalMu,r_echo_AutoTLSManager_challengeMu,not_found_1694,child_Add650);
	child_Add650?0;
	run Add65(r_echo_startupMutex,r_echo_StdLogger_mu,r_echo_Server_TLSConfig_mutex,r_echo_Server_ErrorLog_mu,r_echo_Server_nextProtoOnce_m,r_echo_Server_mu,r_echo_TLSServer_TLSConfig_mutex,r_echo_TLSServer_ErrorLog_mu,r_echo_TLSServer_nextProtoOnce_m,r_echo_TLSServer_mu,r_echo_AutoTLSManager_Client_cacheMu,r_echo_AutoTLSManager_Client_noncesMu,r_echo_AutoTLSManager_clientMu,r_echo_AutoTLSManager_client_cacheMu,r_echo_AutoTLSManager_client_noncesMu,r_echo_AutoTLSManager_stateMu,r_echo_AutoTLSManager_renewalMu,r_echo_AutoTLSManager_challengeMu,not_found_1695,child_Add651);
	child_Add651?0;
	run Add65(r_echo_startupMutex,r_echo_StdLogger_mu,r_echo_Server_TLSConfig_mutex,r_echo_Server_ErrorLog_mu,r_echo_Server_nextProtoOnce_m,r_echo_Server_mu,r_echo_TLSServer_TLSConfig_mutex,r_echo_TLSServer_ErrorLog_mu,r_echo_TLSServer_nextProtoOnce_m,r_echo_TLSServer_mu,r_echo_AutoTLSManager_Client_cacheMu,r_echo_AutoTLSManager_Client_noncesMu,r_echo_AutoTLSManager_clientMu,r_echo_AutoTLSManager_client_cacheMu,r_echo_AutoTLSManager_client_noncesMu,r_echo_AutoTLSManager_stateMu,r_echo_AutoTLSManager_renewalMu,r_echo_AutoTLSManager_challengeMu,not_found_1696,child_Add652);
	child_Add652?0;
	stop_process: skip;
	child!0
}
proctype Add65(Mutexdef r_echo_startupMutex;Mutexdef r_echo_StdLogger_mu;Mutexdef r_echo_Server_TLSConfig_mutex;Mutexdef r_echo_Server_ErrorLog_mu;Mutexdef r_echo_Server_nextProtoOnce_m;Mutexdef r_echo_Server_mu;Mutexdef r_echo_TLSServer_TLSConfig_mutex;Mutexdef r_echo_TLSServer_ErrorLog_mu;Mutexdef r_echo_TLSServer_nextProtoOnce_m;Mutexdef r_echo_TLSServer_mu;Mutexdef r_echo_AutoTLSManager_Client_cacheMu;Mutexdef r_echo_AutoTLSManager_Client_noncesMu;Mutexdef r_echo_AutoTLSManager_clientMu;Mutexdef r_echo_AutoTLSManager_client_cacheMu;Mutexdef r_echo_AutoTLSManager_client_noncesMu;Mutexdef r_echo_AutoTLSManager_stateMu;Mutexdef r_echo_AutoTLSManager_renewalMu;Mutexdef r_echo_AutoTLSManager_challengeMu;int path;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_insert10310 = [1] of {int};
	chan child_insert1036 = [1] of {int};
	chan child_insert1037 = [1] of {int};
	chan child_insert1035 = [1] of {int};
	chan child_insert1039 = [1] of {int};
	chan child_insert1038 = [1] of {int};
	chan child_insert1031 = [1] of {int};
	chan child_insert1032 = [1] of {int};
	chan child_insert1030 = [1] of {int};
	chan child_insert1034 = [1] of {int};
	chan child_insert1033 = [1] of {int};
	int lcpIndex = -2;
	

	if
	:: 0 != -2 && lcpIndex-1 != -3 -> 
				for(i : 0.. lcpIndex-1) {
			for113: skip;
			

			if
			:: true -> 
				run insert103(r_echo_startupMutex,r_echo_StdLogger_mu,r_echo_Server_TLSConfig_mutex,r_echo_Server_ErrorLog_mu,r_echo_Server_nextProtoOnce_m,r_echo_Server_mu,r_echo_TLSServer_TLSConfig_mutex,r_echo_TLSServer_ErrorLog_mu,r_echo_TLSServer_nextProtoOnce_m,r_echo_TLSServer_mu,r_echo_AutoTLSManager_Client_cacheMu,r_echo_AutoTLSManager_Client_noncesMu,r_echo_AutoTLSManager_clientMu,r_echo_AutoTLSManager_client_cacheMu,r_echo_AutoTLSManager_client_noncesMu,r_echo_AutoTLSManager_stateMu,r_echo_AutoTLSManager_renewalMu,r_echo_AutoTLSManager_challengeMu,child_insert1035);
				child_insert1035?0;
				

				if
				:: true -> 
					run insert103(r_echo_startupMutex,r_echo_StdLogger_mu,r_echo_Server_TLSConfig_mutex,r_echo_Server_ErrorLog_mu,r_echo_Server_nextProtoOnce_m,r_echo_Server_mu,r_echo_TLSServer_TLSConfig_mutex,r_echo_TLSServer_ErrorLog_mu,r_echo_TLSServer_nextProtoOnce_m,r_echo_TLSServer_mu,r_echo_AutoTLSManager_Client_cacheMu,r_echo_AutoTLSManager_Client_noncesMu,r_echo_AutoTLSManager_clientMu,r_echo_AutoTLSManager_client_cacheMu,r_echo_AutoTLSManager_client_noncesMu,r_echo_AutoTLSManager_stateMu,r_echo_AutoTLSManager_renewalMu,r_echo_AutoTLSManager_challengeMu,child_insert1036);
					child_insert1036?0
				:: true -> 
					run insert103(r_echo_startupMutex,r_echo_StdLogger_mu,r_echo_Server_TLSConfig_mutex,r_echo_Server_ErrorLog_mu,r_echo_Server_nextProtoOnce_m,r_echo_Server_mu,r_echo_TLSServer_TLSConfig_mutex,r_echo_TLSServer_ErrorLog_mu,r_echo_TLSServer_nextProtoOnce_m,r_echo_TLSServer_mu,r_echo_AutoTLSManager_Client_cacheMu,r_echo_AutoTLSManager_Client_noncesMu,r_echo_AutoTLSManager_clientMu,r_echo_AutoTLSManager_client_cacheMu,r_echo_AutoTLSManager_client_noncesMu,r_echo_AutoTLSManager_stateMu,r_echo_AutoTLSManager_renewalMu,r_echo_AutoTLSManager_challengeMu,child_insert1037);
					child_insert1037?0
				fi
			:: true -> 
				

				if
				:: true -> 
					run insert103(r_echo_startupMutex,r_echo_StdLogger_mu,r_echo_Server_TLSConfig_mutex,r_echo_Server_ErrorLog_mu,r_echo_Server_nextProtoOnce_m,r_echo_Server_mu,r_echo_TLSServer_TLSConfig_mutex,r_echo_TLSServer_ErrorLog_mu,r_echo_TLSServer_nextProtoOnce_m,r_echo_TLSServer_mu,r_echo_AutoTLSManager_Client_cacheMu,r_echo_AutoTLSManager_Client_noncesMu,r_echo_AutoTLSManager_clientMu,r_echo_AutoTLSManager_client_cacheMu,r_echo_AutoTLSManager_client_noncesMu,r_echo_AutoTLSManager_stateMu,r_echo_AutoTLSManager_renewalMu,r_echo_AutoTLSManager_challengeMu,child_insert1038);
					child_insert1038?0;
					run insert103(r_echo_startupMutex,r_echo_StdLogger_mu,r_echo_Server_TLSConfig_mutex,r_echo_Server_ErrorLog_mu,r_echo_Server_nextProtoOnce_m,r_echo_Server_mu,r_echo_TLSServer_TLSConfig_mutex,r_echo_TLSServer_ErrorLog_mu,r_echo_TLSServer_nextProtoOnce_m,r_echo_TLSServer_mu,r_echo_AutoTLSManager_Client_cacheMu,r_echo_AutoTLSManager_Client_noncesMu,r_echo_AutoTLSManager_clientMu,r_echo_AutoTLSManager_client_cacheMu,r_echo_AutoTLSManager_client_noncesMu,r_echo_AutoTLSManager_stateMu,r_echo_AutoTLSManager_renewalMu,r_echo_AutoTLSManager_challengeMu,child_insert1039);
					child_insert1039?0
				:: true;
				fi
			fi;
			for113_end: skip
		};
		for113_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: true -> 
				run insert103(r_echo_startupMutex,r_echo_StdLogger_mu,r_echo_Server_TLSConfig_mutex,r_echo_Server_ErrorLog_mu,r_echo_Server_nextProtoOnce_m,r_echo_Server_mu,r_echo_TLSServer_TLSConfig_mutex,r_echo_TLSServer_ErrorLog_mu,r_echo_TLSServer_nextProtoOnce_m,r_echo_TLSServer_mu,r_echo_AutoTLSManager_Client_cacheMu,r_echo_AutoTLSManager_Client_noncesMu,r_echo_AutoTLSManager_clientMu,r_echo_AutoTLSManager_client_cacheMu,r_echo_AutoTLSManager_client_noncesMu,r_echo_AutoTLSManager_stateMu,r_echo_AutoTLSManager_renewalMu,r_echo_AutoTLSManager_challengeMu,child_insert1030);
				child_insert1030?0;
				

				if
				:: true -> 
					run insert103(r_echo_startupMutex,r_echo_StdLogger_mu,r_echo_Server_TLSConfig_mutex,r_echo_Server_ErrorLog_mu,r_echo_Server_nextProtoOnce_m,r_echo_Server_mu,r_echo_TLSServer_TLSConfig_mutex,r_echo_TLSServer_ErrorLog_mu,r_echo_TLSServer_nextProtoOnce_m,r_echo_TLSServer_mu,r_echo_AutoTLSManager_Client_cacheMu,r_echo_AutoTLSManager_Client_noncesMu,r_echo_AutoTLSManager_clientMu,r_echo_AutoTLSManager_client_cacheMu,r_echo_AutoTLSManager_client_noncesMu,r_echo_AutoTLSManager_stateMu,r_echo_AutoTLSManager_renewalMu,r_echo_AutoTLSManager_challengeMu,child_insert1031);
					child_insert1031?0
				:: true -> 
					run insert103(r_echo_startupMutex,r_echo_StdLogger_mu,r_echo_Server_TLSConfig_mutex,r_echo_Server_ErrorLog_mu,r_echo_Server_nextProtoOnce_m,r_echo_Server_mu,r_echo_TLSServer_TLSConfig_mutex,r_echo_TLSServer_ErrorLog_mu,r_echo_TLSServer_nextProtoOnce_m,r_echo_TLSServer_mu,r_echo_AutoTLSManager_Client_cacheMu,r_echo_AutoTLSManager_Client_noncesMu,r_echo_AutoTLSManager_clientMu,r_echo_AutoTLSManager_client_cacheMu,r_echo_AutoTLSManager_client_noncesMu,r_echo_AutoTLSManager_stateMu,r_echo_AutoTLSManager_renewalMu,r_echo_AutoTLSManager_challengeMu,child_insert1032);
					child_insert1032?0
				fi
			:: true -> 
				

				if
				:: true -> 
					run insert103(r_echo_startupMutex,r_echo_StdLogger_mu,r_echo_Server_TLSConfig_mutex,r_echo_Server_ErrorLog_mu,r_echo_Server_nextProtoOnce_m,r_echo_Server_mu,r_echo_TLSServer_TLSConfig_mutex,r_echo_TLSServer_ErrorLog_mu,r_echo_TLSServer_nextProtoOnce_m,r_echo_TLSServer_mu,r_echo_AutoTLSManager_Client_cacheMu,r_echo_AutoTLSManager_Client_noncesMu,r_echo_AutoTLSManager_clientMu,r_echo_AutoTLSManager_client_cacheMu,r_echo_AutoTLSManager_client_noncesMu,r_echo_AutoTLSManager_stateMu,r_echo_AutoTLSManager_renewalMu,r_echo_AutoTLSManager_challengeMu,child_insert1033);
					child_insert1033?0;
					run insert103(r_echo_startupMutex,r_echo_StdLogger_mu,r_echo_Server_TLSConfig_mutex,r_echo_Server_ErrorLog_mu,r_echo_Server_nextProtoOnce_m,r_echo_Server_mu,r_echo_TLSServer_TLSConfig_mutex,r_echo_TLSServer_ErrorLog_mu,r_echo_TLSServer_nextProtoOnce_m,r_echo_TLSServer_mu,r_echo_AutoTLSManager_Client_cacheMu,r_echo_AutoTLSManager_Client_noncesMu,r_echo_AutoTLSManager_clientMu,r_echo_AutoTLSManager_client_cacheMu,r_echo_AutoTLSManager_client_noncesMu,r_echo_AutoTLSManager_stateMu,r_echo_AutoTLSManager_renewalMu,r_echo_AutoTLSManager_challengeMu,child_insert1034);
					child_insert1034?0
				:: true;
				fi
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	run insert103(r_echo_startupMutex,r_echo_StdLogger_mu,r_echo_Server_TLSConfig_mutex,r_echo_Server_ErrorLog_mu,r_echo_Server_nextProtoOnce_m,r_echo_Server_mu,r_echo_TLSServer_TLSConfig_mutex,r_echo_TLSServer_ErrorLog_mu,r_echo_TLSServer_nextProtoOnce_m,r_echo_TLSServer_mu,r_echo_AutoTLSManager_Client_cacheMu,r_echo_AutoTLSManager_Client_noncesMu,r_echo_AutoTLSManager_clientMu,r_echo_AutoTLSManager_client_cacheMu,r_echo_AutoTLSManager_client_noncesMu,r_echo_AutoTLSManager_stateMu,r_echo_AutoTLSManager_renewalMu,r_echo_AutoTLSManager_challengeMu,child_insert10310);
	child_insert10310?0;
	stop_process: skip;
	child!0
}
proctype insert103(Mutexdef r_echo_startupMutex;Mutexdef r_echo_StdLogger_mu;Mutexdef r_echo_Server_TLSConfig_mutex;Mutexdef r_echo_Server_ErrorLog_mu;Mutexdef r_echo_Server_nextProtoOnce_m;Mutexdef r_echo_Server_mu;Mutexdef r_echo_TLSServer_TLSConfig_mutex;Mutexdef r_echo_TLSServer_ErrorLog_mu;Mutexdef r_echo_TLSServer_nextProtoOnce_m;Mutexdef r_echo_TLSServer_mu;Mutexdef r_echo_AutoTLSManager_Client_cacheMu;Mutexdef r_echo_AutoTLSManager_Client_noncesMu;Mutexdef r_echo_AutoTLSManager_clientMu;Mutexdef r_echo_AutoTLSManager_client_cacheMu;Mutexdef r_echo_AutoTLSManager_client_noncesMu;Mutexdef r_echo_AutoTLSManager_stateMu;Mutexdef r_echo_AutoTLSManager_renewalMu;Mutexdef r_echo_AutoTLSManager_challengeMu;chan child) {
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

