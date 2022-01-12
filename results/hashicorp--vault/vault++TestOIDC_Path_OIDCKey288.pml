// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob//vault/identity_store_oidc_test.go#L288
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
	chan child_TestOIDC_Path_OIDCKey2880 = [1] of {int};
	run TestOIDC_Path_OIDCKey288(child_TestOIDC_Path_OIDCKey2880);
	run receiver(child_TestOIDC_Path_OIDCKey2880)
stop_process:skip
}

proctype TestOIDC_Path_OIDCKey288(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef storage_once_m;
	Mutexdef c_quotaManager_lock;
	Mutexdef c_quotaManager_rateLimitPathManager_l;
	Mutexdef c_quotaManager_db_writer;
	Mutexdef c_pendingRaftPeers_mu;
	Mutexdef c_raftFollowerStates_l;
	Mutexdef c_metricsHelper_LoopMetrics_Metrics_mu;
	Mutexdef c_metricsHelper_inMemSink_intervalLock;
	Mutexdef c_allLoggersLock;
	Mutexdef c_unsealWithStoredKeysLock;
	Mutexdef c_pluginCatalog_lock;
	Mutexdef c_pluginCatalog_catalogView_readOnlyErrLock;
	Mutexdef c_uiConfig_l;
	Mutexdef c_rpcClientConn_firstResolveEvent_o_m;
	Mutexdef c_rpcClientConn_balancerWrapper_mu;
	Mutexdef c_rpcClientConn_balancerWrapper_scBuffer_mu;
	Mutexdef c_rpcClientConn_balancerWrapper_balancerMu;
	Mutexdef c_rpcClientConn_resolverWrapper_pollingMu;
	Mutexdef c_rpcClientConn_resolverWrapper_resolverMu;
	Mutexdef c_rpcClientConn_mu;
	Mutexdef c_rpcClientConn_blockingpicker_mu;
	Mutexdef c_rpcClientConn_csMgr_mu;
	Mutexdef c_leaderParamsLock;
	Mutexdef c_requestForwardingConnectionLock;
	Mutexdef c_clusterParamsLock;
	Mutexdef c_reloadFuncsLock;
	Mutexdef c_metricsMutex;
	Mutexdef c_activityLog_view_readOnlyErrLock;
	Mutexdef c_activityLog_fragmentLock;
	Mutexdef c_activityLog_l;
	Mutexdef c_identityStore_groupLock;
	Mutexdef c_identityStore_oidcLock;
	Mutexdef c_identityStore_lock;
	Mutexdef c_identityStore_db_writer;
	Mutexdef c_tokenStore_saltLock;
	Mutexdef c_tokenStore_tokensPendingDeletion_mu;
	Mutexdef c_tokenStore_activityLog_view_readOnlyErrLock;
	Mutexdef c_tokenStore_activityLog_fragmentLock;
	Mutexdef c_tokenStore_activityLog_l;
	Mutexdef c_tokenStore_expiration_jobManager_l;
	Wgdef c_tokenStore_expiration_jobManager_wg;
	Mutexdef c_tokenStore_expiration_restoreLoaded_mu;
	Mutexdef c_tokenStore_expiration_restoreRequestLock;
	Mutexdef c_tokenStore_expiration_restoreModeLock;
	Mutexdef c_tokenStore_expiration_pendingLock;
	Mutexdef c_tokenStore_expiration_nonexpiring_mu;
	Mutexdef c_tokenStore_expiration_pending_mu;
	Mutexdef c_tokenStore_expiration_tokenView_readOnlyErrLock;
	Mutexdef c_tokenStore_expiration_idView_readOnlyErrLock;
	Mutexdef c_tokenStore_expiration_router_l;
	Mutexdef c_tokenStore_rolesBarrierView_readOnlyErrLock;
	Mutexdef c_tokenStore_parentBarrierView_readOnlyErrLock;
	Mutexdef c_tokenStore_accessorBarrierView_readOnlyErrLock;
	Mutexdef c_tokenStore_idBarrierView_readOnlyErrLock;
	Mutexdef c_tokenStore_baseBarrierView_readOnlyErrLock;
	Mutexdef c_policyStore_policyTypeMap_mu;
	Mutexdef c_policyStore_modifyLock;
	Mutexdef c_policyStore_egpLRU_lock;
	Mutexdef c_policyStore_tokenPoliciesLRU_lock;
	Mutexdef c_policyStore_egpView_readOnlyErrLock;
	Mutexdef c_policyStore_rgpView_readOnlyErrLock;
	Mutexdef c_policyStore_aclView_readOnlyErrLock;
	Mutexdef c_rollback_shutdownLock;
	Mutexdef c_rollback_inflightLock;
	Wgdef c_rollback_inflightAll;
	Mutexdef c_rollback_router_l;
	Mutexdef c_expiration_jobManager_l;
	Wgdef c_expiration_jobManager_wg;
	Mutexdef c_expiration_jobManager_onceStop_m;
	Mutexdef c_expiration_jobManager_onceStart_m;
	Wgdef c_expiration_jobManager_workerPool_wg;
	Mutexdef c_expiration_restoreLoaded_mu;
	Mutexdef c_expiration_restoreRequestLock;
	Mutexdef c_expiration_restoreModeLock;
	Mutexdef c_expiration_pendingLock;
	Mutexdef c_expiration_nonexpiring_mu;
	Mutexdef c_expiration_pending_mu;
	Mutexdef c_expiration_tokenStore_saltLock;
	Mutexdef c_expiration_tokenStore_tokensPendingDeletion_mu;
	Mutexdef c_expiration_tokenStore_activityLog_fragmentLock;
	Mutexdef c_expiration_tokenStore_activityLog_l;
	Mutexdef c_expiration_tokenStore_rolesBarrierView_readOnlyErrLock;
	Mutexdef c_expiration_tokenStore_parentBarrierView_readOnlyErrLock;
	Mutexdef c_expiration_tokenStore_accessorBarrierView_readOnlyErrLock;
	Mutexdef c_expiration_tokenStore_idBarrierView_readOnlyErrLock;
	Mutexdef c_expiration_tokenStore_baseBarrierView_readOnlyErrLock;
	Mutexdef c_expiration_tokenView_readOnlyErrLock;
	Mutexdef c_expiration_idView_readOnlyErrLock;
	Mutexdef c_expiration_router_l;
	Mutexdef c_systemBarrierView_readOnlyErrLock;
	Mutexdef c_systemBackend_mfaLock;
	Mutexdef c_systemBackend_db_writer;
	Mutexdef c_auditedHeaders_view_readOnlyErrLock;
	Mutexdef c_auditLock;
	Mutexdef c_authLock;
	Mutexdef c_mountsLock;
	Mutexdef c_rekeyLock;
	Mutexdef c_generateRootLock;
	Mutexdef c_router_l;
	Mutexdef c_raftInfo_leaderClient_config_modifyLock;
	Mutexdef c_raftInfo_leaderClient_modifyLock;
	run mutexMonitor(c_raftInfo_leaderClient_modifyLock);
	run mutexMonitor(c_raftInfo_leaderClient_config_modifyLock);
	run mutexMonitor(c_router_l);
	run mutexMonitor(c_generateRootLock);
	run mutexMonitor(c_rekeyLock);
	run mutexMonitor(c_mountsLock);
	run mutexMonitor(c_authLock);
	run mutexMonitor(c_auditLock);
	run mutexMonitor(c_auditedHeaders_view_readOnlyErrLock);
	run mutexMonitor(c_systemBackend_db_writer);
	run mutexMonitor(c_systemBackend_mfaLock);
	run mutexMonitor(c_systemBarrierView_readOnlyErrLock);
	run mutexMonitor(c_expiration_router_l);
	run mutexMonitor(c_expiration_idView_readOnlyErrLock);
	run mutexMonitor(c_expiration_tokenView_readOnlyErrLock);
	run mutexMonitor(c_expiration_tokenStore_baseBarrierView_readOnlyErrLock);
	run mutexMonitor(c_expiration_tokenStore_idBarrierView_readOnlyErrLock);
	run mutexMonitor(c_expiration_tokenStore_accessorBarrierView_readOnlyErrLock);
	run mutexMonitor(c_expiration_tokenStore_parentBarrierView_readOnlyErrLock);
	run mutexMonitor(c_expiration_tokenStore_rolesBarrierView_readOnlyErrLock);
	run mutexMonitor(c_expiration_tokenStore_activityLog_l);
	run mutexMonitor(c_expiration_tokenStore_activityLog_fragmentLock);
	run mutexMonitor(c_expiration_tokenStore_tokensPendingDeletion_mu);
	run mutexMonitor(c_expiration_tokenStore_saltLock);
	run mutexMonitor(c_expiration_pending_mu);
	run mutexMonitor(c_expiration_nonexpiring_mu);
	run mutexMonitor(c_expiration_pendingLock);
	run mutexMonitor(c_expiration_restoreModeLock);
	run mutexMonitor(c_expiration_restoreRequestLock);
	run mutexMonitor(c_expiration_restoreLoaded_mu);
	run wgMonitor(c_expiration_jobManager_workerPool_wg);
	run mutexMonitor(c_expiration_jobManager_onceStart_m);
	run mutexMonitor(c_expiration_jobManager_onceStop_m);
	run wgMonitor(c_expiration_jobManager_wg);
	run mutexMonitor(c_expiration_jobManager_l);
	run mutexMonitor(c_rollback_router_l);
	run wgMonitor(c_rollback_inflightAll);
	run mutexMonitor(c_rollback_inflightLock);
	run mutexMonitor(c_rollback_shutdownLock);
	run mutexMonitor(c_policyStore_aclView_readOnlyErrLock);
	run mutexMonitor(c_policyStore_rgpView_readOnlyErrLock);
	run mutexMonitor(c_policyStore_egpView_readOnlyErrLock);
	run mutexMonitor(c_policyStore_tokenPoliciesLRU_lock);
	run mutexMonitor(c_policyStore_egpLRU_lock);
	run mutexMonitor(c_policyStore_modifyLock);
	run mutexMonitor(c_policyStore_policyTypeMap_mu);
	run mutexMonitor(c_tokenStore_baseBarrierView_readOnlyErrLock);
	run mutexMonitor(c_tokenStore_idBarrierView_readOnlyErrLock);
	run mutexMonitor(c_tokenStore_accessorBarrierView_readOnlyErrLock);
	run mutexMonitor(c_tokenStore_parentBarrierView_readOnlyErrLock);
	run mutexMonitor(c_tokenStore_rolesBarrierView_readOnlyErrLock);
	run mutexMonitor(c_tokenStore_expiration_router_l);
	run mutexMonitor(c_tokenStore_expiration_idView_readOnlyErrLock);
	run mutexMonitor(c_tokenStore_expiration_tokenView_readOnlyErrLock);
	run mutexMonitor(c_tokenStore_expiration_pending_mu);
	run mutexMonitor(c_tokenStore_expiration_nonexpiring_mu);
	run mutexMonitor(c_tokenStore_expiration_pendingLock);
	run mutexMonitor(c_tokenStore_expiration_restoreModeLock);
	run mutexMonitor(c_tokenStore_expiration_restoreRequestLock);
	run mutexMonitor(c_tokenStore_expiration_restoreLoaded_mu);
	run wgMonitor(c_tokenStore_expiration_jobManager_wg);
	run mutexMonitor(c_tokenStore_expiration_jobManager_l);
	run mutexMonitor(c_tokenStore_activityLog_l);
	run mutexMonitor(c_tokenStore_activityLog_fragmentLock);
	run mutexMonitor(c_tokenStore_activityLog_view_readOnlyErrLock);
	run mutexMonitor(c_tokenStore_tokensPendingDeletion_mu);
	run mutexMonitor(c_tokenStore_saltLock);
	run mutexMonitor(c_identityStore_db_writer);
	run mutexMonitor(c_identityStore_lock);
	run mutexMonitor(c_identityStore_oidcLock);
	run mutexMonitor(c_identityStore_groupLock);
	run mutexMonitor(c_activityLog_l);
	run mutexMonitor(c_activityLog_fragmentLock);
	run mutexMonitor(c_activityLog_view_readOnlyErrLock);
	run mutexMonitor(c_metricsMutex);
	run mutexMonitor(c_reloadFuncsLock);
	run mutexMonitor(c_clusterParamsLock);
	run mutexMonitor(c_requestForwardingConnectionLock);
	run mutexMonitor(c_leaderParamsLock);
	run mutexMonitor(c_rpcClientConn_csMgr_mu);
	run mutexMonitor(c_rpcClientConn_blockingpicker_mu);
	run mutexMonitor(c_rpcClientConn_mu);
	run mutexMonitor(c_rpcClientConn_resolverWrapper_resolverMu);
	run mutexMonitor(c_rpcClientConn_resolverWrapper_pollingMu);
	run mutexMonitor(c_rpcClientConn_balancerWrapper_balancerMu);
	run mutexMonitor(c_rpcClientConn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(c_rpcClientConn_balancerWrapper_mu);
	run mutexMonitor(c_rpcClientConn_firstResolveEvent_o_m);
	run mutexMonitor(c_uiConfig_l);
	run mutexMonitor(c_pluginCatalog_catalogView_readOnlyErrLock);
	run mutexMonitor(c_pluginCatalog_lock);
	run mutexMonitor(c_unsealWithStoredKeysLock);
	run mutexMonitor(c_allLoggersLock);
	run mutexMonitor(c_metricsHelper_inMemSink_intervalLock);
	run mutexMonitor(c_metricsHelper_LoopMetrics_Metrics_mu);
	run mutexMonitor(c_raftFollowerStates_l);
	run mutexMonitor(c_pendingRaftPeers_mu);
	run mutexMonitor(c_quotaManager_db_writer);
	run mutexMonitor(c_quotaManager_rateLimitPathManager_l);
	run mutexMonitor(c_quotaManager_lock);
	run mutexMonitor(storage_once_m);
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

