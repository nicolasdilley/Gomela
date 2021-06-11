// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob/f8f289712a3d37115090591602a2b92503fb3a13/vault/rekey_test.go#L520
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
	chan child_TestSysRekey_Verification_Invalid5200 = [1] of {int};
	run TestSysRekey_Verification_Invalid520(child_TestSysRekey_Verification_Invalid5200);
	run receiver(child_TestSysRekey_Verification_Invalid5200)
stop_process:skip
}

proctype TestSysRekey_Verification_Invalid520(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_BarrierRekeyInit1710 = [1] of {int};
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
	run BarrierRekeyInit171(core_rollback_inflightAll,core_activityLog_fragmentLock,core_activityLog_l,core_allLoggersLock,core_auditLock,core_authLock,core_clusterParamsLock,core_expiration_pendingLock,core_expiration_restoreModeLock,core_expiration_restoreRequestLock,core_generateRootLock,core_identityStore_groupLock,core_identityStore_lock,core_identityStore_oidcLock,core_leaderParamsLock,core_metricsMutex,core_mountsLock,core_pendingRaftPeers_mu,core_pluginCatalog_lock,core_policyStore_modifyLock,core_quotaManager_lock,core_raftFollowerStates_l,core_rekeyLock,core_reloadFuncsLock,core_requestForwardingConnectionLock,core_rollback_inflightLock,core_rollback_shutdownLock,core_router_l,core_rpcClientConn_mu,core_systemBackend_mfaLock,core_systemBarrierView_readOnlyErrLock,core_tokenStore_saltLock,core_uiConfig_l,core_unsealWithStoredKeysLock,child_BarrierRekeyInit1710);
	child_BarrierRekeyInit1710?0;
	stop_process: skip;
	child!0
}
proctype BarrierRekeyInit171(Wgdef c_rollback_inflightAll;Mutexdef c_activityLog_fragmentLock;Mutexdef c_activityLog_l;Mutexdef c_allLoggersLock;Mutexdef c_auditLock;Mutexdef c_authLock;Mutexdef c_clusterParamsLock;Mutexdef c_expiration_pendingLock;Mutexdef c_expiration_restoreModeLock;Mutexdef c_expiration_restoreRequestLock;Mutexdef c_generateRootLock;Mutexdef c_identityStore_groupLock;Mutexdef c_identityStore_lock;Mutexdef c_identityStore_oidcLock;Mutexdef c_leaderParamsLock;Mutexdef c_metricsMutex;Mutexdef c_mountsLock;Mutexdef c_pendingRaftPeers_mu;Mutexdef c_pluginCatalog_lock;Mutexdef c_policyStore_modifyLock;Mutexdef c_quotaManager_lock;Mutexdef c_raftFollowerStates_l;Mutexdef c_rekeyLock;Mutexdef c_reloadFuncsLock;Mutexdef c_requestForwardingConnectionLock;Mutexdef c_rollback_inflightLock;Mutexdef c_rollback_shutdownLock;Mutexdef c_router_l;Mutexdef c_rpcClientConn_mu;Mutexdef c_systemBackend_mfaLock;Mutexdef c_systemBarrierView_readOnlyErrLock;Mutexdef c_tokenStore_saltLock;Mutexdef c_uiConfig_l;Mutexdef c_unsealWithStoredKeysLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Sealed10430 = [1] of {int};
	

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

