// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/hashicorp/vault/blob/f8f289712a3d37115090591602a2b92503fb3a13/vault/token_store_test.go#L2864
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
	chan child_TestTokenStore_HandleRequest_CreateToken_GlobPatternWildcardEntityAlias28640 = [1] of {int};
	run TestTokenStore_HandleRequest_CreateToken_GlobPatternWildcardEntityAlias2864(child_TestTokenStore_HandleRequest_CreateToken_GlobPatternWildcardEntityAlias28640);
	run receiver(child_TestTokenStore_HandleRequest_CreateToken_GlobPatternWildcardEntityAlias28640)
stop_process:skip
}

proctype TestTokenStore_HandleRequest_CreateToken_GlobPatternWildcardEntityAlias2864(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef i_core_allLoggersLock;
	Mutexdef i_core_unsealWithStoredKeysLock;
	Mutexdef i_core_leaderParamsLock;
	Mutexdef i_core_requestForwardingConnectionLock;
	Mutexdef i_core_clusterParamsLock;
	Mutexdef i_core_reloadFuncsLock;
	Mutexdef i_core_metricsMutex;
	Mutexdef i_core_auditLock;
	Mutexdef i_core_authLock;
	Mutexdef i_core_mountsLock;
	Mutexdef i_core_rekeyLock;
	Mutexdef i_core_generateRootLock;
	Mutexdef i_groupLock;
	Mutexdef i_oidcLock;
	Mutexdef i_lock;
	Mutexdef i_db_writer;
	Mutexdef core_quotaManager_lock;
	Mutexdef core_pendingRaftPeers_mu;
	Mutexdef core_raftFollowerStates_l;
	Mutexdef core_allLoggersLock;
	Mutexdef core_unsealWithStoredKeysLock;
	Mutexdef core_pluginCatalog_lock;
	Mutexdef core_uiConfig_l;
	Mutexdef core_rpcClientConn_mu;
	Mutexdef core_leaderParamsLock;
	Mutexdef core_requestForwardingConnectionLock;
	Mutexdef core_clusterParamsLock;
	Mutexdef core_reloadFuncsLock;
	Mutexdef core_metricsMutex;
	Mutexdef core_activityLog_fragmentLock;
	Mutexdef core_activityLog_l;
	Mutexdef core_identityStore_groupLock;
	Mutexdef core_identityStore_oidcLock;
	Mutexdef core_identityStore_lock;
	Mutexdef core_tokenStore_saltLock;
	Mutexdef core_policyStore_modifyLock;
	Mutexdef core_rollback_shutdownLock;
	Mutexdef core_rollback_inflightLock;
	Wgdef core_rollback_inflightAll;
	Mutexdef core_expiration_restoreRequestLock;
	Mutexdef core_expiration_restoreModeLock;
	Mutexdef core_expiration_pendingLock;
	Mutexdef core_systemBarrierView_readOnlyErrLock;
	Mutexdef core_systemBackend_mfaLock;
	Mutexdef core_auditLock;
	Mutexdef core_authLock;
	Mutexdef core_mountsLock;
	Mutexdef core_rekeyLock;
	Mutexdef core_generateRootLock;
	Mutexdef core_router_l;
	int tests = -2; // opt tests
	run mutexMonitor(core_router_l);
	run mutexMonitor(core_generateRootLock);
	run mutexMonitor(core_rekeyLock);
	run mutexMonitor(core_mountsLock);
	run mutexMonitor(core_authLock);
	run mutexMonitor(core_auditLock);
	run mutexMonitor(core_systemBackend_mfaLock);
	run mutexMonitor(core_systemBarrierView_readOnlyErrLock);
	run mutexMonitor(core_expiration_pendingLock);
	run mutexMonitor(core_expiration_restoreModeLock);
	run mutexMonitor(core_expiration_restoreRequestLock);
	run wgMonitor(core_rollback_inflightAll);
	run mutexMonitor(core_rollback_inflightLock);
	run mutexMonitor(core_rollback_shutdownLock);
	run mutexMonitor(core_policyStore_modifyLock);
	run mutexMonitor(core_tokenStore_saltLock);
	run mutexMonitor(core_identityStore_lock);
	run mutexMonitor(core_identityStore_oidcLock);
	run mutexMonitor(core_identityStore_groupLock);
	run mutexMonitor(core_activityLog_l);
	run mutexMonitor(core_activityLog_fragmentLock);
	run mutexMonitor(core_metricsMutex);
	run mutexMonitor(core_reloadFuncsLock);
	run mutexMonitor(core_clusterParamsLock);
	run mutexMonitor(core_requestForwardingConnectionLock);
	run mutexMonitor(core_leaderParamsLock);
	run mutexMonitor(core_rpcClientConn_mu);
	run mutexMonitor(core_uiConfig_l);
	run mutexMonitor(core_pluginCatalog_lock);
	run mutexMonitor(core_unsealWithStoredKeysLock);
	run mutexMonitor(core_allLoggersLock);
	run mutexMonitor(core_raftFollowerStates_l);
	run mutexMonitor(core_pendingRaftPeers_mu);
	run mutexMonitor(core_quotaManager_lock);
	run mutexMonitor(i_db_writer);
	run mutexMonitor(i_lock);
	run mutexMonitor(i_oidcLock);
	run mutexMonitor(i_groupLock);
	run mutexMonitor(i_core_generateRootLock);
	run mutexMonitor(i_core_rekeyLock);
	run mutexMonitor(i_core_mountsLock);
	run mutexMonitor(i_core_authLock);
	run mutexMonitor(i_core_auditLock);
	run mutexMonitor(i_core_metricsMutex);
	run mutexMonitor(i_core_reloadFuncsLock);
	run mutexMonitor(i_core_clusterParamsLock);
	run mutexMonitor(i_core_requestForwardingConnectionLock);
	run mutexMonitor(i_core_leaderParamsLock);
	run mutexMonitor(i_core_unsealWithStoredKeysLock);
	run mutexMonitor(i_core_allLoggersLock);
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

