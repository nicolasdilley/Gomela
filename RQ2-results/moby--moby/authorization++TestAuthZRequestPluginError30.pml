
// https://github.com/moby/moby/blob/master/pkg/authorization/authz_unix_test.go#L30
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
	chan child_TestAuthZRequestPluginError300 = [1] of {int};
	run TestAuthZRequestPluginError30(child_TestAuthZRequestPluginError300)
stop_process:skip
}

proctype TestAuthZRequestPluginError30(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_stop3181 = [1] of {int};
	chan child_AuthZRequest703 = [1] of {int};
	chan child_socketAddress2862 = [1] of {int};
	Mutexdef authZPlugin_once_m;
	chan child_start2910 = [1] of {int};
	Mutexdef server_server_mu;
	Wgdef server_server_wg;
	Mutexdef server_server_Config_mu;
	Mutexdef server_server_Config_nextProtoOnce_m;
	Mutexdef server_server_Config_ErrorLog_mu;
	Mutexdef server_server_Config_TLSConfig_mutex;
	Mutexdef server_server_TLS_mutex;
	Mutexdef server_t_context_mu;
	Mutexdef server_t_context_match_mu;
	run mutexMonitor(server_t_context_match_mu);
	run mutexMonitor(server_t_context_mu);
	run mutexMonitor(server_server_TLS_mutex);
	run mutexMonitor(server_server_Config_TLSConfig_mutex);
	run mutexMonitor(server_server_Config_ErrorLog_mu);
	run mutexMonitor(server_server_Config_nextProtoOnce_m);
	run mutexMonitor(server_server_Config_mu);
	run wgMonitor(server_server_wg);
	run mutexMonitor(server_server_mu);
	run start291(server_server_wg,server_t_context_match_mu,server_t_context_mu,server_server_TLS_mutex,server_server_Config_TLSConfig_mutex,server_server_Config_ErrorLog_mu,server_server_Config_nextProtoOnce_m,server_server_Config_mu,server_server_mu,child_start2910);
	child_start2910?0;
	run mutexMonitor(authZPlugin_once_m);
	run socketAddress286(server_server_wg,server_t_context_match_mu,server_t_context_mu,server_server_TLS_mutex,server_server_Config_TLSConfig_mutex,server_server_Config_ErrorLog_mu,server_server_Config_nextProtoOnce_m,server_server_Config_mu,server_server_mu,child_socketAddress2862);
	child_socketAddress2862?0;
	run AuthZRequest70(authZPlugin_once_m,child_AuthZRequest703);
	child_AuthZRequest703?0;
	stop_process: skip;
		run stop318(server_server_wg,server_t_context_match_mu,server_t_context_mu,server_server_TLS_mutex,server_server_Config_TLSConfig_mutex,server_server_Config_ErrorLog_mu,server_server_Config_nextProtoOnce_m,server_server_Config_mu,server_server_mu,child_stop3181);
	child_stop3181?0;
	child!0
}
proctype start291(Wgdef t_server_wg;Mutexdef t_t_context_match_mu;Mutexdef t_t_context_mu;Mutexdef t_server_TLS_mutex;Mutexdef t_server_Config_TLSConfig_mutex;Mutexdef t_server_Config_ErrorLog_mu;Mutexdef t_server_Config_nextProtoOnce_m;Mutexdef t_server_Config_mu;Mutexdef t_server_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_socketAddress2860 = [1] of {int};
	run socketAddress286(t_server_wg,t_t_context_match_mu,t_t_context_mu,t_server_TLS_mutex,t_server_Config_TLSConfig_mutex,t_server_Config_ErrorLog_mu,t_server_Config_nextProtoOnce_m,t_server_Config_mu,t_server_mu,child_socketAddress2860);
	child_socketAddress2860?0;
	stop_process: skip;
	child!0
}
proctype socketAddress286(Wgdef t_server_wg;Mutexdef t_t_context_match_mu;Mutexdef t_t_context_mu;Mutexdef t_server_TLS_mutex;Mutexdef t_server_Config_TLSConfig_mutex;Mutexdef t_server_Config_ErrorLog_mu;Mutexdef t_server_Config_nextProtoOnce_m;Mutexdef t_server_Config_mu;Mutexdef t_server_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype stop318(Wgdef t_server_wg;Mutexdef t_t_context_match_mu;Mutexdef t_t_context_mu;Mutexdef t_server_TLS_mutex;Mutexdef t_server_Config_TLSConfig_mutex;Mutexdef t_server_Config_ErrorLog_mu;Mutexdef t_server_Config_nextProtoOnce_m;Mutexdef t_server_Config_mu;Mutexdef t_server_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype AuthZRequest70(Mutexdef a_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_initPlugin973 = [1] of {int};
	run initPlugin97(a_once_m,child_initPlugin973);
	child_initPlugin973?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype initPlugin97(Mutexdef a_once_m;chan child) {
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

