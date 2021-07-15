
// https://github.com/prometheus/prometheus/blob/master/discovery/openstack/instance_test.go#L53
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
	chan child_TestOpenstackSDInstanceRefresh530 = [1] of {int};
	run TestOpenstackSDInstanceRefresh53(child_TestOpenstackSDInstanceRefresh530)
stop_process:skip
}

proctype TestOpenstackSDInstanceRefresh53(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_openstackAuthSuccess401 = [1] of {int};
	chan child_SetupTest290 = [1] of {int};
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
	run SetupTest29(mock_Mock_Server_wg,mock_Mock_t_context_match_mu,mock_Mock_t_context_mu,mock_Mock_Server_TLS_mutex,mock_Mock_Server_Config_TLSConfig_mutex,mock_Mock_Server_Config_ErrorLog_mu,mock_Mock_Server_Config_nextProtoOnce_m,mock_Mock_Server_Config_mu,mock_Mock_Server_mu,mock_Mock_Mux_mu,child_SetupTest290);
	child_SetupTest290?0;
	run openstackAuthSuccess40(mock_Mock_Server_wg,mock_Mock_t_context_match_mu,mock_Mock_t_context_mu,mock_Mock_Server_TLS_mutex,mock_Mock_Server_Config_TLSConfig_mutex,mock_Mock_Server_Config_ErrorLog_mu,mock_Mock_Server_Config_nextProtoOnce_m,mock_Mock_Server_Config_mu,mock_Mock_Server_mu,mock_Mock_Mux_mu,child_openstackAuthSuccess401);
	child_openstackAuthSuccess401?0;
	stop_process: skip;
	child!0
}
proctype SetupTest29(Wgdef s_Mock_Server_wg;Mutexdef s_Mock_t_context_match_mu;Mutexdef s_Mock_t_context_mu;Mutexdef s_Mock_Server_TLS_mutex;Mutexdef s_Mock_Server_Config_TLSConfig_mutex;Mutexdef s_Mock_Server_Config_ErrorLog_mu;Mutexdef s_Mock_Server_Config_nextProtoOnce_m;Mutexdef s_Mock_Server_Config_mu;Mutexdef s_Mock_Server_mu;Mutexdef s_Mock_Mux_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_HandleAuthSuccessfully924 = [1] of {int};
	chan child_HandleVersionsSuccessfully643 = [1] of {int};
	chan child_HandleFloatingIPListSuccessfully5762 = [1] of {int};
	chan child_HandleServerListSuccessfully5371 = [1] of {int};
	chan child_Setup430 = [1] of {int};
	run Setup43(s_Mock_Server_wg,s_Mock_t_context_match_mu,s_Mock_t_context_mu,s_Mock_Server_TLS_mutex,s_Mock_Server_Config_TLSConfig_mutex,s_Mock_Server_Config_ErrorLog_mu,s_Mock_Server_Config_nextProtoOnce_m,s_Mock_Server_Config_mu,s_Mock_Server_mu,s_Mock_Mux_mu,child_Setup430);
	child_Setup430?0;
	run HandleServerListSuccessfully537(s_Mock_Server_wg,s_Mock_t_context_match_mu,s_Mock_t_context_mu,s_Mock_Server_TLS_mutex,s_Mock_Server_Config_TLSConfig_mutex,s_Mock_Server_Config_ErrorLog_mu,s_Mock_Server_Config_nextProtoOnce_m,s_Mock_Server_Config_mu,s_Mock_Server_mu,s_Mock_Mux_mu,child_HandleServerListSuccessfully5371);
	child_HandleServerListSuccessfully5371?0;
	run HandleFloatingIPListSuccessfully576(s_Mock_Server_wg,s_Mock_t_context_match_mu,s_Mock_t_context_mu,s_Mock_Server_TLS_mutex,s_Mock_Server_Config_TLSConfig_mutex,s_Mock_Server_Config_ErrorLog_mu,s_Mock_Server_Config_nextProtoOnce_m,s_Mock_Server_Config_mu,s_Mock_Server_mu,s_Mock_Mux_mu,child_HandleFloatingIPListSuccessfully5762);
	child_HandleFloatingIPListSuccessfully5762?0;
	run HandleVersionsSuccessfully64(s_Mock_Server_wg,s_Mock_t_context_match_mu,s_Mock_t_context_mu,s_Mock_Server_TLS_mutex,s_Mock_Server_Config_TLSConfig_mutex,s_Mock_Server_Config_ErrorLog_mu,s_Mock_Server_Config_nextProtoOnce_m,s_Mock_Server_Config_mu,s_Mock_Server_mu,s_Mock_Mux_mu,child_HandleVersionsSuccessfully643);
	child_HandleVersionsSuccessfully643?0;
	run HandleAuthSuccessfully92(s_Mock_Server_wg,s_Mock_t_context_match_mu,s_Mock_t_context_mu,s_Mock_Server_TLS_mutex,s_Mock_Server_Config_TLSConfig_mutex,s_Mock_Server_Config_ErrorLog_mu,s_Mock_Server_Config_nextProtoOnce_m,s_Mock_Server_Config_mu,s_Mock_Server_mu,s_Mock_Mux_mu,child_HandleAuthSuccessfully924);
	child_HandleAuthSuccessfully924?0;
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
proctype HandleServerListSuccessfully537(Wgdef m_Server_wg;Mutexdef m_t_context_match_mu;Mutexdef m_t_context_mu;Mutexdef m_Server_TLS_mutex;Mutexdef m_Server_Config_TLSConfig_mutex;Mutexdef m_Server_Config_ErrorLog_mu;Mutexdef m_Server_Config_nextProtoOnce_m;Mutexdef m_Server_Config_mu;Mutexdef m_Server_mu;Mutexdef m_Mux_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype HandleFloatingIPListSuccessfully576(Wgdef m_Server_wg;Mutexdef m_t_context_match_mu;Mutexdef m_t_context_mu;Mutexdef m_Server_TLS_mutex;Mutexdef m_Server_Config_TLSConfig_mutex;Mutexdef m_Server_Config_ErrorLog_mu;Mutexdef m_Server_Config_nextProtoOnce_m;Mutexdef m_Server_Config_mu;Mutexdef m_Server_mu;Mutexdef m_Mux_mu;chan child) {
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
proctype openstackAuthSuccess40(Wgdef s_Mock_Server_wg;Mutexdef s_Mock_t_context_match_mu;Mutexdef s_Mock_t_context_mu;Mutexdef s_Mock_Server_TLS_mutex;Mutexdef s_Mock_Server_Config_TLSConfig_mutex;Mutexdef s_Mock_Server_Config_ErrorLog_mu;Mutexdef s_Mock_Server_Config_nextProtoOnce_m;Mutexdef s_Mock_Server_Config_mu;Mutexdef s_Mock_Server_mu;Mutexdef s_Mock_Mux_mu;chan child) {
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

