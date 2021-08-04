// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob/f8f289712a3d37115090591602a2b92503fb3a13/vault/rekey_test.go#L336
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
	chan child_TestCore_Rekey_Invalid3360 = [1] of {int};
	run TestCore_Rekey_Invalid336(child_TestCore_Rekey_Invalid3360);
	run receiver(child_TestCore_Rekey_Invalid3360)
stop_process:skip
}

proctype TestCore_Rekey_Invalid336(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_testCore_Rekey_Invalid_Common3480 = [1] of {int};
	Mutexdef c_quotaManager_lock;
	Mutexdef c_pendingRaftPeers_mu;
	Mutexdef c_raftFollowerStates_l;
	Mutexdef c_allLoggersLock;
	Mutexdef c_unsealWithStoredKeysLock;
	Mutexdef c_pluginCatalog_lock;
	Mutexdef c_uiConfig_l;
	Mutexdef c_rpcClientConn_mu;
	Mutexdef c_leaderParamsLock;
	Mutexdef c_requestForwardingConnectionLock;
	Mutexdef c_clusterParamsLock;
	Mutexdef c_reloadFuncsLock;
	Mutexdef c_metricsMutex;
	Mutexdef c_activityLog_fragmentLock;
	Mutexdef c_activityLog_l;
	Mutexdef c_identityStore_groupLock;
	Mutexdef c_identityStore_oidcLock;
	Mutexdef c_identityStore_lock;
	Mutexdef c_tokenStore_saltLock;
	Mutexdef c_policyStore_modifyLock;
	Mutexdef c_rollback_shutdownLock;
	Mutexdef c_rollback_inflightLock;
	Wgdef c_rollback_inflightAll;
	Mutexdef c_expiration_restoreRequestLock;
	Mutexdef c_expiration_restoreModeLock;
	Mutexdef c_expiration_pendingLock;
	Mutexdef c_systemBarrierView_readOnlyErrLock;
	Mutexdef c_systemBackend_mfaLock;
	Mutexdef c_auditLock;
	Mutexdef c_authLock;
	Mutexdef c_mountsLock;
	Mutexdef c_rekeyLock;
	Mutexdef c_generateRootLock;
	Mutexdef c_router_l;
	run mutexMonitor(c_router_l);
	run mutexMonitor(c_generateRootLock);
	run mutexMonitor(c_rekeyLock);
	run mutexMonitor(c_mountsLock);
	run mutexMonitor(c_authLock);
	run mutexMonitor(c_auditLock);
	run mutexMonitor(c_systemBackend_mfaLock);
	run mutexMonitor(c_systemBarrierView_readOnlyErrLock);
	run mutexMonitor(c_expiration_pendingLock);
	run mutexMonitor(c_expiration_restoreModeLock);
	run mutexMonitor(c_expiration_restoreRequestLock);
	run wgMonitor(c_rollback_inflightAll);
	run mutexMonitor(c_rollback_inflightLock);
	run mutexMonitor(c_rollback_shutdownLock);
	run mutexMonitor(c_policyStore_modifyLock);
	run mutexMonitor(c_tokenStore_saltLock);
	run mutexMonitor(c_identityStore_lock);
	run mutexMonitor(c_identityStore_oidcLock);
	run mutexMonitor(c_identityStore_groupLock);
	run mutexMonitor(c_activityLog_l);
	run mutexMonitor(c_activityLog_fragmentLock);
	run mutexMonitor(c_metricsMutex);
	run mutexMonitor(c_reloadFuncsLock);
	run mutexMonitor(c_clusterParamsLock);
	run mutexMonitor(c_requestForwardingConnectionLock);
	run mutexMonitor(c_leaderParamsLock);
	run mutexMonitor(c_rpcClientConn_mu);
	run mutexMonitor(c_uiConfig_l);
	run mutexMonitor(c_pluginCatalog_lock);
	run mutexMonitor(c_unsealWithStoredKeysLock);
	run mutexMonitor(c_allLoggersLock);
	run mutexMonitor(c_raftFollowerStates_l);
	run mutexMonitor(c_pendingRaftPeers_mu);
	run mutexMonitor(c_quotaManager_lock);
	run testCore_Rekey_Invalid_Common348(c_rollback_inflightAll,c_activityLog_fragmentLock,c_activityLog_l,c_allLoggersLock,c_auditLock,c_authLock,c_clusterParamsLock,c_expiration_pendingLock,c_expiration_restoreModeLock,c_expiration_restoreRequestLock,c_generateRootLock,c_identityStore_groupLock,c_identityStore_lock,c_identityStore_oidcLock,c_leaderParamsLock,c_metricsMutex,c_mountsLock,c_pendingRaftPeers_mu,c_pluginCatalog_lock,c_policyStore_modifyLock,c_quotaManager_lock,c_raftFollowerStates_l,c_rekeyLock,c_reloadFuncsLock,c_requestForwardingConnectionLock,c_rollback_inflightLock,c_rollback_shutdownLock,c_router_l,c_rpcClientConn_mu,c_systemBackend_mfaLock,c_systemBarrierView_readOnlyErrLock,c_tokenStore_saltLock,c_uiConfig_l,c_unsealWithStoredKeysLock,child_testCore_Rekey_Invalid_Common3480);
	child_testCore_Rekey_Invalid_Common3480?0;
	stop_process: skip;
	child!0
}
proctype testCore_Rekey_Invalid_Common348(Wgdef c_rollback_inflightAll;Mutexdef c_activityLog_fragmentLock;Mutexdef c_activityLog_l;Mutexdef c_allLoggersLock;Mutexdef c_auditLock;Mutexdef c_authLock;Mutexdef c_clusterParamsLock;Mutexdef c_expiration_pendingLock;Mutexdef c_expiration_restoreModeLock;Mutexdef c_expiration_restoreRequestLock;Mutexdef c_generateRootLock;Mutexdef c_identityStore_groupLock;Mutexdef c_identityStore_lock;Mutexdef c_identityStore_oidcLock;Mutexdef c_leaderParamsLock;Mutexdef c_metricsMutex;Mutexdef c_mountsLock;Mutexdef c_pendingRaftPeers_mu;Mutexdef c_pluginCatalog_lock;Mutexdef c_policyStore_modifyLock;Mutexdef c_quotaManager_lock;Mutexdef c_raftFollowerStates_l;Mutexdef c_rekeyLock;Mutexdef c_reloadFuncsLock;Mutexdef c_requestForwardingConnectionLock;Mutexdef c_rollback_inflightLock;Mutexdef c_rollback_shutdownLock;Mutexdef c_router_l;Mutexdef c_rpcClientConn_mu;Mutexdef c_systemBackend_mfaLock;Mutexdef c_systemBarrierView_readOnlyErrLock;Mutexdef c_tokenStore_saltLock;Mutexdef c_uiConfig_l;Mutexdef c_unsealWithStoredKeysLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RekeyProgress984 = [1] of {int};
	chan child_RekeyUpdate2963 = [1] of {int};
	chan child_RekeyUpdate2962 = [1] of {int};
	chan child_RekeyConfig1291 = [1] of {int};
	chan child_RekeyInit1590 = [1] of {int};
	run RekeyInit159(c_rollback_inflightAll,c_activityLog_fragmentLock,c_activityLog_l,c_allLoggersLock,c_auditLock,c_authLock,c_clusterParamsLock,c_expiration_pendingLock,c_expiration_restoreModeLock,c_expiration_restoreRequestLock,c_generateRootLock,c_identityStore_groupLock,c_identityStore_lock,c_identityStore_oidcLock,c_leaderParamsLock,c_metricsMutex,c_mountsLock,c_pendingRaftPeers_mu,c_pluginCatalog_lock,c_policyStore_modifyLock,c_quotaManager_lock,c_raftFollowerStates_l,c_rekeyLock,c_reloadFuncsLock,c_requestForwardingConnectionLock,c_rollback_inflightLock,c_rollback_shutdownLock,c_router_l,c_rpcClientConn_mu,c_systemBackend_mfaLock,c_systemBarrierView_readOnlyErrLock,c_tokenStore_saltLock,c_uiConfig_l,c_unsealWithStoredKeysLock,child_RekeyInit1590);
	child_RekeyInit1590?0;
	run RekeyConfig129(c_rollback_inflightAll,c_activityLog_fragmentLock,c_activityLog_l,c_allLoggersLock,c_auditLock,c_authLock,c_clusterParamsLock,c_expiration_pendingLock,c_expiration_restoreModeLock,c_expiration_restoreRequestLock,c_generateRootLock,c_identityStore_groupLock,c_identityStore_lock,c_identityStore_oidcLock,c_leaderParamsLock,c_metricsMutex,c_mountsLock,c_pendingRaftPeers_mu,c_pluginCatalog_lock,c_policyStore_modifyLock,c_quotaManager_lock,c_raftFollowerStates_l,c_rekeyLock,c_reloadFuncsLock,c_requestForwardingConnectionLock,c_rollback_inflightLock,c_rollback_shutdownLock,c_router_l,c_rpcClientConn_mu,c_systemBackend_mfaLock,c_systemBarrierView_readOnlyErrLock,c_tokenStore_saltLock,c_uiConfig_l,c_unsealWithStoredKeysLock,child_RekeyConfig1291);
	child_RekeyConfig1291?0;
	run RekeyUpdate296(c_rollback_inflightAll,c_activityLog_fragmentLock,c_activityLog_l,c_allLoggersLock,c_auditLock,c_authLock,c_clusterParamsLock,c_expiration_pendingLock,c_expiration_restoreModeLock,c_expiration_restoreRequestLock,c_generateRootLock,c_identityStore_groupLock,c_identityStore_lock,c_identityStore_oidcLock,c_leaderParamsLock,c_metricsMutex,c_mountsLock,c_pendingRaftPeers_mu,c_pluginCatalog_lock,c_policyStore_modifyLock,c_quotaManager_lock,c_raftFollowerStates_l,c_rekeyLock,c_reloadFuncsLock,c_requestForwardingConnectionLock,c_rollback_inflightLock,c_rollback_shutdownLock,c_router_l,c_rpcClientConn_mu,c_systemBackend_mfaLock,c_systemBarrierView_readOnlyErrLock,c_tokenStore_saltLock,c_uiConfig_l,c_unsealWithStoredKeysLock,child_RekeyUpdate2962);
	child_RekeyUpdate2962?0;
	run RekeyUpdate296(c_rollback_inflightAll,c_activityLog_fragmentLock,c_activityLog_l,c_allLoggersLock,c_auditLock,c_authLock,c_clusterParamsLock,c_expiration_pendingLock,c_expiration_restoreModeLock,c_expiration_restoreRequestLock,c_generateRootLock,c_identityStore_groupLock,c_identityStore_lock,c_identityStore_oidcLock,c_leaderParamsLock,c_metricsMutex,c_mountsLock,c_pendingRaftPeers_mu,c_pluginCatalog_lock,c_policyStore_modifyLock,c_quotaManager_lock,c_raftFollowerStates_l,c_rekeyLock,c_reloadFuncsLock,c_requestForwardingConnectionLock,c_rollback_inflightLock,c_rollback_shutdownLock,c_router_l,c_rpcClientConn_mu,c_systemBackend_mfaLock,c_systemBarrierView_readOnlyErrLock,c_tokenStore_saltLock,c_uiConfig_l,c_unsealWithStoredKeysLock,child_RekeyUpdate2963);
	child_RekeyUpdate2963?0;
	run RekeyProgress98(c_rollback_inflightAll,c_activityLog_fragmentLock,c_activityLog_l,c_allLoggersLock,c_auditLock,c_authLock,c_clusterParamsLock,c_expiration_pendingLock,c_expiration_restoreModeLock,c_expiration_restoreRequestLock,c_generateRootLock,c_identityStore_groupLock,c_identityStore_lock,c_identityStore_oidcLock,c_leaderParamsLock,c_metricsMutex,c_mountsLock,c_pendingRaftPeers_mu,c_pluginCatalog_lock,c_policyStore_modifyLock,c_quotaManager_lock,c_raftFollowerStates_l,c_rekeyLock,c_reloadFuncsLock,c_requestForwardingConnectionLock,c_rollback_inflightLock,c_rollback_shutdownLock,c_router_l,c_rpcClientConn_mu,c_systemBackend_mfaLock,c_systemBarrierView_readOnlyErrLock,c_tokenStore_saltLock,c_uiConfig_l,c_unsealWithStoredKeysLock,child_RekeyProgress984);
	child_RekeyProgress984?0;
	stop_process: skip;
	child!0
}
proctype RekeyInit159(Wgdef c_rollback_inflightAll;Mutexdef c_activityLog_fragmentLock;Mutexdef c_activityLog_l;Mutexdef c_allLoggersLock;Mutexdef c_auditLock;Mutexdef c_authLock;Mutexdef c_clusterParamsLock;Mutexdef c_expiration_pendingLock;Mutexdef c_expiration_restoreModeLock;Mutexdef c_expiration_restoreRequestLock;Mutexdef c_generateRootLock;Mutexdef c_identityStore_groupLock;Mutexdef c_identityStore_lock;Mutexdef c_identityStore_oidcLock;Mutexdef c_leaderParamsLock;Mutexdef c_metricsMutex;Mutexdef c_mountsLock;Mutexdef c_pendingRaftPeers_mu;Mutexdef c_pluginCatalog_lock;Mutexdef c_policyStore_modifyLock;Mutexdef c_quotaManager_lock;Mutexdef c_raftFollowerStates_l;Mutexdef c_rekeyLock;Mutexdef c_reloadFuncsLock;Mutexdef c_requestForwardingConnectionLock;Mutexdef c_rollback_inflightLock;Mutexdef c_rollback_shutdownLock;Mutexdef c_router_l;Mutexdef c_rpcClientConn_mu;Mutexdef c_systemBackend_mfaLock;Mutexdef c_systemBarrierView_readOnlyErrLock;Mutexdef c_tokenStore_saltLock;Mutexdef c_uiConfig_l;Mutexdef c_unsealWithStoredKeysLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_BarrierRekeyInit1711 = [1] of {int};
	chan child_RecoveryRekeyInit2460 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run RecoveryRekeyInit246(c_rollback_inflightAll,c_activityLog_fragmentLock,c_activityLog_l,c_allLoggersLock,c_auditLock,c_authLock,c_clusterParamsLock,c_expiration_pendingLock,c_expiration_restoreModeLock,c_expiration_restoreRequestLock,c_generateRootLock,c_identityStore_groupLock,c_identityStore_lock,c_identityStore_oidcLock,c_leaderParamsLock,c_metricsMutex,c_mountsLock,c_pendingRaftPeers_mu,c_pluginCatalog_lock,c_policyStore_modifyLock,c_quotaManager_lock,c_raftFollowerStates_l,c_rekeyLock,c_reloadFuncsLock,c_requestForwardingConnectionLock,c_rollback_inflightLock,c_rollback_shutdownLock,c_router_l,c_rpcClientConn_mu,c_systemBackend_mfaLock,c_systemBarrierView_readOnlyErrLock,c_tokenStore_saltLock,c_uiConfig_l,c_unsealWithStoredKeysLock,child_RecoveryRekeyInit2460);
		child_RecoveryRekeyInit2460?0;
		goto stop_process
	:: true;
	fi;
	run BarrierRekeyInit171(c_rollback_inflightAll,c_activityLog_fragmentLock,c_activityLog_l,c_allLoggersLock,c_auditLock,c_authLock,c_clusterParamsLock,c_expiration_pendingLock,c_expiration_restoreModeLock,c_expiration_restoreRequestLock,c_generateRootLock,c_identityStore_groupLock,c_identityStore_lock,c_identityStore_oidcLock,c_leaderParamsLock,c_metricsMutex,c_mountsLock,c_pendingRaftPeers_mu,c_pluginCatalog_lock,c_policyStore_modifyLock,c_quotaManager_lock,c_raftFollowerStates_l,c_rekeyLock,c_reloadFuncsLock,c_requestForwardingConnectionLock,c_rollback_inflightLock,c_rollback_shutdownLock,c_router_l,c_rpcClientConn_mu,c_systemBackend_mfaLock,c_systemBarrierView_readOnlyErrLock,c_tokenStore_saltLock,c_uiConfig_l,c_unsealWithStoredKeysLock,child_BarrierRekeyInit1711);
	child_BarrierRekeyInit1711?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype RecoveryRekeyInit246(Wgdef c_rollback_inflightAll;Mutexdef c_activityLog_fragmentLock;Mutexdef c_activityLog_l;Mutexdef c_allLoggersLock;Mutexdef c_auditLock;Mutexdef c_authLock;Mutexdef c_clusterParamsLock;Mutexdef c_expiration_pendingLock;Mutexdef c_expiration_restoreModeLock;Mutexdef c_expiration_restoreRequestLock;Mutexdef c_generateRootLock;Mutexdef c_identityStore_groupLock;Mutexdef c_identityStore_lock;Mutexdef c_identityStore_oidcLock;Mutexdef c_leaderParamsLock;Mutexdef c_metricsMutex;Mutexdef c_mountsLock;Mutexdef c_pendingRaftPeers_mu;Mutexdef c_pluginCatalog_lock;Mutexdef c_policyStore_modifyLock;Mutexdef c_quotaManager_lock;Mutexdef c_raftFollowerStates_l;Mutexdef c_rekeyLock;Mutexdef c_reloadFuncsLock;Mutexdef c_requestForwardingConnectionLock;Mutexdef c_rollback_inflightLock;Mutexdef c_rollback_shutdownLock;Mutexdef c_router_l;Mutexdef c_rpcClientConn_mu;Mutexdef c_systemBackend_mfaLock;Mutexdef c_systemBarrierView_readOnlyErrLock;Mutexdef c_tokenStore_saltLock;Mutexdef c_uiConfig_l;Mutexdef c_unsealWithStoredKeysLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Sealed10430 = [1] of {int};
	

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
	run Sealed1043(c_rollback_inflightAll,c_activityLog_fragmentLock,c_activityLog_l,c_allLoggersLock,c_auditLock,c_authLock,c_clusterParamsLock,c_expiration_pendingLock,c_expiration_restoreModeLock,c_expiration_restoreRequestLock,c_generateRootLock,c_identityStore_groupLock,c_identityStore_lock,c_identityStore_oidcLock,c_leaderParamsLock,c_metricsMutex,c_mountsLock,c_pendingRaftPeers_mu,c_pluginCatalog_lock,c_policyStore_modifyLock,c_quotaManager_lock,c_raftFollowerStates_l,c_rekeyLock,c_reloadFuncsLock,c_requestForwardingConnectionLock,c_rollback_inflightLock,c_rollback_shutdownLock,c_router_l,c_rpcClientConn_mu,c_systemBackend_mfaLock,c_systemBarrierView_readOnlyErrLock,c_tokenStore_saltLock,c_uiConfig_l,c_unsealWithStoredKeysLock,child_Sealed10430);
	child_Sealed10430?0;
	

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
	c_rekeyLock.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	c_rekeyLock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Sealed1043(Wgdef c_rollback_inflightAll;Mutexdef c_activityLog_fragmentLock;Mutexdef c_activityLog_l;Mutexdef c_allLoggersLock;Mutexdef c_auditLock;Mutexdef c_authLock;Mutexdef c_clusterParamsLock;Mutexdef c_expiration_pendingLock;Mutexdef c_expiration_restoreModeLock;Mutexdef c_expiration_restoreRequestLock;Mutexdef c_generateRootLock;Mutexdef c_identityStore_groupLock;Mutexdef c_identityStore_lock;Mutexdef c_identityStore_oidcLock;Mutexdef c_leaderParamsLock;Mutexdef c_metricsMutex;Mutexdef c_mountsLock;Mutexdef c_pendingRaftPeers_mu;Mutexdef c_pluginCatalog_lock;Mutexdef c_policyStore_modifyLock;Mutexdef c_quotaManager_lock;Mutexdef c_raftFollowerStates_l;Mutexdef c_rekeyLock;Mutexdef c_reloadFuncsLock;Mutexdef c_requestForwardingConnectionLock;Mutexdef c_rollback_inflightLock;Mutexdef c_rollback_shutdownLock;Mutexdef c_router_l;Mutexdef c_rpcClientConn_mu;Mutexdef c_systemBackend_mfaLock;Mutexdef c_systemBarrierView_readOnlyErrLock;Mutexdef c_tokenStore_saltLock;Mutexdef c_uiConfig_l;Mutexdef c_unsealWithStoredKeysLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype BarrierRekeyInit171(Wgdef c_rollback_inflightAll;Mutexdef c_activityLog_fragmentLock;Mutexdef c_activityLog_l;Mutexdef c_allLoggersLock;Mutexdef c_auditLock;Mutexdef c_authLock;Mutexdef c_clusterParamsLock;Mutexdef c_expiration_pendingLock;Mutexdef c_expiration_restoreModeLock;Mutexdef c_expiration_restoreRequestLock;Mutexdef c_generateRootLock;Mutexdef c_identityStore_groupLock;Mutexdef c_identityStore_lock;Mutexdef c_identityStore_oidcLock;Mutexdef c_leaderParamsLock;Mutexdef c_metricsMutex;Mutexdef c_mountsLock;Mutexdef c_pendingRaftPeers_mu;Mutexdef c_pluginCatalog_lock;Mutexdef c_policyStore_modifyLock;Mutexdef c_quotaManager_lock;Mutexdef c_raftFollowerStates_l;Mutexdef c_rekeyLock;Mutexdef c_reloadFuncsLock;Mutexdef c_requestForwardingConnectionLock;Mutexdef c_rollback_inflightLock;Mutexdef c_rollback_shutdownLock;Mutexdef c_router_l;Mutexdef c_rpcClientConn_mu;Mutexdef c_systemBackend_mfaLock;Mutexdef c_systemBarrierView_readOnlyErrLock;Mutexdef c_tokenStore_saltLock;Mutexdef c_uiConfig_l;Mutexdef c_unsealWithStoredKeysLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Sealed10431 = [1] of {int};
	

	if
	:: true;
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Sealed1043(c_rollback_inflightAll,c_activityLog_fragmentLock,c_activityLog_l,c_allLoggersLock,c_auditLock,c_authLock,c_clusterParamsLock,c_expiration_pendingLock,c_expiration_restoreModeLock,c_expiration_restoreRequestLock,c_generateRootLock,c_identityStore_groupLock,c_identityStore_lock,c_identityStore_oidcLock,c_leaderParamsLock,c_metricsMutex,c_mountsLock,c_pendingRaftPeers_mu,c_pluginCatalog_lock,c_policyStore_modifyLock,c_quotaManager_lock,c_raftFollowerStates_l,c_rekeyLock,c_reloadFuncsLock,c_requestForwardingConnectionLock,c_rollback_inflightLock,c_rollback_shutdownLock,c_router_l,c_rpcClientConn_mu,c_systemBackend_mfaLock,c_systemBarrierView_readOnlyErrLock,c_tokenStore_saltLock,c_uiConfig_l,c_unsealWithStoredKeysLock,child_Sealed10431);
	child_Sealed10431?0;
	

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
	c_rekeyLock.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	c_rekeyLock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype RekeyConfig129(Wgdef c_rollback_inflightAll;Mutexdef c_activityLog_fragmentLock;Mutexdef c_activityLog_l;Mutexdef c_allLoggersLock;Mutexdef c_auditLock;Mutexdef c_authLock;Mutexdef c_clusterParamsLock;Mutexdef c_expiration_pendingLock;Mutexdef c_expiration_restoreModeLock;Mutexdef c_expiration_restoreRequestLock;Mutexdef c_generateRootLock;Mutexdef c_identityStore_groupLock;Mutexdef c_identityStore_lock;Mutexdef c_identityStore_oidcLock;Mutexdef c_leaderParamsLock;Mutexdef c_metricsMutex;Mutexdef c_mountsLock;Mutexdef c_pendingRaftPeers_mu;Mutexdef c_pluginCatalog_lock;Mutexdef c_policyStore_modifyLock;Mutexdef c_quotaManager_lock;Mutexdef c_raftFollowerStates_l;Mutexdef c_rekeyLock;Mutexdef c_reloadFuncsLock;Mutexdef c_requestForwardingConnectionLock;Mutexdef c_rollback_inflightLock;Mutexdef c_rollback_shutdownLock;Mutexdef c_router_l;Mutexdef c_rpcClientConn_mu;Mutexdef c_systemBackend_mfaLock;Mutexdef c_systemBarrierView_readOnlyErrLock;Mutexdef c_tokenStore_saltLock;Mutexdef c_uiConfig_l;Mutexdef c_unsealWithStoredKeysLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Sealed10431 = [1] of {int};
	run Sealed1043(c_rollback_inflightAll,c_activityLog_fragmentLock,c_activityLog_l,c_allLoggersLock,c_auditLock,c_authLock,c_clusterParamsLock,c_expiration_pendingLock,c_expiration_restoreModeLock,c_expiration_restoreRequestLock,c_generateRootLock,c_identityStore_groupLock,c_identityStore_lock,c_identityStore_oidcLock,c_leaderParamsLock,c_metricsMutex,c_mountsLock,c_pendingRaftPeers_mu,c_pluginCatalog_lock,c_policyStore_modifyLock,c_quotaManager_lock,c_raftFollowerStates_l,c_rekeyLock,c_reloadFuncsLock,c_requestForwardingConnectionLock,c_rollback_inflightLock,c_rollback_shutdownLock,c_router_l,c_rpcClientConn_mu,c_systemBackend_mfaLock,c_systemBarrierView_readOnlyErrLock,c_tokenStore_saltLock,c_uiConfig_l,c_unsealWithStoredKeysLock,child_Sealed10431);
	child_Sealed10431?0;
	

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
	c_rekeyLock.Lock!false;
	goto defer1;
		defer1: skip;
	c_rekeyLock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype RekeyUpdate296(Wgdef c_rollback_inflightAll;Mutexdef c_activityLog_fragmentLock;Mutexdef c_activityLog_l;Mutexdef c_allLoggersLock;Mutexdef c_auditLock;Mutexdef c_authLock;Mutexdef c_clusterParamsLock;Mutexdef c_expiration_pendingLock;Mutexdef c_expiration_restoreModeLock;Mutexdef c_expiration_restoreRequestLock;Mutexdef c_generateRootLock;Mutexdef c_identityStore_groupLock;Mutexdef c_identityStore_lock;Mutexdef c_identityStore_oidcLock;Mutexdef c_leaderParamsLock;Mutexdef c_metricsMutex;Mutexdef c_mountsLock;Mutexdef c_pendingRaftPeers_mu;Mutexdef c_pluginCatalog_lock;Mutexdef c_policyStore_modifyLock;Mutexdef c_quotaManager_lock;Mutexdef c_raftFollowerStates_l;Mutexdef c_rekeyLock;Mutexdef c_reloadFuncsLock;Mutexdef c_requestForwardingConnectionLock;Mutexdef c_rollback_inflightLock;Mutexdef c_rollback_shutdownLock;Mutexdef c_router_l;Mutexdef c_rpcClientConn_mu;Mutexdef c_systemBackend_mfaLock;Mutexdef c_systemBarrierView_readOnlyErrLock;Mutexdef c_tokenStore_saltLock;Mutexdef c_uiConfig_l;Mutexdef c_unsealWithStoredKeysLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_BarrierRekeyUpdate3083 = [1] of {int};
	chan child_RecoveryRekeyUpdate5942 = [1] of {int};
	

	if
	:: true -> 
		run RecoveryRekeyUpdate594(c_rollback_inflightAll,c_activityLog_fragmentLock,c_activityLog_l,c_allLoggersLock,c_auditLock,c_authLock,c_clusterParamsLock,c_expiration_pendingLock,c_expiration_restoreModeLock,c_expiration_restoreRequestLock,c_generateRootLock,c_identityStore_groupLock,c_identityStore_lock,c_identityStore_oidcLock,c_leaderParamsLock,c_metricsMutex,c_mountsLock,c_pendingRaftPeers_mu,c_pluginCatalog_lock,c_policyStore_modifyLock,c_quotaManager_lock,c_raftFollowerStates_l,c_rekeyLock,c_reloadFuncsLock,c_requestForwardingConnectionLock,c_rollback_inflightLock,c_rollback_shutdownLock,c_router_l,c_rpcClientConn_mu,c_systemBackend_mfaLock,c_systemBarrierView_readOnlyErrLock,c_tokenStore_saltLock,c_uiConfig_l,c_unsealWithStoredKeysLock,child_RecoveryRekeyUpdate5942);
		child_RecoveryRekeyUpdate5942?0;
		goto stop_process
	:: true;
	fi;
	run BarrierRekeyUpdate308(c_rollback_inflightAll,c_activityLog_fragmentLock,c_activityLog_l,c_allLoggersLock,c_auditLock,c_authLock,c_clusterParamsLock,c_expiration_pendingLock,c_expiration_restoreModeLock,c_expiration_restoreRequestLock,c_generateRootLock,c_identityStore_groupLock,c_identityStore_lock,c_identityStore_oidcLock,c_leaderParamsLock,c_metricsMutex,c_mountsLock,c_pendingRaftPeers_mu,c_pluginCatalog_lock,c_policyStore_modifyLock,c_quotaManager_lock,c_raftFollowerStates_l,c_rekeyLock,c_reloadFuncsLock,c_requestForwardingConnectionLock,c_rollback_inflightLock,c_rollback_shutdownLock,c_router_l,c_rpcClientConn_mu,c_systemBackend_mfaLock,c_systemBarrierView_readOnlyErrLock,c_tokenStore_saltLock,c_uiConfig_l,c_unsealWithStoredKeysLock,child_BarrierRekeyUpdate3083);
	child_BarrierRekeyUpdate3083?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype RecoveryRekeyUpdate594(Wgdef c_rollback_inflightAll;Mutexdef c_activityLog_fragmentLock;Mutexdef c_activityLog_l;Mutexdef c_allLoggersLock;Mutexdef c_auditLock;Mutexdef c_authLock;Mutexdef c_clusterParamsLock;Mutexdef c_expiration_pendingLock;Mutexdef c_expiration_restoreModeLock;Mutexdef c_expiration_restoreRequestLock;Mutexdef c_generateRootLock;Mutexdef c_identityStore_groupLock;Mutexdef c_identityStore_lock;Mutexdef c_identityStore_oidcLock;Mutexdef c_leaderParamsLock;Mutexdef c_metricsMutex;Mutexdef c_mountsLock;Mutexdef c_pendingRaftPeers_mu;Mutexdef c_pluginCatalog_lock;Mutexdef c_policyStore_modifyLock;Mutexdef c_quotaManager_lock;Mutexdef c_raftFollowerStates_l;Mutexdef c_rekeyLock;Mutexdef c_reloadFuncsLock;Mutexdef c_requestForwardingConnectionLock;Mutexdef c_rollback_inflightLock;Mutexdef c_rollback_shutdownLock;Mutexdef c_router_l;Mutexdef c_rpcClientConn_mu;Mutexdef c_systemBackend_mfaLock;Mutexdef c_systemBarrierView_readOnlyErrLock;Mutexdef c_tokenStore_saltLock;Mutexdef c_uiConfig_l;Mutexdef c_unsealWithStoredKeysLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_performRecoveryRekey7673 = [1] of {int};
	chan child_Sealed10432 = [1] of {int};
	int var_results_PGPFingerprints = -2; // opt var_results_PGPFingerprints
	int var_results_SecretShares = -2; // opt var_results_SecretShares
	int var_c_recoveryRekeyConfig_RekeyProgress = -2; // opt var_c_recoveryRekeyConfig_RekeyProgress
	run Sealed1043(c_rollback_inflightAll,c_activityLog_fragmentLock,c_activityLog_l,c_allLoggersLock,c_auditLock,c_authLock,c_clusterParamsLock,c_expiration_pendingLock,c_expiration_restoreModeLock,c_expiration_restoreRequestLock,c_generateRootLock,c_identityStore_groupLock,c_identityStore_lock,c_identityStore_oidcLock,c_leaderParamsLock,c_metricsMutex,c_mountsLock,c_pendingRaftPeers_mu,c_pluginCatalog_lock,c_policyStore_modifyLock,c_quotaManager_lock,c_raftFollowerStates_l,c_rekeyLock,c_reloadFuncsLock,c_requestForwardingConnectionLock,c_rollback_inflightLock,c_rollback_shutdownLock,c_router_l,c_rpcClientConn_mu,c_systemBackend_mfaLock,c_systemBarrierView_readOnlyErrLock,c_tokenStore_saltLock,c_uiConfig_l,c_unsealWithStoredKeysLock,child_Sealed10432);
	child_Sealed10432?0;
	

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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	c_rekeyLock.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi;
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto defer1
			:: true;
			fi;
			

			if
			:: true -> 
				goto defer1
			:: true;
			fi
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi;
		goto defer1
	:: true;
	fi;
	run performRecoveryRekey767(c_rollback_inflightAll,c_activityLog_fragmentLock,c_activityLog_l,c_allLoggersLock,c_auditLock,c_authLock,c_clusterParamsLock,c_expiration_pendingLock,c_expiration_restoreModeLock,c_expiration_restoreRequestLock,c_generateRootLock,c_identityStore_groupLock,c_identityStore_lock,c_identityStore_oidcLock,c_leaderParamsLock,c_metricsMutex,c_mountsLock,c_pendingRaftPeers_mu,c_pluginCatalog_lock,c_policyStore_modifyLock,c_quotaManager_lock,c_raftFollowerStates_l,c_rekeyLock,c_reloadFuncsLock,c_requestForwardingConnectionLock,c_rollback_inflightLock,c_rollback_shutdownLock,c_router_l,c_rpcClientConn_mu,c_systemBackend_mfaLock,c_systemBarrierView_readOnlyErrLock,c_tokenStore_saltLock,c_uiConfig_l,c_unsealWithStoredKeysLock,child_performRecoveryRekey7673);
	child_performRecoveryRekey7673?0;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	c_rekeyLock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype performRecoveryRekey767(Wgdef c_rollback_inflightAll;Mutexdef c_activityLog_fragmentLock;Mutexdef c_activityLog_l;Mutexdef c_allLoggersLock;Mutexdef c_auditLock;Mutexdef c_authLock;Mutexdef c_clusterParamsLock;Mutexdef c_expiration_pendingLock;Mutexdef c_expiration_restoreModeLock;Mutexdef c_expiration_restoreRequestLock;Mutexdef c_generateRootLock;Mutexdef c_identityStore_groupLock;Mutexdef c_identityStore_lock;Mutexdef c_identityStore_oidcLock;Mutexdef c_leaderParamsLock;Mutexdef c_metricsMutex;Mutexdef c_mountsLock;Mutexdef c_pendingRaftPeers_mu;Mutexdef c_pluginCatalog_lock;Mutexdef c_policyStore_modifyLock;Mutexdef c_quotaManager_lock;Mutexdef c_raftFollowerStates_l;Mutexdef c_rekeyLock;Mutexdef c_reloadFuncsLock;Mutexdef c_requestForwardingConnectionLock;Mutexdef c_rollback_inflightLock;Mutexdef c_rollback_shutdownLock;Mutexdef c_router_l;Mutexdef c_rpcClientConn_mu;Mutexdef c_systemBackend_mfaLock;Mutexdef c_systemBarrierView_readOnlyErrLock;Mutexdef c_tokenStore_saltLock;Mutexdef c_uiConfig_l;Mutexdef c_unsealWithStoredKeysLock;chan child) {
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
proctype BarrierRekeyUpdate308(Wgdef c_rollback_inflightAll;Mutexdef c_activityLog_fragmentLock;Mutexdef c_activityLog_l;Mutexdef c_allLoggersLock;Mutexdef c_auditLock;Mutexdef c_authLock;Mutexdef c_clusterParamsLock;Mutexdef c_expiration_pendingLock;Mutexdef c_expiration_restoreModeLock;Mutexdef c_expiration_restoreRequestLock;Mutexdef c_generateRootLock;Mutexdef c_identityStore_groupLock;Mutexdef c_identityStore_lock;Mutexdef c_identityStore_oidcLock;Mutexdef c_leaderParamsLock;Mutexdef c_metricsMutex;Mutexdef c_mountsLock;Mutexdef c_pendingRaftPeers_mu;Mutexdef c_pluginCatalog_lock;Mutexdef c_policyStore_modifyLock;Mutexdef c_quotaManager_lock;Mutexdef c_raftFollowerStates_l;Mutexdef c_rekeyLock;Mutexdef c_reloadFuncsLock;Mutexdef c_requestForwardingConnectionLock;Mutexdef c_rollback_inflightLock;Mutexdef c_rollback_shutdownLock;Mutexdef c_router_l;Mutexdef c_rpcClientConn_mu;Mutexdef c_systemBackend_mfaLock;Mutexdef c_systemBarrierView_readOnlyErrLock;Mutexdef c_tokenStore_saltLock;Mutexdef c_uiConfig_l;Mutexdef c_unsealWithStoredKeysLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_performBarrierRekey5234 = [1] of {int};
	chan child_Sealed10433 = [1] of {int};
	int var_results_PGPFingerprints = -2; // opt var_results_PGPFingerprints
	int var_results_SecretShares = -2; // opt var_results_SecretShares
	int var_c_barrierRekeyConfig_RekeyProgress = -2; // opt var_c_barrierRekeyConfig_RekeyProgress
	run Sealed1043(c_rollback_inflightAll,c_activityLog_fragmentLock,c_activityLog_l,c_allLoggersLock,c_auditLock,c_authLock,c_clusterParamsLock,c_expiration_pendingLock,c_expiration_restoreModeLock,c_expiration_restoreRequestLock,c_generateRootLock,c_identityStore_groupLock,c_identityStore_lock,c_identityStore_oidcLock,c_leaderParamsLock,c_metricsMutex,c_mountsLock,c_pendingRaftPeers_mu,c_pluginCatalog_lock,c_policyStore_modifyLock,c_quotaManager_lock,c_raftFollowerStates_l,c_rekeyLock,c_reloadFuncsLock,c_requestForwardingConnectionLock,c_rollback_inflightLock,c_rollback_shutdownLock,c_router_l,c_rpcClientConn_mu,c_systemBackend_mfaLock,c_systemBarrierView_readOnlyErrLock,c_tokenStore_saltLock,c_uiConfig_l,c_unsealWithStoredKeysLock,child_Sealed10433);
	child_Sealed10433?0;
	

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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	c_rekeyLock.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto defer1
			:: true;
			fi;
			

			if
			:: true -> 
				goto defer1
			:: true;
			fi;
			

			if
			:: true -> 
				goto defer1
			:: true;
			fi
		:: true;
		fi;
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto defer1
			:: true;
			fi
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi;
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto defer1
			:: true;
			fi;
			

			if
			:: true -> 
				goto defer1
			:: true;
			fi
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi;
		goto defer1
	:: true;
	fi;
	run performBarrierRekey523(c_rollback_inflightAll,c_activityLog_fragmentLock,c_activityLog_l,c_allLoggersLock,c_auditLock,c_authLock,c_clusterParamsLock,c_expiration_pendingLock,c_expiration_restoreModeLock,c_expiration_restoreRequestLock,c_generateRootLock,c_identityStore_groupLock,c_identityStore_lock,c_identityStore_oidcLock,c_leaderParamsLock,c_metricsMutex,c_mountsLock,c_pendingRaftPeers_mu,c_pluginCatalog_lock,c_policyStore_modifyLock,c_quotaManager_lock,c_raftFollowerStates_l,c_rekeyLock,c_reloadFuncsLock,c_requestForwardingConnectionLock,c_rollback_inflightLock,c_rollback_shutdownLock,c_router_l,c_rpcClientConn_mu,c_systemBackend_mfaLock,c_systemBarrierView_readOnlyErrLock,c_tokenStore_saltLock,c_uiConfig_l,c_unsealWithStoredKeysLock,child_performBarrierRekey5234);
	child_performBarrierRekey5234?0;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	c_rekeyLock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype performBarrierRekey523(Wgdef c_rollback_inflightAll;Mutexdef c_activityLog_fragmentLock;Mutexdef c_activityLog_l;Mutexdef c_allLoggersLock;Mutexdef c_auditLock;Mutexdef c_authLock;Mutexdef c_clusterParamsLock;Mutexdef c_expiration_pendingLock;Mutexdef c_expiration_restoreModeLock;Mutexdef c_expiration_restoreRequestLock;Mutexdef c_generateRootLock;Mutexdef c_identityStore_groupLock;Mutexdef c_identityStore_lock;Mutexdef c_identityStore_oidcLock;Mutexdef c_leaderParamsLock;Mutexdef c_metricsMutex;Mutexdef c_mountsLock;Mutexdef c_pendingRaftPeers_mu;Mutexdef c_pluginCatalog_lock;Mutexdef c_policyStore_modifyLock;Mutexdef c_quotaManager_lock;Mutexdef c_raftFollowerStates_l;Mutexdef c_rekeyLock;Mutexdef c_reloadFuncsLock;Mutexdef c_requestForwardingConnectionLock;Mutexdef c_rollback_inflightLock;Mutexdef c_rollback_shutdownLock;Mutexdef c_router_l;Mutexdef c_rpcClientConn_mu;Mutexdef c_systemBackend_mfaLock;Mutexdef c_systemBarrierView_readOnlyErrLock;Mutexdef c_tokenStore_saltLock;Mutexdef c_uiConfig_l;Mutexdef c_unsealWithStoredKeysLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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
proctype RekeyProgress98(Wgdef c_rollback_inflightAll;Mutexdef c_activityLog_fragmentLock;Mutexdef c_activityLog_l;Mutexdef c_allLoggersLock;Mutexdef c_auditLock;Mutexdef c_authLock;Mutexdef c_clusterParamsLock;Mutexdef c_expiration_pendingLock;Mutexdef c_expiration_restoreModeLock;Mutexdef c_expiration_restoreRequestLock;Mutexdef c_generateRootLock;Mutexdef c_identityStore_groupLock;Mutexdef c_identityStore_lock;Mutexdef c_identityStore_oidcLock;Mutexdef c_leaderParamsLock;Mutexdef c_metricsMutex;Mutexdef c_mountsLock;Mutexdef c_pendingRaftPeers_mu;Mutexdef c_pluginCatalog_lock;Mutexdef c_policyStore_modifyLock;Mutexdef c_quotaManager_lock;Mutexdef c_raftFollowerStates_l;Mutexdef c_rekeyLock;Mutexdef c_reloadFuncsLock;Mutexdef c_requestForwardingConnectionLock;Mutexdef c_rollback_inflightLock;Mutexdef c_rollback_shutdownLock;Mutexdef c_router_l;Mutexdef c_rpcClientConn_mu;Mutexdef c_systemBackend_mfaLock;Mutexdef c_systemBarrierView_readOnlyErrLock;Mutexdef c_tokenStore_saltLock;Mutexdef c_uiConfig_l;Mutexdef c_unsealWithStoredKeysLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Sealed10434 = [1] of {int};
	run Sealed1043(c_rollback_inflightAll,c_activityLog_fragmentLock,c_activityLog_l,c_allLoggersLock,c_auditLock,c_authLock,c_clusterParamsLock,c_expiration_pendingLock,c_expiration_restoreModeLock,c_expiration_restoreRequestLock,c_generateRootLock,c_identityStore_groupLock,c_identityStore_lock,c_identityStore_oidcLock,c_leaderParamsLock,c_metricsMutex,c_mountsLock,c_pendingRaftPeers_mu,c_pluginCatalog_lock,c_policyStore_modifyLock,c_quotaManager_lock,c_raftFollowerStates_l,c_rekeyLock,c_reloadFuncsLock,c_requestForwardingConnectionLock,c_rollback_inflightLock,c_rollback_shutdownLock,c_router_l,c_rpcClientConn_mu,c_systemBackend_mfaLock,c_systemBarrierView_readOnlyErrLock,c_tokenStore_saltLock,c_uiConfig_l,c_unsealWithStoredKeysLock,child_Sealed10434);
	child_Sealed10434?0;
	

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
	c_rekeyLock.RLock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	c_rekeyLock.RUnlock!false;
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

