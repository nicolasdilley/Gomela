// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob//vault/external_tests/sealmigration/testshared.go#L66
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
	chan child_ParamTestSealMigrationShamirToTransit_Pre14660 = [1] of {int};
	run ParamTestSealMigrationShamirToTransit_Pre1466(child_ParamTestSealMigrationShamirToTransit_Pre14660);
	run receiver(child_ParamTestSealMigrationShamirToTransit_Pre14660)
stop_process:skip
}

proctype ParamTestSealMigrationShamirToTransit_Pre1466(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef __DefaultHandlerProperties_Core_quotaManager_lock;
	Mutexdef __DefaultHandlerProperties_Core_pendingRaftPeers_mu;
	Mutexdef __DefaultHandlerProperties_Core_raftFollowerStates_l;
	Mutexdef __DefaultHandlerProperties_Core_allLoggersLock;
	Mutexdef __DefaultHandlerProperties_Core_unsealWithStoredKeysLock;
	Mutexdef __DefaultHandlerProperties_Core_pluginCatalog_lock;
	Mutexdef __DefaultHandlerProperties_Core_uiConfig_l;
	Mutexdef __DefaultHandlerProperties_Core_rpcClientConn_mu;
	Mutexdef __DefaultHandlerProperties_Core_leaderParamsLock;
	Mutexdef __DefaultHandlerProperties_Core_requestForwardingConnectionLock;
	Mutexdef __DefaultHandlerProperties_Core_clusterParamsLock;
	Mutexdef __DefaultHandlerProperties_Core_reloadFuncsLock;
	Mutexdef __DefaultHandlerProperties_Core_metricsMutex;
	Mutexdef __DefaultHandlerProperties_Core_activityLog_fragmentLock;
	Mutexdef __DefaultHandlerProperties_Core_activityLog_l;
	Mutexdef __DefaultHandlerProperties_Core_identityStore_groupLock;
	Mutexdef __DefaultHandlerProperties_Core_identityStore_oidcLock;
	Mutexdef __DefaultHandlerProperties_Core_identityStore_lock;
	Mutexdef __DefaultHandlerProperties_Core_tokenStore_saltLock;
	Mutexdef __DefaultHandlerProperties_Core_policyStore_modifyLock;
	Mutexdef __DefaultHandlerProperties_Core_rollback_shutdownLock;
	Mutexdef __DefaultHandlerProperties_Core_rollback_inflightLock;
	Wgdef __DefaultHandlerProperties_Core_rollback_inflightAll;
	Mutexdef __DefaultHandlerProperties_Core_expiration_restoreRequestLock;
	Mutexdef __DefaultHandlerProperties_Core_expiration_restoreModeLock;
	Mutexdef __DefaultHandlerProperties_Core_expiration_pendingLock;
	Mutexdef __DefaultHandlerProperties_Core_systemBarrierView_readOnlyErrLock;
	Mutexdef __DefaultHandlerProperties_Core_systemBackend_mfaLock;
	Mutexdef __DefaultHandlerProperties_Core_auditLock;
	Mutexdef __DefaultHandlerProperties_Core_authLock;
	Mutexdef __DefaultHandlerProperties_Core_mountsLock;
	Mutexdef __DefaultHandlerProperties_Core_rekeyLock;
	Mutexdef __DefaultHandlerProperties_Core_generateRootLock;
	Mutexdef __DefaultHandlerProperties_Core_router_l;
	Mutexdef cluster_base_MetricsHelper_inMemSink_intervalLock;
	Mutexdef cluster_base_ReloadFuncsLock;
	run mutexMonitor(cluster_base_ReloadFuncsLock);
	run mutexMonitor(cluster_base_MetricsHelper_inMemSink_intervalLock);
	run mutexMonitor(__DefaultHandlerProperties_Core_router_l);
	run mutexMonitor(__DefaultHandlerProperties_Core_generateRootLock);
	run mutexMonitor(__DefaultHandlerProperties_Core_rekeyLock);
	run mutexMonitor(__DefaultHandlerProperties_Core_mountsLock);
	run mutexMonitor(__DefaultHandlerProperties_Core_authLock);
	run mutexMonitor(__DefaultHandlerProperties_Core_auditLock);
	run mutexMonitor(__DefaultHandlerProperties_Core_systemBackend_mfaLock);
	run mutexMonitor(__DefaultHandlerProperties_Core_systemBarrierView_readOnlyErrLock);
	run mutexMonitor(__DefaultHandlerProperties_Core_expiration_pendingLock);
	run mutexMonitor(__DefaultHandlerProperties_Core_expiration_restoreModeLock);
	run mutexMonitor(__DefaultHandlerProperties_Core_expiration_restoreRequestLock);
	run wgMonitor(__DefaultHandlerProperties_Core_rollback_inflightAll);
	run mutexMonitor(__DefaultHandlerProperties_Core_rollback_inflightLock);
	run mutexMonitor(__DefaultHandlerProperties_Core_rollback_shutdownLock);
	run mutexMonitor(__DefaultHandlerProperties_Core_policyStore_modifyLock);
	run mutexMonitor(__DefaultHandlerProperties_Core_tokenStore_saltLock);
	run mutexMonitor(__DefaultHandlerProperties_Core_identityStore_lock);
	run mutexMonitor(__DefaultHandlerProperties_Core_identityStore_oidcLock);
	run mutexMonitor(__DefaultHandlerProperties_Core_identityStore_groupLock);
	run mutexMonitor(__DefaultHandlerProperties_Core_activityLog_l);
	run mutexMonitor(__DefaultHandlerProperties_Core_activityLog_fragmentLock);
	run mutexMonitor(__DefaultHandlerProperties_Core_metricsMutex);
	run mutexMonitor(__DefaultHandlerProperties_Core_reloadFuncsLock);
	run mutexMonitor(__DefaultHandlerProperties_Core_clusterParamsLock);
	run mutexMonitor(__DefaultHandlerProperties_Core_requestForwardingConnectionLock);
	run mutexMonitor(__DefaultHandlerProperties_Core_leaderParamsLock);
	run mutexMonitor(__DefaultHandlerProperties_Core_rpcClientConn_mu);
	run mutexMonitor(__DefaultHandlerProperties_Core_uiConfig_l);
	run mutexMonitor(__DefaultHandlerProperties_Core_pluginCatalog_lock);
	run mutexMonitor(__DefaultHandlerProperties_Core_unsealWithStoredKeysLock);
	run mutexMonitor(__DefaultHandlerProperties_Core_allLoggersLock);
	run mutexMonitor(__DefaultHandlerProperties_Core_raftFollowerStates_l);
	run mutexMonitor(__DefaultHandlerProperties_Core_pendingRaftPeers_mu);
	run mutexMonitor(__DefaultHandlerProperties_Core_quotaManager_lock);
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

