// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob//vault/identity_store_entities_test.go#L600
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
	chan child_TestIdentityStore_ListEntities6000 = [1] of {int};
	run TestIdentityStore_ListEntities600(child_TestIdentityStore_ListEntities6000);
	run receiver(child_TestIdentityStore_ListEntities6000)
stop_process:skip
}

proctype TestIdentityStore_ListEntities600(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef __quotaManager_lock;
	Mutexdef __quotaManager_rateLimitPathManager_l;
	Mutexdef __quotaManager_db_writer;
	Mutexdef __pendingRaftPeers_mu;
	Mutexdef __raftFollowerStates_l;
	Mutexdef __metricsHelper_LoopMetrics_Metrics_mu;
	Mutexdef __metricsHelper_inMemSink_intervalLock;
	Mutexdef __allLoggersLock;
	Mutexdef __unsealWithStoredKeysLock;
	Mutexdef __pluginCatalog_lock;
	Mutexdef __pluginCatalog_catalogView_readOnlyErrLock;
	Mutexdef __uiConfig_l;
	Mutexdef __rpcClientConn_firstResolveEvent_o_m;
	Mutexdef __rpcClientConn_balancerWrapper_mu;
	Mutexdef __rpcClientConn_balancerWrapper_scBuffer_mu;
	Mutexdef __rpcClientConn_balancerWrapper_balancerMu;
	Mutexdef __rpcClientConn_resolverWrapper_pollingMu;
	Mutexdef __rpcClientConn_resolverWrapper_resolverMu;
	Mutexdef __rpcClientConn_mu;
	Mutexdef __rpcClientConn_blockingpicker_mu;
	Mutexdef __rpcClientConn_csMgr_mu;
	Mutexdef __leaderParamsLock;
	Mutexdef __requestForwardingConnectionLock;
	Mutexdef __clusterParamsLock;
	Mutexdef __reloadFuncsLock;
	Mutexdef __metricsMutex;
	Mutexdef __activityLog_view_readOnlyErrLock;
	Mutexdef __activityLog_fragmentLock;
	Mutexdef __activityLog_l;
	Mutexdef __identityStore_groupLock;
	Mutexdef __identityStore_oidcLock;
	Mutexdef __identityStore_lock;
	Mutexdef __identityStore_db_writer;
	Mutexdef __tokenStore_saltLock;
	Mutexdef __tokenStore_tokensPendingDeletion_mu;
	Mutexdef __tokenStore_activityLog_view_readOnlyErrLock;
	Mutexdef __tokenStore_activityLog_fragmentLock;
	Mutexdef __tokenStore_activityLog_l;
	Mutexdef __tokenStore_expiration_jobManager_l;
	Wgdef __tokenStore_expiration_jobManager_wg;
	Mutexdef __tokenStore_expiration_restoreLoaded_mu;
	Mutexdef __tokenStore_expiration_restoreRequestLock;
	Mutexdef __tokenStore_expiration_restoreModeLock;
	Mutexdef __tokenStore_expiration_pendingLock;
	Mutexdef __tokenStore_expiration_nonexpiring_mu;
	Mutexdef __tokenStore_expiration_pending_mu;
	Mutexdef __tokenStore_expiration_tokenView_readOnlyErrLock;
	Mutexdef __tokenStore_expiration_idView_readOnlyErrLock;
	Mutexdef __tokenStore_expiration_router_l;
	Mutexdef __tokenStore_rolesBarrierView_readOnlyErrLock;
	Mutexdef __tokenStore_parentBarrierView_readOnlyErrLock;
	Mutexdef __tokenStore_accessorBarrierView_readOnlyErrLock;
	Mutexdef __tokenStore_idBarrierView_readOnlyErrLock;
	Mutexdef __tokenStore_baseBarrierView_readOnlyErrLock;
	Mutexdef __policyStore_policyTypeMap_mu;
	Mutexdef __policyStore_modifyLock;
	Mutexdef __policyStore_egpLRU_lock;
	Mutexdef __policyStore_tokenPoliciesLRU_lock;
	Mutexdef __policyStore_egpView_readOnlyErrLock;
	Mutexdef __policyStore_rgpView_readOnlyErrLock;
	Mutexdef __policyStore_aclView_readOnlyErrLock;
	Mutexdef __rollback_shutdownLock;
	Mutexdef __rollback_inflightLock;
	Wgdef __rollback_inflightAll;
	Mutexdef __rollback_router_l;
	Mutexdef __expiration_jobManager_l;
	Wgdef __expiration_jobManager_wg;
	Mutexdef __expiration_jobManager_onceStop_m;
	Mutexdef __expiration_jobManager_onceStart_m;
	Wgdef __expiration_jobManager_workerPool_wg;
	Mutexdef __expiration_restoreLoaded_mu;
	Mutexdef __expiration_restoreRequestLock;
	Mutexdef __expiration_restoreModeLock;
	Mutexdef __expiration_pendingLock;
	Mutexdef __expiration_nonexpiring_mu;
	Mutexdef __expiration_pending_mu;
	Mutexdef __expiration_tokenStore_saltLock;
	Mutexdef __expiration_tokenStore_tokensPendingDeletion_mu;
	Mutexdef __expiration_tokenStore_activityLog_fragmentLock;
	Mutexdef __expiration_tokenStore_activityLog_l;
	Mutexdef __expiration_tokenStore_rolesBarrierView_readOnlyErrLock;
	Mutexdef __expiration_tokenStore_parentBarrierView_readOnlyErrLock;
	Mutexdef __expiration_tokenStore_accessorBarrierView_readOnlyErrLock;
	Mutexdef __expiration_tokenStore_idBarrierView_readOnlyErrLock;
	Mutexdef __expiration_tokenStore_baseBarrierView_readOnlyErrLock;
	Mutexdef __expiration_tokenView_readOnlyErrLock;
	Mutexdef __expiration_idView_readOnlyErrLock;
	Mutexdef __expiration_router_l;
	Mutexdef __systemBarrierView_readOnlyErrLock;
	Mutexdef __systemBackend_mfaLock;
	Mutexdef __systemBackend_db_writer;
	Mutexdef __auditedHeaders_view_readOnlyErrLock;
	Mutexdef __auditLock;
	Mutexdef __authLock;
	Mutexdef __mountsLock;
	Mutexdef __rekeyLock;
	Mutexdef __generateRootLock;
	Mutexdef __router_l;
	Mutexdef __raftInfo_leaderClient_config_modifyLock;
	Mutexdef __raftInfo_leaderClient_modifyLock;
	Mutexdef is_core_quotaManager_lock;
	Mutexdef is_core_quotaManager_rateLimitPathManager_l;
	Mutexdef is_core_quotaManager_db_writer;
	Mutexdef is_core_pendingRaftPeers_mu;
	Mutexdef is_core_raftFollowerStates_l;
	Mutexdef is_core_metricsHelper_inMemSink_intervalLock;
	Mutexdef is_core_allLoggersLock;
	Mutexdef is_core_unsealWithStoredKeysLock;
	Mutexdef is_core_pluginCatalog_lock;
	Mutexdef is_core_pluginCatalog_catalogView_readOnlyErrLock;
	Mutexdef is_core_uiConfig_l;
	Mutexdef is_core_rpcClientConn_balancerWrapper_mu;
	Mutexdef is_core_rpcClientConn_balancerWrapper_balancerMu;
	Mutexdef is_core_rpcClientConn_resolverWrapper_pollingMu;
	Mutexdef is_core_rpcClientConn_resolverWrapper_resolverMu;
	Mutexdef is_core_rpcClientConn_mu;
	Mutexdef is_core_rpcClientConn_blockingpicker_mu;
	Mutexdef is_core_rpcClientConn_csMgr_mu;
	Mutexdef is_core_leaderParamsLock;
	Mutexdef is_core_requestForwardingConnectionLock;
	Mutexdef is_core_clusterParamsLock;
	Mutexdef is_core_reloadFuncsLock;
	Mutexdef is_core_metricsMutex;
	Mutexdef is_core_activityLog_view_readOnlyErrLock;
	Mutexdef is_core_activityLog_fragmentLock;
	Mutexdef is_core_activityLog_l;
	Mutexdef is_core_tokenStore_saltLock;
	Mutexdef is_core_tokenStore_tokensPendingDeletion_mu;
	Mutexdef is_core_tokenStore_activityLog_fragmentLock;
	Mutexdef is_core_tokenStore_activityLog_l;
	Mutexdef is_core_tokenStore_expiration_restoreRequestLock;
	Mutexdef is_core_tokenStore_expiration_restoreModeLock;
	Mutexdef is_core_tokenStore_expiration_pendingLock;
	Mutexdef is_core_tokenStore_rolesBarrierView_readOnlyErrLock;
	Mutexdef is_core_tokenStore_parentBarrierView_readOnlyErrLock;
	Mutexdef is_core_tokenStore_accessorBarrierView_readOnlyErrLock;
	Mutexdef is_core_tokenStore_idBarrierView_readOnlyErrLock;
	Mutexdef is_core_tokenStore_baseBarrierView_readOnlyErrLock;
	Mutexdef is_core_policyStore_policyTypeMap_mu;
	Mutexdef is_core_policyStore_modifyLock;
	Mutexdef is_core_policyStore_egpLRU_lock;
	Mutexdef is_core_policyStore_tokenPoliciesLRU_lock;
	Mutexdef is_core_policyStore_egpView_readOnlyErrLock;
	Mutexdef is_core_policyStore_rgpView_readOnlyErrLock;
	Mutexdef is_core_policyStore_aclView_readOnlyErrLock;
	Mutexdef is_core_rollback_shutdownLock;
	Mutexdef is_core_rollback_inflightLock;
	Wgdef is_core_rollback_inflightAll;
	Mutexdef is_core_rollback_router_l;
	Mutexdef is_core_expiration_jobManager_l;
	Wgdef is_core_expiration_jobManager_wg;
	Mutexdef is_core_expiration_restoreLoaded_mu;
	Mutexdef is_core_expiration_restoreRequestLock;
	Mutexdef is_core_expiration_restoreModeLock;
	Mutexdef is_core_expiration_pendingLock;
	Mutexdef is_core_expiration_nonexpiring_mu;
	Mutexdef is_core_expiration_pending_mu;
	Mutexdef is_core_expiration_tokenStore_saltLock;
	Mutexdef is_core_expiration_tokenView_readOnlyErrLock;
	Mutexdef is_core_expiration_idView_readOnlyErrLock;
	Mutexdef is_core_expiration_router_l;
	Mutexdef is_core_systemBarrierView_readOnlyErrLock;
	Mutexdef is_core_systemBackend_mfaLock;
	Mutexdef is_core_systemBackend_db_writer;
	Mutexdef is_core_auditedHeaders_view_readOnlyErrLock;
	Mutexdef is_core_auditLock;
	Mutexdef is_core_authLock;
	Mutexdef is_core_mountsLock;
	Mutexdef is_core_rekeyLock;
	Mutexdef is_core_generateRootLock;
	Mutexdef is_core_router_l;
	Mutexdef is_core_raftInfo_leaderClient_modifyLock;
	Mutexdef is_groupLock;
	Mutexdef is_oidcLock;
	Mutexdef is_lock;
	Mutexdef is_db_writer;
	run mutexMonitor(is_db_writer);
	run mutexMonitor(is_lock);
	run mutexMonitor(is_oidcLock);
	run mutexMonitor(is_groupLock);
	run mutexMonitor(is_core_raftInfo_leaderClient_modifyLock);
	run mutexMonitor(is_core_router_l);
	run mutexMonitor(is_core_generateRootLock);
	run mutexMonitor(is_core_rekeyLock);
	run mutexMonitor(is_core_mountsLock);
	run mutexMonitor(is_core_authLock);
	run mutexMonitor(is_core_auditLock);
	run mutexMonitor(is_core_auditedHeaders_view_readOnlyErrLock);
	run mutexMonitor(is_core_systemBackend_db_writer);
	run mutexMonitor(is_core_systemBackend_mfaLock);
	run mutexMonitor(is_core_systemBarrierView_readOnlyErrLock);
	run mutexMonitor(is_core_expiration_router_l);
	run mutexMonitor(is_core_expiration_idView_readOnlyErrLock);
	run mutexMonitor(is_core_expiration_tokenView_readOnlyErrLock);
	run mutexMonitor(is_core_expiration_tokenStore_saltLock);
	run mutexMonitor(is_core_expiration_pending_mu);
	run mutexMonitor(is_core_expiration_nonexpiring_mu);
	run mutexMonitor(is_core_expiration_pendingLock);
	run mutexMonitor(is_core_expiration_restoreModeLock);
	run mutexMonitor(is_core_expiration_restoreRequestLock);
	run mutexMonitor(is_core_expiration_restoreLoaded_mu);
	run wgMonitor(is_core_expiration_jobManager_wg);
	run mutexMonitor(is_core_expiration_jobManager_l);
	run mutexMonitor(is_core_rollback_router_l);
	run wgMonitor(is_core_rollback_inflightAll);
	run mutexMonitor(is_core_rollback_inflightLock);
	run mutexMonitor(is_core_rollback_shutdownLock);
	run mutexMonitor(is_core_policyStore_aclView_readOnlyErrLock);
	run mutexMonitor(is_core_policyStore_rgpView_readOnlyErrLock);
	run mutexMonitor(is_core_policyStore_egpView_readOnlyErrLock);
	run mutexMonitor(is_core_policyStore_tokenPoliciesLRU_lock);
	run mutexMonitor(is_core_policyStore_egpLRU_lock);
	run mutexMonitor(is_core_policyStore_modifyLock);
	run mutexMonitor(is_core_policyStore_policyTypeMap_mu);
	run mutexMonitor(is_core_tokenStore_baseBarrierView_readOnlyErrLock);
	run mutexMonitor(is_core_tokenStore_idBarrierView_readOnlyErrLock);
	run mutexMonitor(is_core_tokenStore_accessorBarrierView_readOnlyErrLock);
	run mutexMonitor(is_core_tokenStore_parentBarrierView_readOnlyErrLock);
	run mutexMonitor(is_core_tokenStore_rolesBarrierView_readOnlyErrLock);
	run mutexMonitor(is_core_tokenStore_expiration_pendingLock);
	run mutexMonitor(is_core_tokenStore_expiration_restoreModeLock);
	run mutexMonitor(is_core_tokenStore_expiration_restoreRequestLock);
	run mutexMonitor(is_core_tokenStore_activityLog_l);
	run mutexMonitor(is_core_tokenStore_activityLog_fragmentLock);
	run mutexMonitor(is_core_tokenStore_tokensPendingDeletion_mu);
	run mutexMonitor(is_core_tokenStore_saltLock);
	run mutexMonitor(is_core_activityLog_l);
	run mutexMonitor(is_core_activityLog_fragmentLock);
	run mutexMonitor(is_core_activityLog_view_readOnlyErrLock);
	run mutexMonitor(is_core_metricsMutex);
	run mutexMonitor(is_core_reloadFuncsLock);
	run mutexMonitor(is_core_clusterParamsLock);
	run mutexMonitor(is_core_requestForwardingConnectionLock);
	run mutexMonitor(is_core_leaderParamsLock);
	run mutexMonitor(is_core_rpcClientConn_csMgr_mu);
	run mutexMonitor(is_core_rpcClientConn_blockingpicker_mu);
	run mutexMonitor(is_core_rpcClientConn_mu);
	run mutexMonitor(is_core_rpcClientConn_resolverWrapper_resolverMu);
	run mutexMonitor(is_core_rpcClientConn_resolverWrapper_pollingMu);
	run mutexMonitor(is_core_rpcClientConn_balancerWrapper_balancerMu);
	run mutexMonitor(is_core_rpcClientConn_balancerWrapper_mu);
	run mutexMonitor(is_core_uiConfig_l);
	run mutexMonitor(is_core_pluginCatalog_catalogView_readOnlyErrLock);
	run mutexMonitor(is_core_pluginCatalog_lock);
	run mutexMonitor(is_core_unsealWithStoredKeysLock);
	run mutexMonitor(is_core_allLoggersLock);
	run mutexMonitor(is_core_metricsHelper_inMemSink_intervalLock);
	run mutexMonitor(is_core_raftFollowerStates_l);
	run mutexMonitor(is_core_pendingRaftPeers_mu);
	run mutexMonitor(is_core_quotaManager_db_writer);
	run mutexMonitor(is_core_quotaManager_rateLimitPathManager_l);
	run mutexMonitor(is_core_quotaManager_lock);
	run mutexMonitor(__raftInfo_leaderClient_modifyLock);
	run mutexMonitor(__raftInfo_leaderClient_config_modifyLock);
	run mutexMonitor(__router_l);
	run mutexMonitor(__generateRootLock);
	run mutexMonitor(__rekeyLock);
	run mutexMonitor(__mountsLock);
	run mutexMonitor(__authLock);
	run mutexMonitor(__auditLock);
	run mutexMonitor(__auditedHeaders_view_readOnlyErrLock);
	run mutexMonitor(__systemBackend_db_writer);
	run mutexMonitor(__systemBackend_mfaLock);
	run mutexMonitor(__systemBarrierView_readOnlyErrLock);
	run mutexMonitor(__expiration_router_l);
	run mutexMonitor(__expiration_idView_readOnlyErrLock);
	run mutexMonitor(__expiration_tokenView_readOnlyErrLock);
	run mutexMonitor(__expiration_tokenStore_baseBarrierView_readOnlyErrLock);
	run mutexMonitor(__expiration_tokenStore_idBarrierView_readOnlyErrLock);
	run mutexMonitor(__expiration_tokenStore_accessorBarrierView_readOnlyErrLock);
	run mutexMonitor(__expiration_tokenStore_parentBarrierView_readOnlyErrLock);
	run mutexMonitor(__expiration_tokenStore_rolesBarrierView_readOnlyErrLock);
	run mutexMonitor(__expiration_tokenStore_activityLog_l);
	run mutexMonitor(__expiration_tokenStore_activityLog_fragmentLock);
	run mutexMonitor(__expiration_tokenStore_tokensPendingDeletion_mu);
	run mutexMonitor(__expiration_tokenStore_saltLock);
	run mutexMonitor(__expiration_pending_mu);
	run mutexMonitor(__expiration_nonexpiring_mu);
	run mutexMonitor(__expiration_pendingLock);
	run mutexMonitor(__expiration_restoreModeLock);
	run mutexMonitor(__expiration_restoreRequestLock);
	run mutexMonitor(__expiration_restoreLoaded_mu);
	run wgMonitor(__expiration_jobManager_workerPool_wg);
	run mutexMonitor(__expiration_jobManager_onceStart_m);
	run mutexMonitor(__expiration_jobManager_onceStop_m);
	run wgMonitor(__expiration_jobManager_wg);
	run mutexMonitor(__expiration_jobManager_l);
	run mutexMonitor(__rollback_router_l);
	run wgMonitor(__rollback_inflightAll);
	run mutexMonitor(__rollback_inflightLock);
	run mutexMonitor(__rollback_shutdownLock);
	run mutexMonitor(__policyStore_aclView_readOnlyErrLock);
	run mutexMonitor(__policyStore_rgpView_readOnlyErrLock);
	run mutexMonitor(__policyStore_egpView_readOnlyErrLock);
	run mutexMonitor(__policyStore_tokenPoliciesLRU_lock);
	run mutexMonitor(__policyStore_egpLRU_lock);
	run mutexMonitor(__policyStore_modifyLock);
	run mutexMonitor(__policyStore_policyTypeMap_mu);
	run mutexMonitor(__tokenStore_baseBarrierView_readOnlyErrLock);
	run mutexMonitor(__tokenStore_idBarrierView_readOnlyErrLock);
	run mutexMonitor(__tokenStore_accessorBarrierView_readOnlyErrLock);
	run mutexMonitor(__tokenStore_parentBarrierView_readOnlyErrLock);
	run mutexMonitor(__tokenStore_rolesBarrierView_readOnlyErrLock);
	run mutexMonitor(__tokenStore_expiration_router_l);
	run mutexMonitor(__tokenStore_expiration_idView_readOnlyErrLock);
	run mutexMonitor(__tokenStore_expiration_tokenView_readOnlyErrLock);
	run mutexMonitor(__tokenStore_expiration_pending_mu);
	run mutexMonitor(__tokenStore_expiration_nonexpiring_mu);
	run mutexMonitor(__tokenStore_expiration_pendingLock);
	run mutexMonitor(__tokenStore_expiration_restoreModeLock);
	run mutexMonitor(__tokenStore_expiration_restoreRequestLock);
	run mutexMonitor(__tokenStore_expiration_restoreLoaded_mu);
	run wgMonitor(__tokenStore_expiration_jobManager_wg);
	run mutexMonitor(__tokenStore_expiration_jobManager_l);
	run mutexMonitor(__tokenStore_activityLog_l);
	run mutexMonitor(__tokenStore_activityLog_fragmentLock);
	run mutexMonitor(__tokenStore_activityLog_view_readOnlyErrLock);
	run mutexMonitor(__tokenStore_tokensPendingDeletion_mu);
	run mutexMonitor(__tokenStore_saltLock);
	run mutexMonitor(__identityStore_db_writer);
	run mutexMonitor(__identityStore_lock);
	run mutexMonitor(__identityStore_oidcLock);
	run mutexMonitor(__identityStore_groupLock);
	run mutexMonitor(__activityLog_l);
	run mutexMonitor(__activityLog_fragmentLock);
	run mutexMonitor(__activityLog_view_readOnlyErrLock);
	run mutexMonitor(__metricsMutex);
	run mutexMonitor(__reloadFuncsLock);
	run mutexMonitor(__clusterParamsLock);
	run mutexMonitor(__requestForwardingConnectionLock);
	run mutexMonitor(__leaderParamsLock);
	run mutexMonitor(__rpcClientConn_csMgr_mu);
	run mutexMonitor(__rpcClientConn_blockingpicker_mu);
	run mutexMonitor(__rpcClientConn_mu);
	run mutexMonitor(__rpcClientConn_resolverWrapper_resolverMu);
	run mutexMonitor(__rpcClientConn_resolverWrapper_pollingMu);
	run mutexMonitor(__rpcClientConn_balancerWrapper_balancerMu);
	run mutexMonitor(__rpcClientConn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(__rpcClientConn_balancerWrapper_mu);
	run mutexMonitor(__rpcClientConn_firstResolveEvent_o_m);
	run mutexMonitor(__uiConfig_l);
	run mutexMonitor(__pluginCatalog_catalogView_readOnlyErrLock);
	run mutexMonitor(__pluginCatalog_lock);
	run mutexMonitor(__unsealWithStoredKeysLock);
	run mutexMonitor(__allLoggersLock);
	run mutexMonitor(__metricsHelper_inMemSink_intervalLock);
	run mutexMonitor(__metricsHelper_LoopMetrics_Metrics_mu);
	run mutexMonitor(__raftFollowerStates_l);
	run mutexMonitor(__pendingRaftPeers_mu);
	run mutexMonitor(__quotaManager_db_writer);
	run mutexMonitor(__quotaManager_rateLimitPathManager_l);
	run mutexMonitor(__quotaManager_lock);
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
