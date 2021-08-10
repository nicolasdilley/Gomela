// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob/f8f289712a3d37115090591602a2b92503fb3a13/vault/plugin_catalog_test.go#L112
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
	chan child_TestPluginCatalog_List1120 = [1] of {int};
	run TestPluginCatalog_List112(child_TestPluginCatalog_List1120);
	run receiver(child_TestPluginCatalog_List1120)
stop_process:skip
}

proctype TestPluginCatalog_List112(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_List3583 = [1] of {int};
	chan child_Set2582 = [1] of {int};
	chan child_Set2581 = [1] of {int};
	chan child_List3580 = [1] of {int};
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
	int var_builtinKeys = -2; // opt var_builtinKeys
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
	run List358(core_pluginCatalog_lock,child_List3580);
	child_List3580?0;
	run Set258(core_pluginCatalog_lock,child_Set2581);
	child_Set2581?0;
	run Set258(core_pluginCatalog_lock,child_Set2582);
	child_Set2582?0;
	run List358(core_pluginCatalog_lock,child_List3583);
	child_List3583?0;
	stop_process: skip;
	child!0
}
proctype List358(Mutexdef c_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_get2120 = [1] of {int};
	chan child_get2121 = [1] of {int};
	int var_mapKeys = -2; // opt var_mapKeys
	int var_builtinKeys = -2; // opt var_builtinKeys
	int var_keys = -2; // opt var_keys
	c_lock.RLock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: var_keys-1 != -3 -> 
				for(i : 0.. var_keys-1) {
			for10: skip;
			run get212(c_lock,child_get2120);
			child_get2120?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run get212(c_lock,child_get2121);
			child_get2121?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	goto defer1;
		defer1: skip;
	c_lock.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype get212(Mutexdef c_lock;chan child) {
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
proctype Set258(Mutexdef c_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_setInternal2761 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true;
	:: true -> 
		goto stop_process
	fi;
	c_lock.Lock!false;
	run setInternal276(c_lock,child_setInternal2761);
	child_setInternal2761?0;
	goto defer1;
		defer1: skip;
	c_lock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype setInternal276(Mutexdef c_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getPluginTypeFromUnknown661 = [1] of {int};
	

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
		run getPluginTypeFromUnknown66(c_lock,child_getPluginTypeFromUnknown661);
		child_getPluginTypeFromUnknown661?0;
		

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
proctype getPluginTypeFromUnknown66(Mutexdef c_lock;chan child) {
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
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		fi
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

