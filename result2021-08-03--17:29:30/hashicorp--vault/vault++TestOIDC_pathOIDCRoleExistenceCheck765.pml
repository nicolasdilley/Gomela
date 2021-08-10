// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob/f8f289712a3d37115090591602a2b92503fb3a13/vault/identity_store_oidc_test.go#L765
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
	chan child_TestOIDC_pathOIDCRoleExistenceCheck7650 = [1] of {int};
	run TestOIDC_pathOIDCRoleExistenceCheck765(child_TestOIDC_pathOIDCRoleExistenceCheck7650);
	run receiver(child_TestOIDC_pathOIDCRoleExistenceCheck7650)
stop_process:skip
}

proctype TestOIDC_pathOIDCRoleExistenceCheck765(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_pathOIDCRoleExistenceCheck8621 = [1] of {int};
	chan child_pathOIDCRoleExistenceCheck8620 = [1] of {int};
	Mutexdef storage_once_m;
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
	run mutexMonitor(storage_once_m);
	run pathOIDCRoleExistenceCheck862(c_identityStore_groupLock,c_identityStore_lock,c_identityStore_oidcLock,child_pathOIDCRoleExistenceCheck8620);
	child_pathOIDCRoleExistenceCheck8620?0;
	run pathOIDCRoleExistenceCheck862(c_identityStore_groupLock,c_identityStore_lock,c_identityStore_oidcLock,child_pathOIDCRoleExistenceCheck8621);
	child_pathOIDCRoleExistenceCheck8621?0;
	stop_process: skip;
	child!0
}
proctype pathOIDCRoleExistenceCheck862(Mutexdef i_groupLock;Mutexdef i_lock;Mutexdef i_oidcLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getOIDCRole9930 = [1] of {int};
	run getOIDCRole993(i_groupLock,i_lock,i_oidcLock,child_getOIDCRole9930);
	child_getOIDCRole9930?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getOIDCRole993(Mutexdef i_groupLock;Mutexdef i_lock;Mutexdef i_oidcLock;chan child) {
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

