// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob/f8f289712a3d37115090591602a2b92503fb3a13/vault/cluster_test.go#L23
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
	chan child_TestClusterFetching230 = [1] of {int};
	run TestClusterFetching23(child_TestClusterFetching230);
	run receiver(child_TestClusterFetching230)
stop_process:skip
}

proctype TestClusterFetching23(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Cluster601 = [1] of {int};
	chan child_setupCluster1500 = [1] of {int};
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
	run setupCluster150(c_rollback_inflightAll,c_activityLog_fragmentLock,c_activityLog_l,c_allLoggersLock,c_auditLock,c_authLock,c_clusterParamsLock,c_expiration_pendingLock,c_expiration_restoreModeLock,c_expiration_restoreRequestLock,c_generateRootLock,c_identityStore_groupLock,c_identityStore_lock,c_identityStore_oidcLock,c_leaderParamsLock,c_metricsMutex,c_mountsLock,c_pendingRaftPeers_mu,c_pluginCatalog_lock,c_policyStore_modifyLock,c_quotaManager_lock,c_raftFollowerStates_l,c_rekeyLock,c_reloadFuncsLock,c_requestForwardingConnectionLock,c_rollback_inflightLock,c_rollback_shutdownLock,c_router_l,c_rpcClientConn_mu,c_systemBackend_mfaLock,c_systemBarrierView_readOnlyErrLock,c_tokenStore_saltLock,c_uiConfig_l,c_unsealWithStoredKeysLock,child_setupCluster1500);
	child_setupCluster1500?0;
	run Cluster60(c_rollback_inflightAll,c_activityLog_fragmentLock,c_activityLog_l,c_allLoggersLock,c_auditLock,c_authLock,c_clusterParamsLock,c_expiration_pendingLock,c_expiration_restoreModeLock,c_expiration_restoreRequestLock,c_generateRootLock,c_identityStore_groupLock,c_identityStore_lock,c_identityStore_oidcLock,c_leaderParamsLock,c_metricsMutex,c_mountsLock,c_pendingRaftPeers_mu,c_pluginCatalog_lock,c_policyStore_modifyLock,c_quotaManager_lock,c_raftFollowerStates_l,c_rekeyLock,c_reloadFuncsLock,c_requestForwardingConnectionLock,c_rollback_inflightLock,c_rollback_shutdownLock,c_router_l,c_rpcClientConn_mu,c_systemBackend_mfaLock,c_systemBarrierView_readOnlyErrLock,c_tokenStore_saltLock,c_uiConfig_l,c_unsealWithStoredKeysLock,child_Cluster601);
	child_Cluster601?0;
	stop_process: skip;
	child!0
}
proctype setupCluster150(Wgdef c_rollback_inflightAll;Mutexdef c_activityLog_fragmentLock;Mutexdef c_activityLog_l;Mutexdef c_allLoggersLock;Mutexdef c_auditLock;Mutexdef c_authLock;Mutexdef c_clusterParamsLock;Mutexdef c_expiration_pendingLock;Mutexdef c_expiration_restoreModeLock;Mutexdef c_expiration_restoreRequestLock;Mutexdef c_generateRootLock;Mutexdef c_identityStore_groupLock;Mutexdef c_identityStore_lock;Mutexdef c_identityStore_oidcLock;Mutexdef c_leaderParamsLock;Mutexdef c_metricsMutex;Mutexdef c_mountsLock;Mutexdef c_pendingRaftPeers_mu;Mutexdef c_pluginCatalog_lock;Mutexdef c_policyStore_modifyLock;Mutexdef c_quotaManager_lock;Mutexdef c_raftFollowerStates_l;Mutexdef c_rekeyLock;Mutexdef c_reloadFuncsLock;Mutexdef c_requestForwardingConnectionLock;Mutexdef c_rollback_inflightLock;Mutexdef c_rollback_shutdownLock;Mutexdef c_router_l;Mutexdef c_rpcClientConn_mu;Mutexdef c_systemBackend_mfaLock;Mutexdef c_systemBarrierView_readOnlyErrLock;Mutexdef c_tokenStore_saltLock;Mutexdef c_uiConfig_l;Mutexdef c_unsealWithStoredKeysLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Cluster600 = [1] of {int};
	c_clusterParamsLock.Lock!false;
	run Cluster60(c_rollback_inflightAll,c_activityLog_fragmentLock,c_activityLog_l,c_allLoggersLock,c_auditLock,c_authLock,c_clusterParamsLock,c_expiration_pendingLock,c_expiration_restoreModeLock,c_expiration_restoreRequestLock,c_generateRootLock,c_identityStore_groupLock,c_identityStore_lock,c_identityStore_oidcLock,c_leaderParamsLock,c_metricsMutex,c_mountsLock,c_pendingRaftPeers_mu,c_pluginCatalog_lock,c_policyStore_modifyLock,c_quotaManager_lock,c_raftFollowerStates_l,c_rekeyLock,c_reloadFuncsLock,c_requestForwardingConnectionLock,c_rollback_inflightLock,c_rollback_shutdownLock,c_router_l,c_rpcClientConn_mu,c_systemBackend_mfaLock,c_systemBarrierView_readOnlyErrLock,c_tokenStore_saltLock,c_uiConfig_l,c_unsealWithStoredKeysLock,child_Cluster600);
	child_Cluster600?0;
	

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
		fi
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
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	c_clusterParamsLock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Cluster60(Wgdef c_rollback_inflightAll;Mutexdef c_activityLog_fragmentLock;Mutexdef c_activityLog_l;Mutexdef c_allLoggersLock;Mutexdef c_auditLock;Mutexdef c_authLock;Mutexdef c_clusterParamsLock;Mutexdef c_expiration_pendingLock;Mutexdef c_expiration_restoreModeLock;Mutexdef c_expiration_restoreRequestLock;Mutexdef c_generateRootLock;Mutexdef c_identityStore_groupLock;Mutexdef c_identityStore_lock;Mutexdef c_identityStore_oidcLock;Mutexdef c_leaderParamsLock;Mutexdef c_metricsMutex;Mutexdef c_mountsLock;Mutexdef c_pendingRaftPeers_mu;Mutexdef c_pluginCatalog_lock;Mutexdef c_policyStore_modifyLock;Mutexdef c_quotaManager_lock;Mutexdef c_raftFollowerStates_l;Mutexdef c_rekeyLock;Mutexdef c_reloadFuncsLock;Mutexdef c_requestForwardingConnectionLock;Mutexdef c_rollback_inflightLock;Mutexdef c_rollback_shutdownLock;Mutexdef c_router_l;Mutexdef c_rpcClientConn_mu;Mutexdef c_systemBackend_mfaLock;Mutexdef c_systemBarrierView_readOnlyErrLock;Mutexdef c_tokenStore_saltLock;Mutexdef c_uiConfig_l;Mutexdef c_unsealWithStoredKeysLock;chan child) {
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

