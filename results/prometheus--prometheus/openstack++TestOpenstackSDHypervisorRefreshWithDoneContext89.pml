
// https://github.com/prometheus/prometheus/blob/master/discovery/openstack/hypervisor_test.go#L89
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
	chan child_TestOpenstackSDHypervisorRefreshWithDoneContext890 = [1] of {int};
	run TestOpenstackSDHypervisorRefreshWithDoneContext89(child_TestOpenstackSDHypervisorRefreshWithDoneContext890)
stop_process:skip
}

proctype TestOpenstackSDHypervisorRefreshWithDoneContext89(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_openstackAuthSuccess371 = [1] of {int};
	chan child_SetupTest280 = [1] of {int};
	Mutexdef mock_Mock_Mux_mu;
	Mutexdef mock_Mock_Server_mu;
	Wgdef mock_Mock_Server_wg;
	Mutexdef mock_Mock_Server_Config_mu;
	Mutexdef mock_Mock_Server_Config_nextProtoOnce_m;
	Mutexdef mock_Mock_Server_Config_ErrorLog_mu;
	Mutexdef mock_Mock_Server_Config_TLSConfig_mutex;
	Mutexdef mock_Mock_Server_TLS_mutex;
	Mutexdef mock_Mock_t_context_mu;
	Mutexdef mock_Mock_t_context_match_mu;
	run mutexMonitor(mock_Mock_t_context_match_mu);
	run mutexMonitor(mock_Mock_t_context_mu);
	run mutexMonitor(mock_Mock_Server_TLS_mutex);
	run mutexMonitor(mock_Mock_Server_Config_TLSConfig_mutex);
	run mutexMonitor(mock_Mock_Server_Config_ErrorLog_mu);
	run mutexMonitor(mock_Mock_Server_Config_nextProtoOnce_m);
	run mutexMonitor(mock_Mock_Server_Config_mu);
	run wgMonitor(mock_Mock_Server_wg);
	run mutexMonitor(mock_Mock_Server_mu);
	run mutexMonitor(mock_Mock_Mux_mu);
	run SetupTest28(mock_Mock_Server_wg,mock_Mock_t_context_match_mu,mock_Mock_t_context_mu,mock_Mock_Server_TLS_mutex,mock_Mock_Server_Config_TLSConfig_mutex,mock_Mock_Server_Config_ErrorLog_mu,mock_Mock_Server_Config_nextProtoOnce_m,mock_Mock_Server_Config_mu,mock_Mock_Server_mu,mock_Mock_Mux_mu,child_SetupTest280);
	child_SetupTest280?0;
	run openstackAuthSuccess37(mock_Mock_Server_wg,mock_Mock_t_context_match_mu,mock_Mock_t_context_mu,mock_Mock_Server_TLS_mutex,mock_Mock_Server_Config_TLSConfig_mutex,mock_Mock_Server_Config_ErrorLog_mu,mock_Mock_Server_Config_nextProtoOnce_m,mock_Mock_Server_Config_mu,mock_Mock_Server_mu,mock_Mock_Mux_mu,child_openstackAuthSuccess371);
	child_openstackAuthSuccess371?0;
	stop_process: skip;
	child!0
}
proctype SetupTest28(Wgdef s_Mock_Server_wg;Mutexdef s_Mock_t_context_match_mu;Mutexdef s_Mock_t_context_mu;Mutexdef s_Mock_Server_TLS_mutex;Mutexdef s_Mock_Server_Config_TLSConfig_mutex;Mutexdef s_Mock_Server_Config_ErrorLog_mu;Mutexdef s_Mock_Server_Config_nextProtoOnce_m;Mutexdef s_Mock_Server_Config_mu;Mutexdef s_Mock_Server_mu;Mutexdef s_Mock_Mux_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_HandleAuthSuccessfully923 = [1] of {int};
	chan child_HandleVersionsSuccessfully642 = [1] of {int};
	chan child_HandleHypervisorListSuccessfully2401 = [1] of {int};
	chan child_Setup430 = [1] of {int};
	run Setup43(s_Mock_Server_wg,s_Mock_t_context_match_mu,s_Mock_t_context_mu,s_Mock_Server_TLS_mutex,s_Mock_Server_Config_TLSConfig_mutex,s_Mock_Server_Config_ErrorLog_mu,s_Mock_Server_Config_nextProtoOnce_m,s_Mock_Server_Config_mu,s_Mock_Server_mu,s_Mock_Mux_mu,child_Setup430);
	child_Setup430?0;
	run HandleHypervisorListSuccessfully240(s_Mock_Server_wg,s_Mock_t_context_match_mu,s_Mock_t_context_mu,s_Mock_Server_TLS_mutex,s_Mock_Server_Config_TLSConfig_mutex,s_Mock_Server_Config_ErrorLog_mu,s_Mock_Server_Config_nextProtoOnce_m,s_Mock_Server_Config_mu,s_Mock_Server_mu,s_Mock_Mux_mu,child_HandleHypervisorListSuccessfully2401);
	child_HandleHypervisorListSuccessfully2401?0;
	run HandleVersionsSuccessfully64(s_Mock_Server_wg,s_Mock_t_context_match_mu,s_Mock_t_context_mu,s_Mock_Server_TLS_mutex,s_Mock_Server_Config_TLSConfig_mutex,s_Mock_Server_Config_ErrorLog_mu,s_Mock_Server_Config_nextProtoOnce_m,s_Mock_Server_Config_mu,s_Mock_Server_mu,s_Mock_Mux_mu,child_HandleVersionsSuccessfully642);
	child_HandleVersionsSuccessfully642?0;
	run HandleAuthSuccessfully92(s_Mock_Server_wg,s_Mock_t_context_match_mu,s_Mock_t_context_mu,s_Mock_Server_TLS_mutex,s_Mock_Server_Config_TLSConfig_mutex,s_Mock_Server_Config_ErrorLog_mu,s_Mock_Server_Config_nextProtoOnce_m,s_Mock_Server_Config_mu,s_Mock_Server_mu,s_Mock_Mux_mu,child_HandleAuthSuccessfully923);
	child_HandleAuthSuccessfully923?0;
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
proctype HandleHypervisorListSuccessfully240(Wgdef m_Server_wg;Mutexdef m_t_context_match_mu;Mutexdef m_t_context_mu;Mutexdef m_Server_TLS_mutex;Mutexdef m_Server_Config_TLSConfig_mutex;Mutexdef m_Server_Config_ErrorLog_mu;Mutexdef m_Server_Config_nextProtoOnce_m;Mutexdef m_Server_Config_mu;Mutexdef m_Server_mu;Mutexdef m_Mux_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype HandleVersionsSuccessfully64(Wgdef m_Server_wg;Mutexdef m_t_context_match_mu;Mutexdef m_t_context_mu;Mutexdef m_Server_TLS_mutex;Mutexdef m_Server_Config_TLSConfig_mutex;Mutexdef m_Server_Config_ErrorLog_mu;Mutexdef m_Server_Config_nextProtoOnce_m;Mutexdef m_Server_Config_mu;Mutexdef m_Server_mu;Mutexdef m_Mux_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype HandleAuthSuccessfully92(Wgdef m_Server_wg;Mutexdef m_t_context_match_mu;Mutexdef m_t_context_mu;Mutexdef m_Server_TLS_mutex;Mutexdef m_Server_Config_TLSConfig_mutex;Mutexdef m_Server_Config_ErrorLog_mu;Mutexdef m_Server_Config_nextProtoOnce_m;Mutexdef m_Server_Config_mu;Mutexdef m_Server_mu;Mutexdef m_Mux_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype openstackAuthSuccess37(Wgdef s_Mock_Server_wg;Mutexdef s_Mock_t_context_match_mu;Mutexdef s_Mock_t_context_mu;Mutexdef s_Mock_Server_TLS_mutex;Mutexdef s_Mock_Server_Config_TLSConfig_mutex;Mutexdef s_Mock_Server_Config_ErrorLog_mu;Mutexdef s_Mock_Server_Config_nextProtoOnce_m;Mutexdef s_Mock_Server_Config_mu;Mutexdef s_Mock_Server_mu;Mutexdef s_Mock_Mux_mu;chan child) {
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

