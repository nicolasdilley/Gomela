// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob/f8f289712a3d37115090591602a2b92503fb3a13/vault/identity_store_group_aliases_test.go#L340
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
	chan child_TestIdentityStore_GroupAliases_MemDBIndexes3400 = [1] of {int};
	run TestIdentityStore_GroupAliases_MemDBIndexes340(child_TestIdentityStore_GroupAliases_MemDBIndexes3400);
	run receiver(child_TestIdentityStore_GroupAliases_MemDBIndexes3400)
stop_process:skip
}

proctype TestIdentityStore_GroupAliases_MemDBIndexes340(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_MemDBAliasByFactors5874 = [1] of {int};
	chan child_MemDBGroupByAliasID18773 = [1] of {int};
	chan child_MemDBAliasByID5772 = [1] of {int};
	chan child_MemDBUpsertGroupInTxn14521 = [1] of {int};
	chan child_MemDBUpsertAliasInTxn5050 = [1] of {int};
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
	run MemDBUpsertAliasInTxn505(i_core_allLoggersLock,i_core_auditLock,i_core_authLock,i_core_clusterParamsLock,i_core_generateRootLock,i_core_leaderParamsLock,i_core_metricsMutex,i_core_mountsLock,i_core_rekeyLock,i_core_reloadFuncsLock,i_core_requestForwardingConnectionLock,i_core_unsealWithStoredKeysLock,i_db_writer,i_groupLock,i_lock,i_oidcLock,txn_db_writer,child_MemDBUpsertAliasInTxn5050);
	child_MemDBUpsertAliasInTxn5050?0;
	run MemDBUpsertGroupInTxn1452(i_core_allLoggersLock,i_core_auditLock,i_core_authLock,i_core_clusterParamsLock,i_core_generateRootLock,i_core_leaderParamsLock,i_core_metricsMutex,i_core_mountsLock,i_core_rekeyLock,i_core_reloadFuncsLock,i_core_requestForwardingConnectionLock,i_core_unsealWithStoredKeysLock,i_db_writer,i_groupLock,i_lock,i_oidcLock,txn_db_writer,child_MemDBUpsertGroupInTxn14521);
	child_MemDBUpsertGroupInTxn14521?0;
	run MemDBAliasByID577(i_core_allLoggersLock,i_core_auditLock,i_core_authLock,i_core_clusterParamsLock,i_core_generateRootLock,i_core_leaderParamsLock,i_core_metricsMutex,i_core_mountsLock,i_core_rekeyLock,i_core_reloadFuncsLock,i_core_requestForwardingConnectionLock,i_core_unsealWithStoredKeysLock,i_db_writer,i_groupLock,i_lock,i_oidcLock,child_MemDBAliasByID5772);
	child_MemDBAliasByID5772?0;
	run MemDBGroupByAliasID1877(i_core_allLoggersLock,i_core_auditLock,i_core_authLock,i_core_clusterParamsLock,i_core_generateRootLock,i_core_leaderParamsLock,i_core_metricsMutex,i_core_mountsLock,i_core_rekeyLock,i_core_reloadFuncsLock,i_core_requestForwardingConnectionLock,i_core_unsealWithStoredKeysLock,i_db_writer,i_groupLock,i_lock,i_oidcLock,child_MemDBGroupByAliasID18773);
	child_MemDBGroupByAliasID18773?0;
	run MemDBAliasByFactors587(i_core_allLoggersLock,i_core_auditLock,i_core_authLock,i_core_clusterParamsLock,i_core_generateRootLock,i_core_leaderParamsLock,i_core_metricsMutex,i_core_mountsLock,i_core_rekeyLock,i_core_reloadFuncsLock,i_core_requestForwardingConnectionLock,i_core_unsealWithStoredKeysLock,i_db_writer,i_groupLock,i_lock,i_oidcLock,child_MemDBAliasByFactors5874);
	child_MemDBAliasByFactors5874?0;
	stop_process: skip;
	child!0
}
proctype MemDBUpsertAliasInTxn505(Mutexdef i_core_allLoggersLock;Mutexdef i_core_auditLock;Mutexdef i_core_authLock;Mutexdef i_core_clusterParamsLock;Mutexdef i_core_generateRootLock;Mutexdef i_core_leaderParamsLock;Mutexdef i_core_metricsMutex;Mutexdef i_core_mountsLock;Mutexdef i_core_rekeyLock;Mutexdef i_core_reloadFuncsLock;Mutexdef i_core_requestForwardingConnectionLock;Mutexdef i_core_unsealWithStoredKeysLock;Mutexdef i_db_writer;Mutexdef i_groupLock;Mutexdef i_lock;Mutexdef i_oidcLock;Mutexdef txn_db_writer;chan child) {
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
proctype MemDBUpsertGroupInTxn1452(Mutexdef i_core_allLoggersLock;Mutexdef i_core_auditLock;Mutexdef i_core_authLock;Mutexdef i_core_clusterParamsLock;Mutexdef i_core_generateRootLock;Mutexdef i_core_leaderParamsLock;Mutexdef i_core_metricsMutex;Mutexdef i_core_mountsLock;Mutexdef i_core_rekeyLock;Mutexdef i_core_reloadFuncsLock;Mutexdef i_core_requestForwardingConnectionLock;Mutexdef i_core_unsealWithStoredKeysLock;Mutexdef i_db_writer;Mutexdef i_groupLock;Mutexdef i_lock;Mutexdef i_oidcLock;Mutexdef txn_db_writer;chan child) {
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
proctype MemDBAliasByID577(Mutexdef i_core_allLoggersLock;Mutexdef i_core_auditLock;Mutexdef i_core_authLock;Mutexdef i_core_clusterParamsLock;Mutexdef i_core_generateRootLock;Mutexdef i_core_leaderParamsLock;Mutexdef i_core_metricsMutex;Mutexdef i_core_mountsLock;Mutexdef i_core_rekeyLock;Mutexdef i_core_reloadFuncsLock;Mutexdef i_core_requestForwardingConnectionLock;Mutexdef i_core_unsealWithStoredKeysLock;Mutexdef i_db_writer;Mutexdef i_groupLock;Mutexdef i_lock;Mutexdef i_oidcLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_MemDBAliasByIDInTxn5422 = [1] of {int};
	Mutexdef txn_db_writer;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(txn_db_writer);
	run MemDBAliasByIDInTxn542(i_core_allLoggersLock,i_core_auditLock,i_core_authLock,i_core_clusterParamsLock,i_core_generateRootLock,i_core_leaderParamsLock,i_core_metricsMutex,i_core_mountsLock,i_core_rekeyLock,i_core_reloadFuncsLock,i_core_requestForwardingConnectionLock,i_core_unsealWithStoredKeysLock,i_db_writer,i_groupLock,i_lock,i_oidcLock,txn_db_writer,child_MemDBAliasByIDInTxn5422);
	child_MemDBAliasByIDInTxn5422?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype MemDBAliasByIDInTxn542(Mutexdef i_core_allLoggersLock;Mutexdef i_core_auditLock;Mutexdef i_core_authLock;Mutexdef i_core_clusterParamsLock;Mutexdef i_core_generateRootLock;Mutexdef i_core_leaderParamsLock;Mutexdef i_core_metricsMutex;Mutexdef i_core_mountsLock;Mutexdef i_core_rekeyLock;Mutexdef i_core_reloadFuncsLock;Mutexdef i_core_requestForwardingConnectionLock;Mutexdef i_core_unsealWithStoredKeysLock;Mutexdef i_db_writer;Mutexdef i_groupLock;Mutexdef i_lock;Mutexdef i_oidcLock;Mutexdef txn_db_writer;chan child) {
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
proctype MemDBGroupByAliasID1877(Mutexdef i_core_allLoggersLock;Mutexdef i_core_auditLock;Mutexdef i_core_authLock;Mutexdef i_core_clusterParamsLock;Mutexdef i_core_generateRootLock;Mutexdef i_core_leaderParamsLock;Mutexdef i_core_metricsMutex;Mutexdef i_core_mountsLock;Mutexdef i_core_rekeyLock;Mutexdef i_core_reloadFuncsLock;Mutexdef i_core_requestForwardingConnectionLock;Mutexdef i_core_unsealWithStoredKeysLock;Mutexdef i_db_writer;Mutexdef i_groupLock;Mutexdef i_lock;Mutexdef i_oidcLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_MemDBGroupByAliasIDInTxn18563 = [1] of {int};
	Mutexdef txn_db_writer;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(txn_db_writer);
	run MemDBGroupByAliasIDInTxn1856(i_core_allLoggersLock,i_core_auditLock,i_core_authLock,i_core_clusterParamsLock,i_core_generateRootLock,i_core_leaderParamsLock,i_core_metricsMutex,i_core_mountsLock,i_core_rekeyLock,i_core_reloadFuncsLock,i_core_requestForwardingConnectionLock,i_core_unsealWithStoredKeysLock,i_db_writer,i_groupLock,i_lock,i_oidcLock,txn_db_writer,child_MemDBGroupByAliasIDInTxn18563);
	child_MemDBGroupByAliasIDInTxn18563?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype MemDBGroupByAliasIDInTxn1856(Mutexdef i_core_allLoggersLock;Mutexdef i_core_auditLock;Mutexdef i_core_authLock;Mutexdef i_core_clusterParamsLock;Mutexdef i_core_generateRootLock;Mutexdef i_core_leaderParamsLock;Mutexdef i_core_metricsMutex;Mutexdef i_core_mountsLock;Mutexdef i_core_rekeyLock;Mutexdef i_core_reloadFuncsLock;Mutexdef i_core_requestForwardingConnectionLock;Mutexdef i_core_unsealWithStoredKeysLock;Mutexdef i_db_writer;Mutexdef i_groupLock;Mutexdef i_lock;Mutexdef i_oidcLock;Mutexdef txn_db_writer;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_MemDBGroupByIDInTxn15104 = [1] of {int};
	chan child_MemDBAliasByIDInTxn5423 = [1] of {int};
	

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
	run MemDBAliasByIDInTxn542(i_core_allLoggersLock,i_core_auditLock,i_core_authLock,i_core_clusterParamsLock,i_core_generateRootLock,i_core_leaderParamsLock,i_core_metricsMutex,i_core_mountsLock,i_core_rekeyLock,i_core_reloadFuncsLock,i_core_requestForwardingConnectionLock,i_core_unsealWithStoredKeysLock,i_db_writer,i_groupLock,i_lock,i_oidcLock,txn_db_writer,child_MemDBAliasByIDInTxn5423);
	child_MemDBAliasByIDInTxn5423?0;
	

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
	run MemDBGroupByIDInTxn1510(i_core_allLoggersLock,i_core_auditLock,i_core_authLock,i_core_clusterParamsLock,i_core_generateRootLock,i_core_leaderParamsLock,i_core_metricsMutex,i_core_mountsLock,i_core_rekeyLock,i_core_reloadFuncsLock,i_core_requestForwardingConnectionLock,i_core_unsealWithStoredKeysLock,i_db_writer,i_groupLock,i_lock,i_oidcLock,txn_db_writer,child_MemDBGroupByIDInTxn15104);
	child_MemDBGroupByIDInTxn15104?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype MemDBGroupByIDInTxn1510(Mutexdef i_core_allLoggersLock;Mutexdef i_core_auditLock;Mutexdef i_core_authLock;Mutexdef i_core_clusterParamsLock;Mutexdef i_core_generateRootLock;Mutexdef i_core_leaderParamsLock;Mutexdef i_core_metricsMutex;Mutexdef i_core_mountsLock;Mutexdef i_core_rekeyLock;Mutexdef i_core_reloadFuncsLock;Mutexdef i_core_requestForwardingConnectionLock;Mutexdef i_core_unsealWithStoredKeysLock;Mutexdef i_db_writer;Mutexdef i_groupLock;Mutexdef i_lock;Mutexdef i_oidcLock;Mutexdef txn_db_writer;chan child) {
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
proctype MemDBAliasByFactors587(Mutexdef i_core_allLoggersLock;Mutexdef i_core_auditLock;Mutexdef i_core_authLock;Mutexdef i_core_clusterParamsLock;Mutexdef i_core_generateRootLock;Mutexdef i_core_leaderParamsLock;Mutexdef i_core_metricsMutex;Mutexdef i_core_mountsLock;Mutexdef i_core_rekeyLock;Mutexdef i_core_reloadFuncsLock;Mutexdef i_core_requestForwardingConnectionLock;Mutexdef i_core_unsealWithStoredKeysLock;Mutexdef i_db_writer;Mutexdef i_groupLock;Mutexdef i_lock;Mutexdef i_oidcLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_MemDBAliasByFactorsInTxn6014 = [1] of {int};
	Mutexdef txn_db_writer;
	

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
	run mutexMonitor(txn_db_writer);
	run MemDBAliasByFactorsInTxn601(i_core_allLoggersLock,i_core_auditLock,i_core_authLock,i_core_clusterParamsLock,i_core_generateRootLock,i_core_leaderParamsLock,i_core_metricsMutex,i_core_mountsLock,i_core_rekeyLock,i_core_reloadFuncsLock,i_core_requestForwardingConnectionLock,i_core_unsealWithStoredKeysLock,i_db_writer,i_groupLock,i_lock,i_oidcLock,txn_db_writer,child_MemDBAliasByFactorsInTxn6014);
	child_MemDBAliasByFactorsInTxn6014?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype MemDBAliasByFactorsInTxn601(Mutexdef i_core_allLoggersLock;Mutexdef i_core_auditLock;Mutexdef i_core_authLock;Mutexdef i_core_clusterParamsLock;Mutexdef i_core_generateRootLock;Mutexdef i_core_leaderParamsLock;Mutexdef i_core_metricsMutex;Mutexdef i_core_mountsLock;Mutexdef i_core_rekeyLock;Mutexdef i_core_reloadFuncsLock;Mutexdef i_core_requestForwardingConnectionLock;Mutexdef i_core_unsealWithStoredKeysLock;Mutexdef i_db_writer;Mutexdef i_groupLock;Mutexdef i_lock;Mutexdef i_oidcLock;Mutexdef txn_db_writer;chan child) {
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

