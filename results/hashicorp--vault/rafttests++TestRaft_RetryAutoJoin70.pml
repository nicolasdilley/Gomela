// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob//vault/external_tests/raft/raft_test.go#L70
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
	chan child_TestRaft_RetryAutoJoin700 = [1] of {int};
	run TestRaft_RetryAutoJoin70(child_TestRaft_RetryAutoJoin700);
	run receiver(child_TestRaft_RetryAutoJoin700)
stop_process:skip
}

proctype TestRaft_RetryAutoJoin70(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef leaderCore_TLSConfig_mutex;
	Mutexdef leaderCore_Server_mu;
	Mutexdef leaderCore_Server_nextProtoOnce_m;
	Mutexdef leaderCore_Server_ErrorLog_mu;
	Mutexdef leaderCore_Server_TLSConfig_mutex;
	Mutexdef leaderCore_ReloadFuncsLock;
	Mutexdef leaderCore_Client_config_Limiter_mu;
	Mutexdef leaderCore_Client_config_modifyLock;
	Mutexdef leaderCore_Client_modifyLock;
	Mutexdef leaderCore_CoreConfig_MetricsHelper_inMemSink_intervalLock;
	Mutexdef leaderCore_CoreConfig_ReloadFuncsLock;
	Mutexdef addressProvider_Cluster_base_ReloadFuncsLock;
	Mutexdef cluster_base_MetricsHelper_inMemSink_intervalLock;
	Mutexdef cluster_base_ReloadFuncsLock;
	Mutexdef opts_DefaultHandlerProperties_Core_quotaManager_lock;
	Mutexdef opts_DefaultHandlerProperties_Core_pendingRaftPeers_mu;
	Mutexdef opts_DefaultHandlerProperties_Core_raftFollowerStates_l;
	Mutexdef opts_DefaultHandlerProperties_Core_allLoggersLock;
	Mutexdef opts_DefaultHandlerProperties_Core_unsealWithStoredKeysLock;
	Mutexdef opts_DefaultHandlerProperties_Core_pluginCatalog_lock;
	Mutexdef opts_DefaultHandlerProperties_Core_uiConfig_l;
	Mutexdef opts_DefaultHandlerProperties_Core_rpcClientConn_mu;
	Mutexdef opts_DefaultHandlerProperties_Core_leaderParamsLock;
	Mutexdef opts_DefaultHandlerProperties_Core_requestForwardingConnectionLock;
	Mutexdef opts_DefaultHandlerProperties_Core_clusterParamsLock;
	Mutexdef opts_DefaultHandlerProperties_Core_reloadFuncsLock;
	Mutexdef opts_DefaultHandlerProperties_Core_metricsMutex;
	Mutexdef opts_DefaultHandlerProperties_Core_activityLog_fragmentLock;
	Mutexdef opts_DefaultHandlerProperties_Core_activityLog_l;
	Mutexdef opts_DefaultHandlerProperties_Core_identityStore_groupLock;
	Mutexdef opts_DefaultHandlerProperties_Core_identityStore_oidcLock;
	Mutexdef opts_DefaultHandlerProperties_Core_identityStore_lock;
	Mutexdef opts_DefaultHandlerProperties_Core_tokenStore_saltLock;
	Mutexdef opts_DefaultHandlerProperties_Core_policyStore_modifyLock;
	Mutexdef opts_DefaultHandlerProperties_Core_rollback_shutdownLock;
	Mutexdef opts_DefaultHandlerProperties_Core_rollback_inflightLock;
	Wgdef opts_DefaultHandlerProperties_Core_rollback_inflightAll;
	Mutexdef opts_DefaultHandlerProperties_Core_expiration_restoreRequestLock;
	Mutexdef opts_DefaultHandlerProperties_Core_expiration_restoreModeLock;
	Mutexdef opts_DefaultHandlerProperties_Core_expiration_pendingLock;
	Mutexdef opts_DefaultHandlerProperties_Core_systemBarrierView_readOnlyErrLock;
	Mutexdef opts_DefaultHandlerProperties_Core_systemBackend_mfaLock;
	Mutexdef opts_DefaultHandlerProperties_Core_auditLock;
	Mutexdef opts_DefaultHandlerProperties_Core_authLock;
	Mutexdef opts_DefaultHandlerProperties_Core_mountsLock;
	Mutexdef opts_DefaultHandlerProperties_Core_rekeyLock;
	Mutexdef opts_DefaultHandlerProperties_Core_generateRootLock;
	Mutexdef opts_DefaultHandlerProperties_Core_router_l;
	Mutexdef conf_MetricsHelper_LoopMetrics_Metrics_mu;
	Mutexdef conf_MetricsHelper_inMemSink_intervalLock;
	Mutexdef conf_ReloadFuncsLock;
	run mutexMonitor(conf_ReloadFuncsLock);
	run mutexMonitor(conf_MetricsHelper_inMemSink_intervalLock);
	run mutexMonitor(conf_MetricsHelper_LoopMetrics_Metrics_mu);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_router_l);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_generateRootLock);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_rekeyLock);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_mountsLock);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_authLock);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_auditLock);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_systemBackend_mfaLock);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_systemBarrierView_readOnlyErrLock);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_expiration_pendingLock);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_expiration_restoreModeLock);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_expiration_restoreRequestLock);
	run wgMonitor(opts_DefaultHandlerProperties_Core_rollback_inflightAll);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_rollback_inflightLock);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_rollback_shutdownLock);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_policyStore_modifyLock);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_tokenStore_saltLock);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_identityStore_lock);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_identityStore_oidcLock);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_identityStore_groupLock);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_activityLog_l);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_activityLog_fragmentLock);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_metricsMutex);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_reloadFuncsLock);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_clusterParamsLock);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_requestForwardingConnectionLock);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_leaderParamsLock);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_rpcClientConn_mu);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_uiConfig_l);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_pluginCatalog_lock);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_unsealWithStoredKeysLock);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_allLoggersLock);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_raftFollowerStates_l);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_pendingRaftPeers_mu);
	run mutexMonitor(opts_DefaultHandlerProperties_Core_quotaManager_lock);
	run mutexMonitor(cluster_base_ReloadFuncsLock);
	run mutexMonitor(cluster_base_MetricsHelper_inMemSink_intervalLock);
	run mutexMonitor(addressProvider_Cluster_base_ReloadFuncsLock);
	run mutexMonitor(leaderCore_CoreConfig_ReloadFuncsLock);
	run mutexMonitor(leaderCore_CoreConfig_MetricsHelper_inMemSink_intervalLock);
	run mutexMonitor(leaderCore_Client_modifyLock);
	run mutexMonitor(leaderCore_Client_config_modifyLock);
	run mutexMonitor(leaderCore_Client_config_Limiter_mu);
	run mutexMonitor(leaderCore_ReloadFuncsLock);
	run mutexMonitor(leaderCore_Server_TLSConfig_mutex);
	run mutexMonitor(leaderCore_Server_ErrorLog_mu);
	run mutexMonitor(leaderCore_Server_nextProtoOnce_m);
	run mutexMonitor(leaderCore_Server_mu);
	run mutexMonitor(leaderCore_TLSConfig_mutex);
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

proctype receiver(chan c) {
c?0
}

