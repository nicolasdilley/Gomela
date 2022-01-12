// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob//vault/dynamic_system_view_test.go#L159
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
	chan child_TestDynamicSystemView_GeneratePasswordFromPolicy_successful1590 = [1] of {int};
	run TestDynamicSystemView_GeneratePasswordFromPolicy_successful159(child_TestDynamicSystemView_GeneratePasswordFromPolicy_successful1590);
	run receiver(child_TestDynamicSystemView_GeneratePasswordFromPolicy_successful1590)
stop_process:skip
}

proctype TestDynamicSystemView_GeneratePasswordFromPolicy_successful159(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GeneratePasswordFromPolicy3321 = [1] of {int};
	chan child_GeneratePasswordFromPolicy3320 = [1] of {int};
	Mutexdef dsv_mountEntry_synthesizedConfigCache_mu;
	Mutexdef dsv_core_quotaManager_lock;
	Mutexdef dsv_core_quotaManager_rateLimitPathManager_l;
	Mutexdef dsv_core_quotaManager_db_writer;
	Mutexdef dsv_core_pendingRaftPeers_mu;
	Mutexdef dsv_core_raftFollowerStates_l;
	Mutexdef dsv_core_metricsHelper_inMemSink_intervalLock;
	Mutexdef dsv_core_allLoggersLock;
	Mutexdef dsv_core_unsealWithStoredKeysLock;
	Mutexdef dsv_core_pluginCatalog_lock;
	Mutexdef dsv_core_pluginCatalog_catalogView_readOnlyErrLock;
	Mutexdef dsv_core_uiConfig_l;
	Mutexdef dsv_core_rpcClientConn_balancerWrapper_mu;
	Mutexdef dsv_core_rpcClientConn_balancerWrapper_balancerMu;
	Mutexdef dsv_core_rpcClientConn_resolverWrapper_pollingMu;
	Mutexdef dsv_core_rpcClientConn_resolverWrapper_resolverMu;
	Mutexdef dsv_core_rpcClientConn_mu;
	Mutexdef dsv_core_rpcClientConn_blockingpicker_mu;
	Mutexdef dsv_core_rpcClientConn_csMgr_mu;
	Mutexdef dsv_core_leaderParamsLock;
	Mutexdef dsv_core_requestForwardingConnectionLock;
	Mutexdef dsv_core_clusterParamsLock;
	Mutexdef dsv_core_reloadFuncsLock;
	Mutexdef dsv_core_metricsMutex;
	Mutexdef dsv_core_activityLog_view_readOnlyErrLock;
	Mutexdef dsv_core_activityLog_fragmentLock;
	Mutexdef dsv_core_activityLog_l;
	Mutexdef dsv_core_identityStore_groupLock;
	Mutexdef dsv_core_identityStore_oidcLock;
	Mutexdef dsv_core_identityStore_lock;
	Mutexdef dsv_core_identityStore_db_writer;
	Mutexdef dsv_core_tokenStore_saltLock;
	Mutexdef dsv_core_tokenStore_tokensPendingDeletion_mu;
	Mutexdef dsv_core_tokenStore_activityLog_fragmentLock;
	Mutexdef dsv_core_tokenStore_activityLog_l;
	Mutexdef dsv_core_tokenStore_expiration_restoreRequestLock;
	Mutexdef dsv_core_tokenStore_expiration_restoreModeLock;
	Mutexdef dsv_core_tokenStore_expiration_pendingLock;
	Mutexdef dsv_core_tokenStore_rolesBarrierView_readOnlyErrLock;
	Mutexdef dsv_core_tokenStore_parentBarrierView_readOnlyErrLock;
	Mutexdef dsv_core_tokenStore_accessorBarrierView_readOnlyErrLock;
	Mutexdef dsv_core_tokenStore_idBarrierView_readOnlyErrLock;
	Mutexdef dsv_core_tokenStore_baseBarrierView_readOnlyErrLock;
	Mutexdef dsv_core_policyStore_policyTypeMap_mu;
	Mutexdef dsv_core_policyStore_modifyLock;
	Mutexdef dsv_core_policyStore_egpLRU_lock;
	Mutexdef dsv_core_policyStore_tokenPoliciesLRU_lock;
	Mutexdef dsv_core_policyStore_egpView_readOnlyErrLock;
	Mutexdef dsv_core_policyStore_rgpView_readOnlyErrLock;
	Mutexdef dsv_core_policyStore_aclView_readOnlyErrLock;
	Mutexdef dsv_core_rollback_shutdownLock;
	Mutexdef dsv_core_rollback_inflightLock;
	Wgdef dsv_core_rollback_inflightAll;
	Mutexdef dsv_core_rollback_router_l;
	Mutexdef dsv_core_expiration_jobManager_l;
	Wgdef dsv_core_expiration_jobManager_wg;
	Mutexdef dsv_core_expiration_restoreLoaded_mu;
	Mutexdef dsv_core_expiration_restoreRequestLock;
	Mutexdef dsv_core_expiration_restoreModeLock;
	Mutexdef dsv_core_expiration_pendingLock;
	Mutexdef dsv_core_expiration_nonexpiring_mu;
	Mutexdef dsv_core_expiration_pending_mu;
	Mutexdef dsv_core_expiration_tokenStore_saltLock;
	Mutexdef dsv_core_expiration_tokenView_readOnlyErrLock;
	Mutexdef dsv_core_expiration_idView_readOnlyErrLock;
	Mutexdef dsv_core_expiration_router_l;
	Mutexdef dsv_core_systemBarrierView_readOnlyErrLock;
	Mutexdef dsv_core_systemBackend_mfaLock;
	Mutexdef dsv_core_systemBackend_db_writer;
	Mutexdef dsv_core_auditedHeaders_view_readOnlyErrLock;
	Mutexdef dsv_core_auditLock;
	Mutexdef dsv_core_authLock;
	Mutexdef dsv_core_mountsLock;
	Mutexdef dsv_core_rekeyLock;
	Mutexdef dsv_core_generateRootLock;
	Mutexdef dsv_core_router_l;
	Mutexdef dsv_core_raftInfo_leaderClient_modifyLock;
	int var_actual = -2; // opt var_actual
	run mutexMonitor(dsv_core_raftInfo_leaderClient_modifyLock);
	run mutexMonitor(dsv_core_router_l);
	run mutexMonitor(dsv_core_generateRootLock);
	run mutexMonitor(dsv_core_rekeyLock);
	run mutexMonitor(dsv_core_mountsLock);
	run mutexMonitor(dsv_core_authLock);
	run mutexMonitor(dsv_core_auditLock);
	run mutexMonitor(dsv_core_auditedHeaders_view_readOnlyErrLock);
	run mutexMonitor(dsv_core_systemBackend_db_writer);
	run mutexMonitor(dsv_core_systemBackend_mfaLock);
	run mutexMonitor(dsv_core_systemBarrierView_readOnlyErrLock);
	run mutexMonitor(dsv_core_expiration_router_l);
	run mutexMonitor(dsv_core_expiration_idView_readOnlyErrLock);
	run mutexMonitor(dsv_core_expiration_tokenView_readOnlyErrLock);
	run mutexMonitor(dsv_core_expiration_tokenStore_saltLock);
	run mutexMonitor(dsv_core_expiration_pending_mu);
	run mutexMonitor(dsv_core_expiration_nonexpiring_mu);
	run mutexMonitor(dsv_core_expiration_pendingLock);
	run mutexMonitor(dsv_core_expiration_restoreModeLock);
	run mutexMonitor(dsv_core_expiration_restoreRequestLock);
	run mutexMonitor(dsv_core_expiration_restoreLoaded_mu);
	run wgMonitor(dsv_core_expiration_jobManager_wg);
	run mutexMonitor(dsv_core_expiration_jobManager_l);
	run mutexMonitor(dsv_core_rollback_router_l);
	run wgMonitor(dsv_core_rollback_inflightAll);
	run mutexMonitor(dsv_core_rollback_inflightLock);
	run mutexMonitor(dsv_core_rollback_shutdownLock);
	run mutexMonitor(dsv_core_policyStore_aclView_readOnlyErrLock);
	run mutexMonitor(dsv_core_policyStore_rgpView_readOnlyErrLock);
	run mutexMonitor(dsv_core_policyStore_egpView_readOnlyErrLock);
	run mutexMonitor(dsv_core_policyStore_tokenPoliciesLRU_lock);
	run mutexMonitor(dsv_core_policyStore_egpLRU_lock);
	run mutexMonitor(dsv_core_policyStore_modifyLock);
	run mutexMonitor(dsv_core_policyStore_policyTypeMap_mu);
	run mutexMonitor(dsv_core_tokenStore_baseBarrierView_readOnlyErrLock);
	run mutexMonitor(dsv_core_tokenStore_idBarrierView_readOnlyErrLock);
	run mutexMonitor(dsv_core_tokenStore_accessorBarrierView_readOnlyErrLock);
	run mutexMonitor(dsv_core_tokenStore_parentBarrierView_readOnlyErrLock);
	run mutexMonitor(dsv_core_tokenStore_rolesBarrierView_readOnlyErrLock);
	run mutexMonitor(dsv_core_tokenStore_expiration_pendingLock);
	run mutexMonitor(dsv_core_tokenStore_expiration_restoreModeLock);
	run mutexMonitor(dsv_core_tokenStore_expiration_restoreRequestLock);
	run mutexMonitor(dsv_core_tokenStore_activityLog_l);
	run mutexMonitor(dsv_core_tokenStore_activityLog_fragmentLock);
	run mutexMonitor(dsv_core_tokenStore_tokensPendingDeletion_mu);
	run mutexMonitor(dsv_core_tokenStore_saltLock);
	run mutexMonitor(dsv_core_identityStore_db_writer);
	run mutexMonitor(dsv_core_identityStore_lock);
	run mutexMonitor(dsv_core_identityStore_oidcLock);
	run mutexMonitor(dsv_core_identityStore_groupLock);
	run mutexMonitor(dsv_core_activityLog_l);
	run mutexMonitor(dsv_core_activityLog_fragmentLock);
	run mutexMonitor(dsv_core_activityLog_view_readOnlyErrLock);
	run mutexMonitor(dsv_core_metricsMutex);
	run mutexMonitor(dsv_core_reloadFuncsLock);
	run mutexMonitor(dsv_core_clusterParamsLock);
	run mutexMonitor(dsv_core_requestForwardingConnectionLock);
	run mutexMonitor(dsv_core_leaderParamsLock);
	run mutexMonitor(dsv_core_rpcClientConn_csMgr_mu);
	run mutexMonitor(dsv_core_rpcClientConn_blockingpicker_mu);
	run mutexMonitor(dsv_core_rpcClientConn_mu);
	run mutexMonitor(dsv_core_rpcClientConn_resolverWrapper_resolverMu);
	run mutexMonitor(dsv_core_rpcClientConn_resolverWrapper_pollingMu);
	run mutexMonitor(dsv_core_rpcClientConn_balancerWrapper_balancerMu);
	run mutexMonitor(dsv_core_rpcClientConn_balancerWrapper_mu);
	run mutexMonitor(dsv_core_uiConfig_l);
	run mutexMonitor(dsv_core_pluginCatalog_catalogView_readOnlyErrLock);
	run mutexMonitor(dsv_core_pluginCatalog_lock);
	run mutexMonitor(dsv_core_unsealWithStoredKeysLock);
	run mutexMonitor(dsv_core_allLoggersLock);
	run mutexMonitor(dsv_core_metricsHelper_inMemSink_intervalLock);
	run mutexMonitor(dsv_core_raftFollowerStates_l);
	run mutexMonitor(dsv_core_pendingRaftPeers_mu);
	run mutexMonitor(dsv_core_quotaManager_db_writer);
	run mutexMonitor(dsv_core_quotaManager_rateLimitPathManager_l);
	run mutexMonitor(dsv_core_quotaManager_lock);
	run mutexMonitor(dsv_mountEntry_synthesizedConfigCache_mu);
	

	if
	:: 0 != -2 && 100-1 != -3 -> 
				for(i : 0.. 100-1) {
			for13: skip;
			run GeneratePasswordFromPolicy332(dsv_core_expiration_jobManager_wg,dsv_core_rollback_inflightAll,dsv_core_activityLog_fragmentLock,dsv_core_activityLog_l,dsv_core_activityLog_view_readOnlyErrLock,dsv_core_allLoggersLock,dsv_core_auditedHeaders_view_readOnlyErrLock,dsv_core_auditLock,dsv_core_authLock,dsv_core_clusterParamsLock,dsv_core_expiration_idView_readOnlyErrLock,dsv_core_expiration_jobManager_l,dsv_core_expiration_nonexpiring_mu,dsv_core_expiration_pending_mu,dsv_core_expiration_pendingLock,dsv_core_expiration_restoreLoaded_mu,dsv_core_expiration_restoreModeLock,dsv_core_expiration_restoreRequestLock,dsv_core_expiration_router_l,dsv_core_expiration_tokenStore_saltLock,dsv_core_expiration_tokenView_readOnlyErrLock,dsv_core_generateRootLock,dsv_core_identityStore_db_writer,dsv_core_identityStore_groupLock,dsv_core_identityStore_lock,dsv_core_identityStore_oidcLock,dsv_core_leaderParamsLock,dsv_core_metricsHelper_inMemSink_intervalLock,dsv_core_metricsMutex,dsv_core_mountsLock,dsv_core_pendingRaftPeers_mu,dsv_core_pluginCatalog_catalogView_readOnlyErrLock,dsv_core_pluginCatalog_lock,dsv_core_policyStore_aclView_readOnlyErrLock,dsv_core_policyStore_egpLRU_lock,dsv_core_policyStore_egpView_readOnlyErrLock,dsv_core_policyStore_modifyLock,dsv_core_policyStore_policyTypeMap_mu,dsv_core_policyStore_rgpView_readOnlyErrLock,dsv_core_policyStore_tokenPoliciesLRU_lock,dsv_core_quotaManager_db_writer,dsv_core_quotaManager_lock,dsv_core_quotaManager_rateLimitPathManager_l,dsv_core_raftFollowerStates_l,dsv_core_raftInfo_leaderClient_modifyLock,dsv_core_rekeyLock,dsv_core_reloadFuncsLock,dsv_core_requestForwardingConnectionLock,dsv_core_rollback_inflightLock,dsv_core_rollback_router_l,dsv_core_rollback_shutdownLock,dsv_core_router_l,dsv_core_rpcClientConn_balancerWrapper_balancerMu,dsv_core_rpcClientConn_balancerWrapper_mu,dsv_core_rpcClientConn_blockingpicker_mu,dsv_core_rpcClientConn_csMgr_mu,dsv_core_rpcClientConn_mu,dsv_core_rpcClientConn_resolverWrapper_pollingMu,dsv_core_rpcClientConn_resolverWrapper_resolverMu,dsv_core_systemBackend_db_writer,dsv_core_systemBackend_mfaLock,dsv_core_systemBarrierView_readOnlyErrLock,dsv_core_tokenStore_accessorBarrierView_readOnlyErrLock,dsv_core_tokenStore_activityLog_fragmentLock,dsv_core_tokenStore_activityLog_l,dsv_core_tokenStore_baseBarrierView_readOnlyErrLock,dsv_core_tokenStore_expiration_pendingLock,dsv_core_tokenStore_expiration_restoreModeLock,dsv_core_tokenStore_expiration_restoreRequestLock,dsv_core_tokenStore_idBarrierView_readOnlyErrLock,dsv_core_tokenStore_parentBarrierView_readOnlyErrLock,dsv_core_tokenStore_rolesBarrierView_readOnlyErrLock,dsv_core_tokenStore_saltLock,dsv_core_tokenStore_tokensPendingDeletion_mu,dsv_core_uiConfig_l,dsv_core_unsealWithStoredKeysLock,dsv_mountEntry_synthesizedConfigCache_mu,child_GeneratePasswordFromPolicy3321);
			child_GeneratePasswordFromPolicy3321?0;
			for13_end: skip
		};
		for13_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run GeneratePasswordFromPolicy332(dsv_core_expiration_jobManager_wg,dsv_core_rollback_inflightAll,dsv_core_activityLog_fragmentLock,dsv_core_activityLog_l,dsv_core_activityLog_view_readOnlyErrLock,dsv_core_allLoggersLock,dsv_core_auditedHeaders_view_readOnlyErrLock,dsv_core_auditLock,dsv_core_authLock,dsv_core_clusterParamsLock,dsv_core_expiration_idView_readOnlyErrLock,dsv_core_expiration_jobManager_l,dsv_core_expiration_nonexpiring_mu,dsv_core_expiration_pending_mu,dsv_core_expiration_pendingLock,dsv_core_expiration_restoreLoaded_mu,dsv_core_expiration_restoreModeLock,dsv_core_expiration_restoreRequestLock,dsv_core_expiration_router_l,dsv_core_expiration_tokenStore_saltLock,dsv_core_expiration_tokenView_readOnlyErrLock,dsv_core_generateRootLock,dsv_core_identityStore_db_writer,dsv_core_identityStore_groupLock,dsv_core_identityStore_lock,dsv_core_identityStore_oidcLock,dsv_core_leaderParamsLock,dsv_core_metricsHelper_inMemSink_intervalLock,dsv_core_metricsMutex,dsv_core_mountsLock,dsv_core_pendingRaftPeers_mu,dsv_core_pluginCatalog_catalogView_readOnlyErrLock,dsv_core_pluginCatalog_lock,dsv_core_policyStore_aclView_readOnlyErrLock,dsv_core_policyStore_egpLRU_lock,dsv_core_policyStore_egpView_readOnlyErrLock,dsv_core_policyStore_modifyLock,dsv_core_policyStore_policyTypeMap_mu,dsv_core_policyStore_rgpView_readOnlyErrLock,dsv_core_policyStore_tokenPoliciesLRU_lock,dsv_core_quotaManager_db_writer,dsv_core_quotaManager_lock,dsv_core_quotaManager_rateLimitPathManager_l,dsv_core_raftFollowerStates_l,dsv_core_raftInfo_leaderClient_modifyLock,dsv_core_rekeyLock,dsv_core_reloadFuncsLock,dsv_core_requestForwardingConnectionLock,dsv_core_rollback_inflightLock,dsv_core_rollback_router_l,dsv_core_rollback_shutdownLock,dsv_core_router_l,dsv_core_rpcClientConn_balancerWrapper_balancerMu,dsv_core_rpcClientConn_balancerWrapper_mu,dsv_core_rpcClientConn_blockingpicker_mu,dsv_core_rpcClientConn_csMgr_mu,dsv_core_rpcClientConn_mu,dsv_core_rpcClientConn_resolverWrapper_pollingMu,dsv_core_rpcClientConn_resolverWrapper_resolverMu,dsv_core_systemBackend_db_writer,dsv_core_systemBackend_mfaLock,dsv_core_systemBarrierView_readOnlyErrLock,dsv_core_tokenStore_accessorBarrierView_readOnlyErrLock,dsv_core_tokenStore_activityLog_fragmentLock,dsv_core_tokenStore_activityLog_l,dsv_core_tokenStore_baseBarrierView_readOnlyErrLock,dsv_core_tokenStore_expiration_pendingLock,dsv_core_tokenStore_expiration_restoreModeLock,dsv_core_tokenStore_expiration_restoreRequestLock,dsv_core_tokenStore_idBarrierView_readOnlyErrLock,dsv_core_tokenStore_parentBarrierView_readOnlyErrLock,dsv_core_tokenStore_rolesBarrierView_readOnlyErrLock,dsv_core_tokenStore_saltLock,dsv_core_tokenStore_tokensPendingDeletion_mu,dsv_core_uiConfig_l,dsv_core_unsealWithStoredKeysLock,dsv_mountEntry_synthesizedConfigCache_mu,child_GeneratePasswordFromPolicy3320);
			child_GeneratePasswordFromPolicy3320?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype GeneratePasswordFromPolicy332(Wgdef d_core_expiration_jobManager_wg;Wgdef d_core_rollback_inflightAll;Mutexdef d_core_activityLog_fragmentLock;Mutexdef d_core_activityLog_l;Mutexdef d_core_activityLog_view_readOnlyErrLock;Mutexdef d_core_allLoggersLock;Mutexdef d_core_auditedHeaders_view_readOnlyErrLock;Mutexdef d_core_auditLock;Mutexdef d_core_authLock;Mutexdef d_core_clusterParamsLock;Mutexdef d_core_expiration_idView_readOnlyErrLock;Mutexdef d_core_expiration_jobManager_l;Mutexdef d_core_expiration_nonexpiring_mu;Mutexdef d_core_expiration_pending_mu;Mutexdef d_core_expiration_pendingLock;Mutexdef d_core_expiration_restoreLoaded_mu;Mutexdef d_core_expiration_restoreModeLock;Mutexdef d_core_expiration_restoreRequestLock;Mutexdef d_core_expiration_router_l;Mutexdef d_core_expiration_tokenStore_saltLock;Mutexdef d_core_expiration_tokenView_readOnlyErrLock;Mutexdef d_core_generateRootLock;Mutexdef d_core_identityStore_db_writer;Mutexdef d_core_identityStore_groupLock;Mutexdef d_core_identityStore_lock;Mutexdef d_core_identityStore_oidcLock;Mutexdef d_core_leaderParamsLock;Mutexdef d_core_metricsHelper_inMemSink_intervalLock;Mutexdef d_core_metricsMutex;Mutexdef d_core_mountsLock;Mutexdef d_core_pendingRaftPeers_mu;Mutexdef d_core_pluginCatalog_catalogView_readOnlyErrLock;Mutexdef d_core_pluginCatalog_lock;Mutexdef d_core_policyStore_aclView_readOnlyErrLock;Mutexdef d_core_policyStore_egpLRU_lock;Mutexdef d_core_policyStore_egpView_readOnlyErrLock;Mutexdef d_core_policyStore_modifyLock;Mutexdef d_core_policyStore_policyTypeMap_mu;Mutexdef d_core_policyStore_rgpView_readOnlyErrLock;Mutexdef d_core_policyStore_tokenPoliciesLRU_lock;Mutexdef d_core_quotaManager_db_writer;Mutexdef d_core_quotaManager_lock;Mutexdef d_core_quotaManager_rateLimitPathManager_l;Mutexdef d_core_raftFollowerStates_l;Mutexdef d_core_raftInfo_leaderClient_modifyLock;Mutexdef d_core_rekeyLock;Mutexdef d_core_reloadFuncsLock;Mutexdef d_core_requestForwardingConnectionLock;Mutexdef d_core_rollback_inflightLock;Mutexdef d_core_rollback_router_l;Mutexdef d_core_rollback_shutdownLock;Mutexdef d_core_router_l;Mutexdef d_core_rpcClientConn_balancerWrapper_balancerMu;Mutexdef d_core_rpcClientConn_balancerWrapper_mu;Mutexdef d_core_rpcClientConn_blockingpicker_mu;Mutexdef d_core_rpcClientConn_csMgr_mu;Mutexdef d_core_rpcClientConn_mu;Mutexdef d_core_rpcClientConn_resolverWrapper_pollingMu;Mutexdef d_core_rpcClientConn_resolverWrapper_resolverMu;Mutexdef d_core_systemBackend_db_writer;Mutexdef d_core_systemBackend_mfaLock;Mutexdef d_core_systemBarrierView_readOnlyErrLock;Mutexdef d_core_tokenStore_accessorBarrierView_readOnlyErrLock;Mutexdef d_core_tokenStore_activityLog_fragmentLock;Mutexdef d_core_tokenStore_activityLog_l;Mutexdef d_core_tokenStore_baseBarrierView_readOnlyErrLock;Mutexdef d_core_tokenStore_expiration_pendingLock;Mutexdef d_core_tokenStore_expiration_restoreModeLock;Mutexdef d_core_tokenStore_expiration_restoreRequestLock;Mutexdef d_core_tokenStore_idBarrierView_readOnlyErrLock;Mutexdef d_core_tokenStore_parentBarrierView_readOnlyErrLock;Mutexdef d_core_tokenStore_rolesBarrierView_readOnlyErrLock;Mutexdef d_core_tokenStore_saltLock;Mutexdef d_core_tokenStore_tokensPendingDeletion_mu;Mutexdef d_core_uiConfig_l;Mutexdef d_core_unsealWithStoredKeysLock;Mutexdef d_mountEntry_synthesizedConfigCache_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_retrievePasswordPolicy22480 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run retrievePasswordPolicy2248(d_core_systemBarrierView_readOnlyErrLock,child_retrievePasswordPolicy22480);
	child_retrievePasswordPolicy22480?0;
	

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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype retrievePasswordPolicy2248(Mutexdef storage_readOnlyErrLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

proctype receiver(chan c) {
c?0
}

