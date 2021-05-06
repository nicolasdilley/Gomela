
// https://github.com/hashicorp/vault/blob/master/command/agent/cache/cache_test.go#L214
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCache_AutoAuthTokenStripping2140 = [1] of {int};
	run TestCache_AutoAuthTokenStripping214(child_TestCache_AutoAuthTokenStripping2140)
stop_process:skip
}

proctype TestCache_AutoAuthTokenStripping214(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef testClient_config_Limiter_mu;
	Mutexdef testClient_config_modifyLock;
	Mutexdef testClient_modifyLock;
	Mutexdef server_mu;
	Mutexdef server_nextProtoOnce_m;
	Mutexdef server_ErrorLog_mu;
	Mutexdef server_TLSConfig_mutex;
	chan child_Handler231 = [1] of {int};
	chan child_HandleCacheClear5650 = [1] of {int};
	Mutexdef mux_mu;
	Mutexdef client_config_Limiter_mu;
	Mutexdef client_config_modifyLock;
	Mutexdef client_modifyLock;
	Mutexdef cluster_base_MetricsHelper_LoopMetrics_Metrics_mu;
	Mutexdef cluster_base_MetricsHelper_inMemSink_intervalLock;
	Mutexdef cluster_base_ReloadFuncsLock;
	Mutexdef leaseCache_ps_db_statlock;
	Mutexdef leaseCache_ps_db_mmaplock;
	Mutexdef leaseCache_ps_db_metalock;
	Mutexdef leaseCache_ps_db_rwlock;
	Mutexdef leaseCache_ps_db_batch_start_m;
	Mutexdef leaseCache_ps_db_batchMu;
	Mutexdef leaseCache_ps_db_freelistLoad_m;
	Mutexdef leaseCache_l;
	Mutexdef leaseCache_client_config_Limiter_mu;
	Mutexdef leaseCache_client_config_modifyLock;
	Mutexdef leaseCache_client_modifyLock;
	run mutexMonitor(leaseCache_client_modifyLock);
	run mutexMonitor(leaseCache_client_config_modifyLock);
	run mutexMonitor(leaseCache_client_config_Limiter_mu);
	run mutexMonitor(leaseCache_l);
	run mutexMonitor(leaseCache_ps_db_freelistLoad_m);
	run mutexMonitor(leaseCache_ps_db_batchMu);
	run mutexMonitor(leaseCache_ps_db_batch_start_m);
	run mutexMonitor(leaseCache_ps_db_rwlock);
	run mutexMonitor(leaseCache_ps_db_metalock);
	run mutexMonitor(leaseCache_ps_db_mmaplock);
	run mutexMonitor(leaseCache_ps_db_statlock);
	run mutexMonitor(cluster_base_ReloadFuncsLock);
	run mutexMonitor(cluster_base_MetricsHelper_inMemSink_intervalLock);
	run mutexMonitor(cluster_base_MetricsHelper_LoopMetrics_Metrics_mu);
	run mutexMonitor(client_modifyLock);
	run mutexMonitor(client_config_modifyLock);
	run mutexMonitor(client_config_Limiter_mu);
	run mutexMonitor(mux_mu);
	run HandleCacheClear565(leaseCache_client_modifyLock,leaseCache_client_config_modifyLock,leaseCache_client_config_Limiter_mu,leaseCache_l,leaseCache_ps_db_freelistLoad_m,leaseCache_ps_db_batchMu,leaseCache_ps_db_batch_start_m,leaseCache_ps_db_rwlock,leaseCache_ps_db_metalock,leaseCache_ps_db_mmaplock,leaseCache_ps_db_statlock,child_HandleCacheClear5650);
	child_HandleCacheClear5650?0;
	run Handler23(leaseCache_client_modifyLock,leaseCache_client_config_modifyLock,leaseCache_client_config_Limiter_mu,leaseCache_l,leaseCache_ps_db_freelistLoad_m,leaseCache_ps_db_batchMu,leaseCache_ps_db_batch_start_m,leaseCache_ps_db_rwlock,leaseCache_ps_db_metalock,leaseCache_ps_db_mmaplock,leaseCache_ps_db_statlock,child_Handler231);
	child_Handler231?0;
	run mutexMonitor(server_TLSConfig_mutex);
	run mutexMonitor(server_ErrorLog_mu);
	run mutexMonitor(server_nextProtoOnce_m);
	run mutexMonitor(server_mu);
	run mutexMonitor(testClient_modifyLock);
	run mutexMonitor(testClient_config_modifyLock);
	run mutexMonitor(testClient_config_Limiter_mu);
	stop_process: skip;
	child!0
}
proctype HandleCacheClear565(Mutexdef c_client_modifyLock;Mutexdef c_client_config_modifyLock;Mutexdef c_client_config_Limiter_mu;Mutexdef c_l;Mutexdef c_ps_db_freelistLoad_m;Mutexdef c_ps_db_batchMu;Mutexdef c_ps_db_batch_start_m;Mutexdef c_ps_db_rwlock;Mutexdef c_ps_db_metalock;Mutexdef c_ps_db_mmaplock;Mutexdef c_ps_db_statlock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Handler23(Mutexdef proxier_client_modifyLock;Mutexdef proxier_client_config_modifyLock;Mutexdef proxier_client_config_Limiter_mu;Mutexdef proxier_l;Mutexdef proxier_ps_db_freelistLoad_m;Mutexdef proxier_ps_db_batchMu;Mutexdef proxier_ps_db_batch_start_m;Mutexdef proxier_ps_db_rwlock;Mutexdef proxier_ps_db_metalock;Mutexdef proxier_ps_db_mmaplock;Mutexdef proxier_ps_db_statlock;chan child) {
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

