
// https://github.com/prometheus/prometheus/blob/master/discovery/hetzner/hcloud_test.go#L38
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
	chan child_TestHCloudSDRefresh380 = [1] of {int};
	run TestHCloudSDRefresh38(child_TestHCloudSDRefresh380)
stop_process:skip
}

proctype TestHCloudSDRefresh38(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Endpoint381 = [1] of {int};
	chan child_SetupTest300 = [1] of {int};
	Mutexdef suite_Mock_Mux_mu;
	Mutexdef suite_Mock_Server_mu;
	Wgdef suite_Mock_Server_wg;
	Mutexdef suite_Mock_Server_Config_mu;
	Mutexdef suite_Mock_Server_Config_nextProtoOnce_m;
	Mutexdef suite_Mock_Server_Config_ErrorLog_mu;
	Mutexdef suite_Mock_Server_Config_TLSConfig_mutex;
	Mutexdef suite_Mock_Server_TLS_mutex;
	Mutexdef suite_Mock_t_context_mu;
	Mutexdef suite_Mock_t_context_match_mu;
	run mutexMonitor(suite_Mock_t_context_match_mu);
	run mutexMonitor(suite_Mock_t_context_mu);
	run mutexMonitor(suite_Mock_Server_TLS_mutex);
	run mutexMonitor(suite_Mock_Server_Config_TLSConfig_mutex);
	run mutexMonitor(suite_Mock_Server_Config_ErrorLog_mu);
	run mutexMonitor(suite_Mock_Server_Config_nextProtoOnce_m);
	run mutexMonitor(suite_Mock_Server_Config_mu);
	run wgMonitor(suite_Mock_Server_wg);
	run mutexMonitor(suite_Mock_Server_mu);
	run mutexMonitor(suite_Mock_Mux_mu);
	run SetupTest30(suite_Mock_Server_wg,suite_Mock_t_context_match_mu,suite_Mock_t_context_mu,suite_Mock_Server_TLS_mutex,suite_Mock_Server_Config_TLSConfig_mutex,suite_Mock_Server_Config_ErrorLog_mu,suite_Mock_Server_Config_nextProtoOnce_m,suite_Mock_Server_Config_mu,suite_Mock_Server_mu,suite_Mock_Mux_mu,child_SetupTest300);
	child_SetupTest300?0;
	run Endpoint38(suite_Mock_Server_wg,suite_Mock_t_context_match_mu,suite_Mock_t_context_mu,suite_Mock_Server_TLS_mutex,suite_Mock_Server_Config_TLSConfig_mutex,suite_Mock_Server_Config_ErrorLog_mu,suite_Mock_Server_Config_nextProtoOnce_m,suite_Mock_Server_Config_mu,suite_Mock_Server_mu,suite_Mock_Mux_mu,child_Endpoint381);
	child_Endpoint381?0;
	stop_process: skip;
	child!0
}
proctype SetupTest30(Wgdef s_Mock_Server_wg;Mutexdef s_Mock_t_context_match_mu;Mutexdef s_Mock_t_context_mu;Mutexdef s_Mock_Server_TLS_mutex;Mutexdef s_Mock_Server_Config_TLSConfig_mutex;Mutexdef s_Mock_Server_Config_ErrorLog_mu;Mutexdef s_Mock_Server_Config_nextProtoOnce_m;Mutexdef s_Mock_Server_Config_mu;Mutexdef s_Mock_Server_mu;Mutexdef s_Mock_Mux_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_HandleHcloudNetworks4302 = [1] of {int};
	chan child_HandleHcloudServers571 = [1] of {int};
	chan child_Setup430 = [1] of {int};
	run Setup43(s_Mock_Server_wg,s_Mock_t_context_match_mu,s_Mock_t_context_mu,s_Mock_Server_TLS_mutex,s_Mock_Server_Config_TLSConfig_mutex,s_Mock_Server_Config_ErrorLog_mu,s_Mock_Server_Config_nextProtoOnce_m,s_Mock_Server_Config_mu,s_Mock_Server_mu,s_Mock_Mux_mu,child_Setup430);
	child_Setup430?0;
	run HandleHcloudServers57(s_Mock_Server_wg,s_Mock_t_context_match_mu,s_Mock_t_context_mu,s_Mock_Server_TLS_mutex,s_Mock_Server_Config_TLSConfig_mutex,s_Mock_Server_Config_ErrorLog_mu,s_Mock_Server_Config_nextProtoOnce_m,s_Mock_Server_Config_mu,s_Mock_Server_mu,s_Mock_Mux_mu,child_HandleHcloudServers571);
	child_HandleHcloudServers571?0;
	run HandleHcloudNetworks430(s_Mock_Server_wg,s_Mock_t_context_match_mu,s_Mock_t_context_mu,s_Mock_Server_TLS_mutex,s_Mock_Server_Config_TLSConfig_mutex,s_Mock_Server_Config_ErrorLog_mu,s_Mock_Server_Config_nextProtoOnce_m,s_Mock_Server_Config_mu,s_Mock_Server_mu,s_Mock_Mux_mu,child_HandleHcloudNetworks4302);
	child_HandleHcloudNetworks4302?0;
	stop_process: skip;
	child!0
}
proctype Setup43(Wgdef m_Server_wg;Mutexdef m_t_context_match_mu;Mutexdef m_t_context_mu;Mutexdef m_Server_TLS_mutex;Mutexdef m_Server_Config_TLSConfig_mutex;Mutexdef m_Server_Config_ErrorLog_mu;Mutexdef m_Server_Config_nextProtoOnce_m;Mutexdef m_Server_Config_mu;Mutexdef m_Server_mu;Mutexdef m_Mux_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype HandleHcloudServers57(Wgdef m_Server_wg;Mutexdef m_t_context_match_mu;Mutexdef m_t_context_mu;Mutexdef m_Server_TLS_mutex;Mutexdef m_Server_Config_TLSConfig_mutex;Mutexdef m_Server_Config_ErrorLog_mu;Mutexdef m_Server_Config_nextProtoOnce_m;Mutexdef m_Server_Config_mu;Mutexdef m_Server_mu;Mutexdef m_Mux_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype HandleHcloudNetworks430(Wgdef m_Server_wg;Mutexdef m_t_context_match_mu;Mutexdef m_t_context_mu;Mutexdef m_Server_TLS_mutex;Mutexdef m_Server_Config_TLSConfig_mutex;Mutexdef m_Server_Config_ErrorLog_mu;Mutexdef m_Server_Config_nextProtoOnce_m;Mutexdef m_Server_Config_mu;Mutexdef m_Server_mu;Mutexdef m_Mux_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Endpoint38(Wgdef m_Server_wg;Mutexdef m_t_context_match_mu;Mutexdef m_t_context_mu;Mutexdef m_Server_TLS_mutex;Mutexdef m_Server_Config_TLSConfig_mutex;Mutexdef m_Server_Config_ErrorLog_mu;Mutexdef m_Server_Config_nextProtoOnce_m;Mutexdef m_Server_Config_mu;Mutexdef m_Server_mu;Mutexdef m_Mux_mu;chan child) {
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

