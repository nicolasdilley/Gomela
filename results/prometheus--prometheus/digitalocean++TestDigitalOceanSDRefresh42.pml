
// https://github.com/prometheus/prometheus/blob/master/discovery/digitalocean/digitalocean_test.go#L42
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
	chan child_TestDigitalOceanSDRefresh420 = [1] of {int};
	run TestDigitalOceanSDRefresh42(child_TestDigitalOceanSDRefresh420)
stop_process:skip
}

proctype TestDigitalOceanSDRefresh42(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_refresh1362 = [1] of {int};
	chan child_Endpoint391 = [1] of {int};
	Mutexdef d_client_ratemtx;
	chan child_SetupTest350 = [1] of {int};
	Mutexdef sdmock_Mock_Mux_mu;
	Mutexdef sdmock_Mock_Server_mu;
	Wgdef sdmock_Mock_Server_wg;
	Mutexdef sdmock_Mock_Server_Config_mu;
	Mutexdef sdmock_Mock_Server_Config_nextProtoOnce_m;
	Mutexdef sdmock_Mock_Server_Config_ErrorLog_mu;
	Mutexdef sdmock_Mock_Server_Config_TLSConfig_mutex;
	Mutexdef sdmock_Mock_Server_TLS_mutex;
	Mutexdef sdmock_Mock_t_context_mu;
	Mutexdef sdmock_Mock_t_context_match_mu;
	run mutexMonitor(sdmock_Mock_t_context_match_mu);
	run mutexMonitor(sdmock_Mock_t_context_mu);
	run mutexMonitor(sdmock_Mock_Server_TLS_mutex);
	run mutexMonitor(sdmock_Mock_Server_Config_TLSConfig_mutex);
	run mutexMonitor(sdmock_Mock_Server_Config_ErrorLog_mu);
	run mutexMonitor(sdmock_Mock_Server_Config_nextProtoOnce_m);
	run mutexMonitor(sdmock_Mock_Server_Config_mu);
	run wgMonitor(sdmock_Mock_Server_wg);
	run mutexMonitor(sdmock_Mock_Server_mu);
	run mutexMonitor(sdmock_Mock_Mux_mu);
	run SetupTest35(sdmock_Mock_Server_wg,sdmock_Mock_t_context_match_mu,sdmock_Mock_t_context_mu,sdmock_Mock_Server_TLS_mutex,sdmock_Mock_Server_Config_TLSConfig_mutex,sdmock_Mock_Server_Config_ErrorLog_mu,sdmock_Mock_Server_Config_nextProtoOnce_m,sdmock_Mock_Server_Config_mu,sdmock_Mock_Server_mu,sdmock_Mock_Mux_mu,child_SetupTest350);
	child_SetupTest350?0;
	run mutexMonitor(d_client_ratemtx);
	run Endpoint39(sdmock_Mock_Server_wg,sdmock_Mock_t_context_match_mu,sdmock_Mock_t_context_mu,sdmock_Mock_Server_TLS_mutex,sdmock_Mock_Server_Config_TLSConfig_mutex,sdmock_Mock_Server_Config_ErrorLog_mu,sdmock_Mock_Server_Config_nextProtoOnce_m,sdmock_Mock_Server_Config_mu,sdmock_Mock_Server_mu,sdmock_Mock_Mux_mu,child_Endpoint391);
	child_Endpoint391?0;
	run refresh136(d_client_ratemtx,child_refresh1362);
	child_refresh1362?0;
	stop_process: skip;
	child!0
}
proctype SetupTest35(Wgdef s_Mock_Server_wg;Mutexdef s_Mock_t_context_match_mu;Mutexdef s_Mock_t_context_mu;Mutexdef s_Mock_Server_TLS_mutex;Mutexdef s_Mock_Server_Config_TLSConfig_mutex;Mutexdef s_Mock_Server_Config_ErrorLog_mu;Mutexdef s_Mock_Server_Config_nextProtoOnce_m;Mutexdef s_Mock_Server_Config_mu;Mutexdef s_Mock_Server_mu;Mutexdef s_Mock_Mux_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_HandleDropletsList571 = [1] of {int};
	chan child_Setup440 = [1] of {int};
	run Setup44(s_Mock_Server_wg,s_Mock_t_context_match_mu,s_Mock_t_context_mu,s_Mock_Server_TLS_mutex,s_Mock_Server_Config_TLSConfig_mutex,s_Mock_Server_Config_ErrorLog_mu,s_Mock_Server_Config_nextProtoOnce_m,s_Mock_Server_Config_mu,s_Mock_Server_mu,s_Mock_Mux_mu,child_Setup440);
	child_Setup440?0;
	run HandleDropletsList57(s_Mock_Server_wg,s_Mock_t_context_match_mu,s_Mock_t_context_mu,s_Mock_Server_TLS_mutex,s_Mock_Server_Config_TLSConfig_mutex,s_Mock_Server_Config_ErrorLog_mu,s_Mock_Server_Config_nextProtoOnce_m,s_Mock_Server_Config_mu,s_Mock_Server_mu,s_Mock_Mux_mu,child_HandleDropletsList571);
	child_HandleDropletsList571?0;
	stop_process: skip;
	child!0
}
proctype Setup44(Wgdef m_Server_wg;Mutexdef m_t_context_match_mu;Mutexdef m_t_context_mu;Mutexdef m_Server_TLS_mutex;Mutexdef m_Server_Config_TLSConfig_mutex;Mutexdef m_Server_Config_ErrorLog_mu;Mutexdef m_Server_Config_nextProtoOnce_m;Mutexdef m_Server_Config_mu;Mutexdef m_Server_mu;Mutexdef m_Mux_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype HandleDropletsList57(Wgdef m_Server_wg;Mutexdef m_t_context_match_mu;Mutexdef m_t_context_mu;Mutexdef m_Server_TLS_mutex;Mutexdef m_Server_Config_TLSConfig_mutex;Mutexdef m_Server_Config_ErrorLog_mu;Mutexdef m_Server_Config_nextProtoOnce_m;Mutexdef m_Server_Config_mu;Mutexdef m_Server_mu;Mutexdef m_Mux_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Endpoint39(Wgdef m_Server_wg;Mutexdef m_t_context_match_mu;Mutexdef m_t_context_mu;Mutexdef m_Server_TLS_mutex;Mutexdef m_Server_Config_TLSConfig_mutex;Mutexdef m_Server_Config_ErrorLog_mu;Mutexdef m_Server_Config_nextProtoOnce_m;Mutexdef m_Server_Config_mu;Mutexdef m_Server_mu;Mutexdef m_Mux_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype refresh136(Mutexdef d_client_ratemtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_listDroplets1992 = [1] of {int};
	run listDroplets199(d_client_ratemtx,child_listDroplets1992);
	child_listDroplets1992?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype listDroplets199(Mutexdef d_client_ratemtx;chan child) {
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

