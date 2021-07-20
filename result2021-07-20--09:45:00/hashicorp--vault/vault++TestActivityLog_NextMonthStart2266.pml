// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob/f8f289712a3d37115090591602a2b92503fb3a13/vault/activity_log_test.go#L2266
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
	chan child_TestActivityLog_NextMonthStart22660 = [1] of {int};
	run TestActivityLog_NextMonthStart2266(child_TestActivityLog_NextMonthStart22660);
	run receiver(child_TestActivityLog_NextMonthStart22660)
stop_process:skip
}

proctype TestActivityLog_NextMonthStart2266(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_StartOfNextMonth10131 = [1] of {int};
	chan child_SetStartTimestamp1590 = [1] of {int};
	chan child_StartOfNextMonth10133 = [1] of {int};
	chan child_SetStartTimestamp1592 = [1] of {int};
	Mutexdef a_view_readOnlyErrLock;
	Mutexdef a_fragmentLock;
	Mutexdef a_l;
	Mutexdef a_core_allLoggersLock;
	Mutexdef a_core_unsealWithStoredKeysLock;
	Mutexdef a_core_leaderParamsLock;
	Mutexdef a_core_requestForwardingConnectionLock;
	Mutexdef a_core_clusterParamsLock;
	Mutexdef a_core_reloadFuncsLock;
	Mutexdef a_core_metricsMutex;
	Mutexdef a_core_auditLock;
	Mutexdef a_core_authLock;
	Mutexdef a_core_mountsLock;
	Mutexdef a_core_rekeyLock;
	Mutexdef a_core_generateRootLock;
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
	int var_testCasestestCases = -2; // opt var_testCasestestCases
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
	run mutexMonitor(a_core_generateRootLock);
	run mutexMonitor(a_core_rekeyLock);
	run mutexMonitor(a_core_mountsLock);
	run mutexMonitor(a_core_authLock);
	run mutexMonitor(a_core_auditLock);
	run mutexMonitor(a_core_metricsMutex);
	run mutexMonitor(a_core_reloadFuncsLock);
	run mutexMonitor(a_core_clusterParamsLock);
	run mutexMonitor(a_core_requestForwardingConnectionLock);
	run mutexMonitor(a_core_leaderParamsLock);
	run mutexMonitor(a_core_unsealWithStoredKeysLock);
	run mutexMonitor(a_core_allLoggersLock);
	run mutexMonitor(a_l);
	run mutexMonitor(a_fragmentLock);
	run mutexMonitor(a_view_readOnlyErrLock);
	

	if
	:: var_testCases-1 != -3 -> 
				for(i : 0.. var_testCases-1) {
			for10: skip;
			run SetStartTimestamp159(a_core_allLoggersLock,a_core_auditLock,a_core_authLock,a_core_clusterParamsLock,a_core_generateRootLock,a_core_leaderParamsLock,a_core_metricsMutex,a_core_mountsLock,a_core_rekeyLock,a_core_reloadFuncsLock,a_core_requestForwardingConnectionLock,a_core_unsealWithStoredKeysLock,a_fragmentLock,a_l,a_view_readOnlyErrLock,child_SetStartTimestamp1590);
			child_SetStartTimestamp1590?0;
			run StartOfNextMonth1013(a_core_allLoggersLock,a_core_auditLock,a_core_authLock,a_core_clusterParamsLock,a_core_generateRootLock,a_core_leaderParamsLock,a_core_metricsMutex,a_core_mountsLock,a_core_rekeyLock,a_core_reloadFuncsLock,a_core_requestForwardingConnectionLock,a_core_unsealWithStoredKeysLock,a_fragmentLock,a_l,a_view_readOnlyErrLock,child_StartOfNextMonth10131);
			child_StartOfNextMonth10131?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run SetStartTimestamp159(a_core_allLoggersLock,a_core_auditLock,a_core_authLock,a_core_clusterParamsLock,a_core_generateRootLock,a_core_leaderParamsLock,a_core_metricsMutex,a_core_mountsLock,a_core_rekeyLock,a_core_reloadFuncsLock,a_core_requestForwardingConnectionLock,a_core_unsealWithStoredKeysLock,a_fragmentLock,a_l,a_view_readOnlyErrLock,child_SetStartTimestamp1592);
			child_SetStartTimestamp1592?0;
			run StartOfNextMonth1013(a_core_allLoggersLock,a_core_auditLock,a_core_authLock,a_core_clusterParamsLock,a_core_generateRootLock,a_core_leaderParamsLock,a_core_metricsMutex,a_core_mountsLock,a_core_rekeyLock,a_core_reloadFuncsLock,a_core_requestForwardingConnectionLock,a_core_unsealWithStoredKeysLock,a_fragmentLock,a_l,a_view_readOnlyErrLock,child_StartOfNextMonth10133);
			child_StartOfNextMonth10133?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype SetStartTimestamp159(Mutexdef a_core_allLoggersLock;Mutexdef a_core_auditLock;Mutexdef a_core_authLock;Mutexdef a_core_clusterParamsLock;Mutexdef a_core_generateRootLock;Mutexdef a_core_leaderParamsLock;Mutexdef a_core_metricsMutex;Mutexdef a_core_mountsLock;Mutexdef a_core_rekeyLock;Mutexdef a_core_reloadFuncsLock;Mutexdef a_core_requestForwardingConnectionLock;Mutexdef a_core_unsealWithStoredKeysLock;Mutexdef a_fragmentLock;Mutexdef a_l;Mutexdef a_view_readOnlyErrLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	a_l.Lock!false;
		defer1: skip;
	a_l.Unlock!false;
	stop_process: skip;
	child!0
}
proctype StartOfNextMonth1013(Mutexdef a_core_allLoggersLock;Mutexdef a_core_auditLock;Mutexdef a_core_authLock;Mutexdef a_core_clusterParamsLock;Mutexdef a_core_generateRootLock;Mutexdef a_core_leaderParamsLock;Mutexdef a_core_metricsMutex;Mutexdef a_core_mountsLock;Mutexdef a_core_rekeyLock;Mutexdef a_core_reloadFuncsLock;Mutexdef a_core_requestForwardingConnectionLock;Mutexdef a_core_unsealWithStoredKeysLock;Mutexdef a_fragmentLock;Mutexdef a_l;Mutexdef a_view_readOnlyErrLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	a_l.RLock!false;
	goto defer1;
		defer1: skip;
	a_l.RUnlock!false;
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

