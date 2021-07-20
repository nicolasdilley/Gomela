// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob/f8f289712a3d37115090591602a2b92503fb3a13/vault/identity_store_oidc_test.go#L546
#define ub_for610_3  -2
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
	chan child_TestOIDC_PeriodicFunc5460 = [1] of {int};
	run TestOIDC_PeriodicFunc546(child_TestOIDC_PeriodicFunc5460);
	run receiver(child_TestOIDC_PeriodicFunc5460)
stop_process:skip
}

proctype TestOIDC_PeriodicFunc546(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_oidcPeriodicFunc15662 = [1] of {int};
	chan child_oidcPeriodicFunc15661 = [1] of {int};
	chan child_MatchingStorageByAPIPath3440 = [1] of {int};
	chan child_oidcPeriodicFunc15665 = [1] of {int};
	chan child_oidcPeriodicFunc15664 = [1] of {int};
	chan child_MatchingStorageByAPIPath3443 = [1] of {int};
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
	int var_testSet_testCasestestSet_testCases = -2; // opt var_testSet_testCasestestSet_testCases
	int var_testSetstestSets = -2; // opt var_testSetstestSets
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
	

	if
	:: var_testSets-1 != -3 -> 
				for(i : 0.. var_testSets-1) {
			for10: skip;
			run MatchingStorageByAPIPath344(c_router_l,child_MatchingStorageByAPIPath3440);
			child_MatchingStorageByAPIPath3440?0;
			

			if
			:: 0 != -2 && ub_for610_3 != -2 -> 
								for(i : 0.. ub_for610_3) {
					for114: skip;
					run oidcPeriodicFunc1566(c_identityStore_groupLock,c_identityStore_lock,c_identityStore_oidcLock,child_oidcPeriodicFunc15662);
					child_oidcPeriodicFunc15662?0;
					for114_end: skip
				};
				for114_exit: skip
			:: else -> 
				do
				:: true -> 
					for11: skip;
					run oidcPeriodicFunc1566(c_identityStore_groupLock,c_identityStore_lock,c_identityStore_oidcLock,child_oidcPeriodicFunc15661);
					child_oidcPeriodicFunc15661?0;
					for11_end: skip
				:: true -> 
					break
				od;
				for11_exit: skip
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for117: skip;
			run MatchingStorageByAPIPath344(c_router_l,child_MatchingStorageByAPIPath3443);
			child_MatchingStorageByAPIPath3443?0;
			

			if
			:: 0 != -2 && ub_for610_3 != -2 -> 
								for(i : 0.. ub_for610_3) {
					for119: skip;
					run oidcPeriodicFunc1566(c_identityStore_groupLock,c_identityStore_lock,c_identityStore_oidcLock,child_oidcPeriodicFunc15665);
					child_oidcPeriodicFunc15665?0;
					for119_end: skip
				};
				for119_exit: skip
			:: else -> 
				do
				:: true -> 
					for118: skip;
					run oidcPeriodicFunc1566(c_identityStore_groupLock,c_identityStore_lock,c_identityStore_oidcLock,child_oidcPeriodicFunc15664);
					child_oidcPeriodicFunc15664?0;
					for118_end: skip
				:: true -> 
					break
				od;
				for118_exit: skip
			fi;
			for117_end: skip
		:: true -> 
			break
		od;
		for117_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype MatchingStorageByAPIPath344(Mutexdef r_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_matchingStorage3520 = [1] of {int};
	run matchingStorage352(r_l,child_matchingStorage3520);
	child_matchingStorage3520?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype matchingStorage352(Mutexdef r_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	r_l.RLock!false;
	r_l.RUnlock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype oidcPeriodicFunc1566(Mutexdef i_groupLock;Mutexdef i_lock;Mutexdef i_oidcLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_expireOIDCPublicKeys14112 = [1] of {int};
	chan child_oidcKeyRotation15121 = [1] of {int};
	chan child_expireOIDCPublicKeys14114 = [1] of {int};
	chan child_oidcKeyRotation15123 = [1] of {int};
	int var_i_listNamespaces__i_listNamespaces__ = -2; // opt var_i_listNamespaces__i_listNamespaces__
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: var_i_listNamespaces__-1 != -3 -> 
						for(i : 0.. var_i_listNamespaces__-1) {
				for12: skip;
				

				if
				:: true -> 
					goto for12_end
				:: true;
				fi;
				run oidcKeyRotation1512(i_groupLock,i_lock,i_oidcLock,child_oidcKeyRotation15121);
				child_oidcKeyRotation15121?0;
				run expireOIDCPublicKeys1411(i_groupLock,i_lock,i_oidcLock,child_expireOIDCPublicKeys14112);
				child_expireOIDCPublicKeys14112?0;
				for12_end: skip
			};
			for12_exit: skip
		:: else -> 
			do
			:: true -> 
				for113: skip;
				

				if
				:: true -> 
					goto for113_end
				:: true;
				fi;
				run oidcKeyRotation1512(i_groupLock,i_lock,i_oidcLock,child_oidcKeyRotation15123);
				child_oidcKeyRotation15123?0;
				run expireOIDCPublicKeys1411(i_groupLock,i_lock,i_oidcLock,child_expireOIDCPublicKeys14114);
				child_expireOIDCPublicKeys14114?0;
				for113_end: skip
			:: true -> 
				break
			od;
			for113_exit: skip
		fi
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype oidcKeyRotation1512(Mutexdef i_groupLock;Mutexdef i_lock;Mutexdef i_oidcLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_keyskeys = -2; // opt var_keyskeys
	i_oidcLock.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	i_oidcLock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype expireOIDCPublicKeys1411(Mutexdef i_groupLock;Mutexdef i_lock;Mutexdef i_oidcLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_publicKeyIDspublicKeyIDs = -2; // opt var_publicKeyIDspublicKeyIDs
	int var_keyRingkeyRing = -2; // opt var_keyRingkeyRing
	int var_namedKeysnamedKeys = -2; // opt var_namedKeysnamedKeys
	i_oidcLock.Lock!false;
	

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
	goto defer1;
		defer1: skip;
	i_oidcLock.Unlock!false;
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

