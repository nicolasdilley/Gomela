
// https://github.com/prometheus/prometheus/blob/master/discovery/moby/tasks_test.go#L27
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
	chan child_TestDockerSwarmTasksSDRefresh270 = [1] of {int};
	run TestDockerSwarmTasksSDRefresh27(child_TestDockerSwarmTasksSDRefresh270)
stop_process:skip
}

proctype TestDockerSwarmTasksSDRefresh27(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Endpoint511 = [1] of {int};
	chan child_Setup560 = [1] of {int};
	Mutexdef sdmock_Mux_mu;
	Mutexdef sdmock_Server_mu;
	Wgdef sdmock_Server_wg;
	Mutexdef sdmock_Server_Config_mu;
	Mutexdef sdmock_Server_Config_nextProtoOnce_m;
	Mutexdef sdmock_Server_Config_ErrorLog_mu;
	Mutexdef sdmock_Server_Config_TLSConfig_mutex;
	Mutexdef sdmock_Server_TLS_mutex;
	Mutexdef sdmock_t_context_mu;
	Mutexdef sdmock_t_context_match_mu;
	run mutexMonitor(sdmock_t_context_match_mu);
	run mutexMonitor(sdmock_t_context_mu);
	run mutexMonitor(sdmock_Server_TLS_mutex);
	run mutexMonitor(sdmock_Server_Config_TLSConfig_mutex);
	run mutexMonitor(sdmock_Server_Config_ErrorLog_mu);
	run mutexMonitor(sdmock_Server_Config_nextProtoOnce_m);
	run mutexMonitor(sdmock_Server_Config_mu);
	run wgMonitor(sdmock_Server_wg);
	run mutexMonitor(sdmock_Server_mu);
	run mutexMonitor(sdmock_Mux_mu);
	run Setup56(sdmock_Server_wg,sdmock_t_context_match_mu,sdmock_t_context_mu,sdmock_Server_TLS_mutex,sdmock_Server_Config_TLSConfig_mutex,sdmock_Server_Config_ErrorLog_mu,sdmock_Server_Config_nextProtoOnce_m,sdmock_Server_Config_mu,sdmock_Server_mu,sdmock_Mux_mu,child_Setup560);
	child_Setup560?0;
	run Endpoint51(sdmock_Server_wg,sdmock_t_context_match_mu,sdmock_t_context_mu,sdmock_Server_TLS_mutex,sdmock_Server_Config_TLSConfig_mutex,sdmock_Server_Config_ErrorLog_mu,sdmock_Server_Config_nextProtoOnce_m,sdmock_Server_Config_mu,sdmock_Server_mu,sdmock_Mux_mu,child_Endpoint511);
	child_Endpoint511?0;
	stop_process: skip;
	child!0
}
proctype Setup56(Wgdef m_Server_wg;Mutexdef m_t_context_match_mu;Mutexdef m_t_context_mu;Mutexdef m_Server_TLS_mutex;Mutexdef m_Server_Config_TLSConfig_mutex;Mutexdef m_Server_Config_ErrorLog_mu;Mutexdef m_Server_Config_nextProtoOnce_m;Mutexdef m_Server_Config_mu;Mutexdef m_Server_mu;Mutexdef m_Mux_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetupHandlers640 = [1] of {int};
	run SetupHandlers64(m_Server_wg,m_t_context_match_mu,m_t_context_mu,m_Server_TLS_mutex,m_Server_Config_TLSConfig_mutex,m_Server_Config_ErrorLog_mu,m_Server_Config_nextProtoOnce_m,m_Server_Config_mu,m_Server_mu,m_Mux_mu,child_SetupHandlers640);
	child_SetupHandlers640?0;
	stop_process: skip;
	child!0
}
proctype SetupHandlers64(Wgdef m_Server_wg;Mutexdef m_t_context_match_mu;Mutexdef m_t_context_mu;Mutexdef m_Server_TLS_mutex;Mutexdef m_Server_Config_TLSConfig_mutex;Mutexdef m_Server_Config_ErrorLog_mu;Mutexdef m_Server_Config_nextProtoOnce_m;Mutexdef m_Server_Config_mu;Mutexdef m_Server_mu;Mutexdef m_Mux_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Endpoint51(Wgdef m_Server_wg;Mutexdef m_t_context_match_mu;Mutexdef m_t_context_mu;Mutexdef m_Server_TLS_mutex;Mutexdef m_Server_Config_TLSConfig_mutex;Mutexdef m_Server_Config_ErrorLog_mu;Mutexdef m_Server_Config_nextProtoOnce_m;Mutexdef m_Server_Config_mu;Mutexdef m_Server_mu;Mutexdef m_Mux_mu;chan child) {
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

