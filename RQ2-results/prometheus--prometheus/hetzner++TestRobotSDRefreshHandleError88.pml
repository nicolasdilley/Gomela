
// https://github.com/prometheus/prometheus/blob/master/discovery/hetzner/robot_test.go#L88
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
	chan child_TestRobotSDRefreshHandleError880 = [1] of {int};
	run TestRobotSDRefreshHandleError88(child_TestRobotSDRefreshHandleError880)
stop_process:skip
}

proctype TestRobotSDRefreshHandleError88(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Endpoint381 = [1] of {int};
	chan child_SetupTest310 = [1] of {int};
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
	run SetupTest31(suite_Mock_Server_wg,suite_Mock_t_context_match_mu,suite_Mock_t_context_mu,suite_Mock_Server_TLS_mutex,suite_Mock_Server_Config_TLSConfig_mutex,suite_Mock_Server_Config_ErrorLog_mu,suite_Mock_Server_Config_nextProtoOnce_m,suite_Mock_Server_Config_mu,suite_Mock_Server_mu,suite_Mock_Mux_mu,child_SetupTest310);
	child_SetupTest310?0;
	run Endpoint38(suite_Mock_Server_wg,suite_Mock_t_context_match_mu,suite_Mock_t_context_mu,suite_Mock_Server_TLS_mutex,suite_Mock_Server_Config_TLSConfig_mutex,suite_Mock_Server_Config_ErrorLog_mu,suite_Mock_Server_Config_nextProtoOnce_m,suite_Mock_Server_Config_mu,suite_Mock_Server_mu,suite_Mock_Mux_mu,child_Endpoint381);
	child_Endpoint381?0;
	stop_process: skip;
	child!0
}
proctype SetupTest31(Wgdef s_Mock_Server_wg;Mutexdef s_Mock_t_context_match_mu;Mutexdef s_Mock_t_context_mu;Mutexdef s_Mock_Server_TLS_mutex;Mutexdef s_Mock_Server_Config_TLSConfig_mutex;Mutexdef s_Mock_Server_Config_ErrorLog_mu;Mutexdef s_Mock_Server_Config_nextProtoOnce_m;Mutexdef s_Mock_Server_Config_mu;Mutexdef s_Mock_Server_mu;Mutexdef s_Mock_Mux_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_HandleRobotServers4931 = [1] of {int};
	chan child_Setup430 = [1] of {int};
	run Setup43(s_Mock_Server_wg,s_Mock_t_context_match_mu,s_Mock_t_context_mu,s_Mock_Server_TLS_mutex,s_Mock_Server_Config_TLSConfig_mutex,s_Mock_Server_Config_ErrorLog_mu,s_Mock_Server_Config_nextProtoOnce_m,s_Mock_Server_Config_mu,s_Mock_Server_mu,s_Mock_Mux_mu,child_Setup430);
	child_Setup430?0;
	run HandleRobotServers493(s_Mock_Server_wg,s_Mock_t_context_match_mu,s_Mock_t_context_mu,s_Mock_Server_TLS_mutex,s_Mock_Server_Config_TLSConfig_mutex,s_Mock_Server_Config_ErrorLog_mu,s_Mock_Server_Config_nextProtoOnce_m,s_Mock_Server_Config_mu,s_Mock_Server_mu,s_Mock_Mux_mu,child_HandleRobotServers4931);
	child_HandleRobotServers4931?0;
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
proctype HandleRobotServers493(Wgdef m_Server_wg;Mutexdef m_t_context_match_mu;Mutexdef m_t_context_mu;Mutexdef m_Server_TLS_mutex;Mutexdef m_Server_Config_TLSConfig_mutex;Mutexdef m_Server_Config_ErrorLog_mu;Mutexdef m_Server_Config_nextProtoOnce_m;Mutexdef m_Server_Config_mu;Mutexdef m_Server_mu;Mutexdef m_Mux_mu;chan child) {
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

