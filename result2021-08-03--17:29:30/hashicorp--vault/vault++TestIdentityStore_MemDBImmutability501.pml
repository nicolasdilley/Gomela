// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob/f8f289712a3d37115090591602a2b92503fb3a13/vault/identity_store_entities_test.go#L501
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
	chan child_TestIdentityStore_MemDBImmutability5010 = [1] of {int};
	run TestIdentityStore_MemDBImmutability501(child_TestIdentityStore_MemDBImmutability5010);
	run receiver(child_TestIdentityStore_MemDBImmutability5010)
stop_process:skip
}

proctype TestIdentityStore_MemDBImmutability501(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_MemDBEntityByID7512 = [1] of {int};
	chan child_MemDBEntityByID7511 = [1] of {int};
	chan child_MemDBUpsertEntityInTxn6890 = [1] of {int};
	Mutexdef txn_db_writer;
	Mutexdef __quotaManager_lock;
	Mutexdef __pendingRaftPeers_mu;
	Mutexdef __raftFollowerStates_l;
	Mutexdef __allLoggersLock;
	Mutexdef __unsealWithStoredKeysLock;
	Mutexdef __pluginCatalog_lock;
	Mutexdef __uiConfig_l;
	Mutexdef __rpcClientConn_mu;
	Mutexdef __leaderParamsLock;
	Mutexdef __requestForwardingConnectionLock;
	Mutexdef __clusterParamsLock;
	Mutexdef __reloadFuncsLock;
	Mutexdef __metricsMutex;
	Mutexdef __activityLog_fragmentLock;
	Mutexdef __activityLog_l;
	Mutexdef __identityStore_groupLock;
	Mutexdef __identityStore_oidcLock;
	Mutexdef __identityStore_lock;
	Mutexdef __tokenStore_saltLock;
	Mutexdef __policyStore_modifyLock;
	Mutexdef __rollback_shutdownLock;
	Mutexdef __rollback_inflightLock;
	Wgdef __rollback_inflightAll;
	Mutexdef __expiration_restoreRequestLock;
	Mutexdef __expiration_restoreModeLock;
	Mutexdef __expiration_pendingLock;
	Mutexdef __systemBarrierView_readOnlyErrLock;
	Mutexdef __systemBackend_mfaLock;
	Mutexdef __auditLock;
	Mutexdef __authLock;
	Mutexdef __mountsLock;
	Mutexdef __rekeyLock;
	Mutexdef __generateRootLock;
	Mutexdef __router_l;
	Mutexdef is_core_allLoggersLock;
	Mutexdef is_core_unsealWithStoredKeysLock;
	Mutexdef is_core_leaderParamsLock;
	Mutexdef is_core_requestForwardingConnectionLock;
	Mutexdef is_core_clusterParamsLock;
	Mutexdef is_core_reloadFuncsLock;
	Mutexdef is_core_metricsMutex;
	Mutexdef is_core_auditLock;
	Mutexdef is_core_authLock;
	Mutexdef is_core_mountsLock;
	Mutexdef is_core_rekeyLock;
	Mutexdef is_core_generateRootLock;
	Mutexdef is_groupLock;
	Mutexdef is_oidcLock;
	Mutexdef is_lock;
	Mutexdef is_db_writer;
	run mutexMonitor(is_db_writer);
	run mutexMonitor(is_lock);
	run mutexMonitor(is_oidcLock);
	run mutexMonitor(is_groupLock);
	run mutexMonitor(is_core_generateRootLock);
	run mutexMonitor(is_core_rekeyLock);
	run mutexMonitor(is_core_mountsLock);
	run mutexMonitor(is_core_authLock);
	run mutexMonitor(is_core_auditLock);
	run mutexMonitor(is_core_metricsMutex);
	run mutexMonitor(is_core_reloadFuncsLock);
	run mutexMonitor(is_core_clusterParamsLock);
	run mutexMonitor(is_core_requestForwardingConnectionLock);
	run mutexMonitor(is_core_leaderParamsLock);
	run mutexMonitor(is_core_unsealWithStoredKeysLock);
	run mutexMonitor(is_core_allLoggersLock);
	run mutexMonitor(__router_l);
	run mutexMonitor(__generateRootLock);
	run mutexMonitor(__rekeyLock);
	run mutexMonitor(__mountsLock);
	run mutexMonitor(__authLock);
	run mutexMonitor(__auditLock);
	run mutexMonitor(__systemBackend_mfaLock);
	run mutexMonitor(__systemBarrierView_readOnlyErrLock);
	run mutexMonitor(__expiration_pendingLock);
	run mutexMonitor(__expiration_restoreModeLock);
	run mutexMonitor(__expiration_restoreRequestLock);
	run wgMonitor(__rollback_inflightAll);
	run mutexMonitor(__rollback_inflightLock);
	run mutexMonitor(__rollback_shutdownLock);
	run mutexMonitor(__policyStore_modifyLock);
	run mutexMonitor(__tokenStore_saltLock);
	run mutexMonitor(__identityStore_lock);
	run mutexMonitor(__identityStore_oidcLock);
	run mutexMonitor(__identityStore_groupLock);
	run mutexMonitor(__activityLog_l);
	run mutexMonitor(__activityLog_fragmentLock);
	run mutexMonitor(__metricsMutex);
	run mutexMonitor(__reloadFuncsLock);
	run mutexMonitor(__clusterParamsLock);
	run mutexMonitor(__requestForwardingConnectionLock);
	run mutexMonitor(__leaderParamsLock);
	run mutexMonitor(__rpcClientConn_mu);
	run mutexMonitor(__uiConfig_l);
	run mutexMonitor(__pluginCatalog_lock);
	run mutexMonitor(__unsealWithStoredKeysLock);
	run mutexMonitor(__allLoggersLock);
	run mutexMonitor(__raftFollowerStates_l);
	run mutexMonitor(__pendingRaftPeers_mu);
	run mutexMonitor(__quotaManager_lock);
	run mutexMonitor(txn_db_writer);
	run MemDBUpsertEntityInTxn689(is_core_allLoggersLock,is_core_auditLock,is_core_authLock,is_core_clusterParamsLock,is_core_generateRootLock,is_core_leaderParamsLock,is_core_metricsMutex,is_core_mountsLock,is_core_rekeyLock,is_core_reloadFuncsLock,is_core_requestForwardingConnectionLock,is_core_unsealWithStoredKeysLock,is_db_writer,is_groupLock,is_lock,is_oidcLock,txn_db_writer,child_MemDBUpsertEntityInTxn6890);
	child_MemDBUpsertEntityInTxn6890?0;
	run MemDBEntityByID751(is_core_allLoggersLock,is_core_auditLock,is_core_authLock,is_core_clusterParamsLock,is_core_generateRootLock,is_core_leaderParamsLock,is_core_metricsMutex,is_core_mountsLock,is_core_rekeyLock,is_core_reloadFuncsLock,is_core_requestForwardingConnectionLock,is_core_unsealWithStoredKeysLock,is_db_writer,is_groupLock,is_lock,is_oidcLock,child_MemDBEntityByID7511);
	child_MemDBEntityByID7511?0;
	run MemDBEntityByID751(is_core_allLoggersLock,is_core_auditLock,is_core_authLock,is_core_clusterParamsLock,is_core_generateRootLock,is_core_leaderParamsLock,is_core_metricsMutex,is_core_mountsLock,is_core_rekeyLock,is_core_reloadFuncsLock,is_core_requestForwardingConnectionLock,is_core_unsealWithStoredKeysLock,is_db_writer,is_groupLock,is_lock,is_oidcLock,child_MemDBEntityByID7512);
	child_MemDBEntityByID7512?0;
	stop_process: skip;
	child!0
}
proctype MemDBUpsertEntityInTxn689(Mutexdef i_core_allLoggersLock;Mutexdef i_core_auditLock;Mutexdef i_core_authLock;Mutexdef i_core_clusterParamsLock;Mutexdef i_core_generateRootLock;Mutexdef i_core_leaderParamsLock;Mutexdef i_core_metricsMutex;Mutexdef i_core_mountsLock;Mutexdef i_core_rekeyLock;Mutexdef i_core_reloadFuncsLock;Mutexdef i_core_requestForwardingConnectionLock;Mutexdef i_core_unsealWithStoredKeysLock;Mutexdef i_db_writer;Mutexdef i_groupLock;Mutexdef i_lock;Mutexdef i_oidcLock;Mutexdef txn_db_writer;chan child) {
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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype MemDBEntityByID751(Mutexdef i_core_allLoggersLock;Mutexdef i_core_auditLock;Mutexdef i_core_authLock;Mutexdef i_core_clusterParamsLock;Mutexdef i_core_generateRootLock;Mutexdef i_core_leaderParamsLock;Mutexdef i_core_metricsMutex;Mutexdef i_core_mountsLock;Mutexdef i_core_rekeyLock;Mutexdef i_core_reloadFuncsLock;Mutexdef i_core_requestForwardingConnectionLock;Mutexdef i_core_unsealWithStoredKeysLock;Mutexdef i_db_writer;Mutexdef i_groupLock;Mutexdef i_lock;Mutexdef i_oidcLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_MemDBEntityByIDInTxn7211 = [1] of {int};
	Mutexdef txn_db_writer;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(txn_db_writer);
	run MemDBEntityByIDInTxn721(i_core_allLoggersLock,i_core_auditLock,i_core_authLock,i_core_clusterParamsLock,i_core_generateRootLock,i_core_leaderParamsLock,i_core_metricsMutex,i_core_mountsLock,i_core_rekeyLock,i_core_reloadFuncsLock,i_core_requestForwardingConnectionLock,i_core_unsealWithStoredKeysLock,i_db_writer,i_groupLock,i_lock,i_oidcLock,txn_db_writer,child_MemDBEntityByIDInTxn7211);
	child_MemDBEntityByIDInTxn7211?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype MemDBEntityByIDInTxn721(Mutexdef i_core_allLoggersLock;Mutexdef i_core_auditLock;Mutexdef i_core_authLock;Mutexdef i_core_clusterParamsLock;Mutexdef i_core_generateRootLock;Mutexdef i_core_leaderParamsLock;Mutexdef i_core_metricsMutex;Mutexdef i_core_mountsLock;Mutexdef i_core_rekeyLock;Mutexdef i_core_reloadFuncsLock;Mutexdef i_core_requestForwardingConnectionLock;Mutexdef i_core_unsealWithStoredKeysLock;Mutexdef i_db_writer;Mutexdef i_groupLock;Mutexdef i_lock;Mutexdef i_oidcLock;Mutexdef txn_db_writer;chan child) {
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

