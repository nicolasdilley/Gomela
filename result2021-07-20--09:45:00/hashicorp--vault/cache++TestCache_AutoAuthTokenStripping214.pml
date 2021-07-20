// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob/f8f289712a3d37115090591602a2b92503fb3a13/command/agent/cache/cache_test.go#L214
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCache_AutoAuthTokenStripping2140 = [1] of {int};
	run TestCache_AutoAuthTokenStripping214(child_TestCache_AutoAuthTokenStripping2140);
	run receiver(child_TestCache_AutoAuthTokenStripping2140)
stop_process:skip
}

proctype TestCache_AutoAuthTokenStripping214(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef testClient_config_modifyLock;
	Mutexdef testClient_modifyLock;
	Mutexdef server_mu;
	Mutexdef server_nextProtoOnce_m;
	Mutexdef server_ErrorLog_mu;
	Mutexdef server_TLSConfig_mutex;
	chan child_Handler231 = [1] of {int};
	chan child_HandleCacheClear5650 = [1] of {int};
	Mutexdef mux_mu;
	Mutexdef client_config_modifyLock;
	Mutexdef client_modifyLock;
	Mutexdef cluster_base_ReloadFuncsLock;
	Mutexdef leaseCache_l;
	Mutexdef leaseCache_client_modifyLock;
	run mutexMonitor(leaseCache_client_modifyLock);
	run mutexMonitor(leaseCache_l);
	run mutexMonitor(cluster_base_ReloadFuncsLock);
	run mutexMonitor(client_modifyLock);
	run mutexMonitor(client_config_modifyLock);
	run mutexMonitor(mux_mu);
	run HandleCacheClear565(leaseCache_client_modifyLock,leaseCache_l,child_HandleCacheClear5650);
	child_HandleCacheClear5650?0;
	run Handler23(leaseCache_client_modifyLock,leaseCache_l,child_Handler231);
	child_Handler231?0;
	run mutexMonitor(server_TLSConfig_mutex);
	run mutexMonitor(server_ErrorLog_mu);
	run mutexMonitor(server_nextProtoOnce_m);
	run mutexMonitor(server_mu);
	run mutexMonitor(testClient_modifyLock);
	run mutexMonitor(testClient_config_modifyLock);
	stop_process: skip;
	child!0
}
proctype HandleCacheClear565(Mutexdef c_client_modifyLock;Mutexdef c_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Handler23(Mutexdef proxier_client_modifyLock;Mutexdef proxier_l;chan child) {
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

proctype receiver(chan c) {
c?0
}

