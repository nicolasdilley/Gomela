
// https://github.com/hashicorp/vault/blob/master/vault/plugin_catalog_test.go#L19
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
	chan child_TestPluginCatalog_CRUD190 = [1] of {int};
	run TestPluginCatalog_CRUD19(child_TestPluginCatalog_CRUD190)
stop_process:skip
}

proctype TestPluginCatalog_CRUD19(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get2054 = [1] of {int};
	chan child_Delete3423 = [1] of {int};
	chan child_Get2052 = [1] of {int};
	chan child_Set2581 = [1] of {int};
	chan child_Get2050 = [1] of {int};
	Mutexdef core_quotaManager_lock;
	Mutexdef core_quotaManager_rateLimitPathManager_l;
	Mutexdef core_quotaManager_db_writer;
	Mutexdef core_pendingRaftPeers_mu;
	Mutexdef core_raftFollowerStates_l;
	Mutexdef core_metricsHelper_LoopMetrics_Metrics_mu;
	Mutexdef core_metricsHelper_inMemSink_intervalLock;
	Mutexdef core_allLoggersLock;
	Mutexdef core_unsealWithStoredKeysLock;
	Mutexdef core_pluginCatalog_lock;
	Mutexdef core_pluginCatalog_catalogView_readOnlyErrLock;
	Mutexdef core_uiConfig_l;
	Mutexdef core_rpcClientConn_firstResolveEvent_o_m;
	Mutexdef core_rpcClientConn_balancerWrapper_mu;
	Mutexdef core_rpcClientConn_balancerWrapper_done_o_m;
	Mutexdef core_rpcClientConn_balancerWrapper_scBuffer_mu;
	Mutexdef core_rpcClientConn_balancerWrapper_balancerMu;
	Mutexdef core_rpcClientConn_resolverWrapper_pollingMu;
	Mutexdef core_rpcClientConn_resolverWrapper_done_o_m;
	Mutexdef core_rpcClientConn_resolverWrapper_resolverMu;
	Mutexdef core_rpcClientConn_mu;
	Mutexdef core_rpcClientConn_blockingpicker_mu;
	Mutexdef core_rpcClientConn_csMgr_mu;
	Mutexdef core_leaderParamsLock;
	Mutexdef core_requestForwardingConnectionLock;
	Mutexdef core_clusterParamsLock;
	Mutexdef core_reloadFuncsLock;
	Mutexdef core_metricsMutex;
	Mutexdef core_activityLog_currentSegment_tokenCount_state_atomicMessageInfo_initMu;
	Mutexdef core_activityLog_currentSegment_currentEntities_state_atomicMessageInfo_initMu;
	Mutexdef core_activityLog_fragment_state_atomicMessageInfo_initMu;
	Mutexdef core_activityLog_view_readOnlyErrLock;
	Mutexdef core_activityLog_fragmentLock;
	Mutexdef core_activityLog_l;
	Mutexdef core_identityStore_groupLock;
	Mutexdef core_identityStore_oidcLock;
	Mutexdef core_identityStore_lock;
	Mutexdef core_identityStore_db_writer;
	Mutexdef core_tokenStore_saltLock;
	Mutexdef core_tokenStore_tokensPendingDeletion_mu;
	Mutexdef core_tokenStore_activityLog_currentSegment_tokenCount_state_atomicMessageInfo_initMu;
	Mutexdef core_tokenStore_activityLog_currentSegment_currentEntities_state_atomicMessageInfo_initMu;
	Mutexdef core_tokenStore_activityLog_fragment_state_atomicMessageInfo_initMu;
	Mutexdef core_tokenStore_activityLog_view_readOnlyErrLock;
	Mutexdef core_tokenStore_activityLog_fragmentLock;
	Mutexdef core_tokenStore_activityLog_l;
	Mutexdef core_tokenStore_expiration_jobManager_l;
	Wgdef core_tokenStore_expiration_jobManager_wg;
	Mutexdef core_tokenStore_expiration_jobManager_onceStop_m;
	Mutexdef core_tokenStore_expiration_jobManager_onceStart_m;
	Wgdef core_tokenStore_expiration_jobManager_workerPool_wg;
	Mutexdef core_tokenStore_expiration_jobManager_workerPool_onceStop_m;
	Mutexdef core_tokenStore_expiration_jobManager_workerPool_onceStart_m;
	Mutexdef core_tokenStore_expiration_restoreLoaded_mu;
	Mutexdef core_tokenStore_expiration_restoreRequestLock;
	Mutexdef core_tokenStore_expiration_restoreModeLock;
	Mutexdef core_tokenStore_expiration_pendingLock;
	Mutexdef core_tokenStore_expiration_nonexpiring_mu;
	Mutexdef core_tokenStore_expiration_pending_mu;
	Mutexdef core_tokenStore_expiration_tokenView_readOnlyErrLock;
	Mutexdef core_tokenStore_expiration_idView_readOnlyErrLock;
	Mutexdef core_tokenStore_expiration_router_l;
	Mutexdef core_tokenStore_rolesBarrierView_readOnlyErrLock;
	Mutexdef core_tokenStore_parentBarrierView_readOnlyErrLock;
	Mutexdef core_tokenStore_accessorBarrierView_readOnlyErrLock;
	Mutexdef core_tokenStore_idBarrierView_readOnlyErrLock;
	Mutexdef core_tokenStore_baseBarrierView_readOnlyErrLock;
	Mutexdef core_policyStore_policyTypeMap_mu;
	Mutexdef core_policyStore_modifyLock;
	Mutexdef core_policyStore_egpLRU_lock;
	Mutexdef core_policyStore_tokenPoliciesLRU_lock;
	Mutexdef core_policyStore_egpView_readOnlyErrLock;
	Mutexdef core_policyStore_rgpView_readOnlyErrLock;
	Mutexdef core_policyStore_aclView_readOnlyErrLock;
	Mutexdef core_rollback_shutdownLock;
	Mutexdef core_rollback_inflightLock;
	Wgdef core_rollback_inflightAll;
	Mutexdef core_rollback_router_l;
	Mutexdef core_expiration_jobManager_l;
	Wgdef core_expiration_jobManager_wg;
	Mutexdef core_expiration_jobManager_onceStop_m;
	Mutexdef core_expiration_jobManager_onceStart_m;
	Wgdef core_expiration_jobManager_workerPool_wg;
	Mutexdef core_expiration_jobManager_workerPool_onceStop_m;
	Mutexdef core_expiration_jobManager_workerPool_onceStart_m;
	Mutexdef core_expiration_restoreLoaded_mu;
	Mutexdef core_expiration_restoreRequestLock;
	Mutexdef core_expiration_restoreModeLock;
	Mutexdef core_expiration_pendingLock;
	Mutexdef core_expiration_nonexpiring_mu;
	Mutexdef core_expiration_pending_mu;
	Mutexdef core_expiration_tokenStore_saltLock;
	Mutexdef core_expiration_tokenStore_tokensPendingDeletion_mu;
	Mutexdef core_expiration_tokenStore_activityLog_currentSegment_tokenCount_state_atomicMessageInfo_initMu;
	Mutexdef core_expiration_tokenStore_activityLog_currentSegment_currentEntities_state_atomicMessageInfo_initMu;
	Mutexdef core_expiration_tokenStore_activityLog_fragment_state_atomicMessageInfo_initMu;
	Mutexdef core_expiration_tokenStore_activityLog_view_readOnlyErrLock;
	Mutexdef core_expiration_tokenStore_activityLog_fragmentLock;
	Mutexdef core_expiration_tokenStore_activityLog_l;
	Mutexdef core_expiration_tokenStore_rolesBarrierView_readOnlyErrLock;
	Mutexdef core_expiration_tokenStore_parentBarrierView_readOnlyErrLock;
	Mutexdef core_expiration_tokenStore_accessorBarrierView_readOnlyErrLock;
	Mutexdef core_expiration_tokenStore_idBarrierView_readOnlyErrLock;
	Mutexdef core_expiration_tokenStore_baseBarrierView_readOnlyErrLock;
	Mutexdef core_expiration_tokenView_readOnlyErrLock;
	Mutexdef core_expiration_idView_readOnlyErrLock;
	Mutexdef core_expiration_router_l;
	Mutexdef core_systemBarrierView_readOnlyErrLock;
	Mutexdef core_systemBackend_mfaLock;
	Mutexdef core_systemBackend_db_writer;
	Mutexdef core_auditedHeaders_view_readOnlyErrLock;
	Mutexdef core_auditLock;
	Mutexdef core_authLock;
	Mutexdef core_mountsLock;
	Mutexdef core_rekeyLock;
	Mutexdef core_generateRootLock;
	Mutexdef core_router_l;
	Mutexdef core_raftInfo_leaderClient_config_Limiter_mu;
	Mutexdef core_raftInfo_leaderClient_config_modifyLock;
	Mutexdef core_raftInfo_leaderClient_modifyLock;
	Mutexdef core_raftInfo_challenge_KeyInfo_state_atomicMessageInfo_initMu;
	Mutexdef core_raftInfo_challenge_state_atomicMessageInfo_initMu;
	run mutexMonitor(core_raftInfo_challenge_state_atomicMessageInfo_initMu);
	run mutexMonitor(core_raftInfo_challenge_KeyInfo_state_atomicMessageInfo_initMu);
	run mutexMonitor(core_raftInfo_leaderClient_modifyLock);
	run mutexMonitor(core_raftInfo_leaderClient_config_modifyLock);
	run mutexMonitor(core_raftInfo_leaderClient_config_Limiter_mu);
	run mutexMonitor(core_router_l);
	run mutexMonitor(core_generateRootLock);
	run mutexMonitor(core_rekeyLock);
	run mutexMonitor(core_mountsLock);
	run mutexMonitor(core_authLock);
	run mutexMonitor(core_auditLock);
	run mutexMonitor(core_auditedHeaders_view_readOnlyErrLock);
	run mutexMonitor(core_systemBackend_db_writer);
	run mutexMonitor(core_systemBackend_mfaLock);
	run mutexMonitor(core_systemBarrierView_readOnlyErrLock);
	run mutexMonitor(core_expiration_router_l);
	run mutexMonitor(core_expiration_idView_readOnlyErrLock);
	run mutexMonitor(core_expiration_tokenView_readOnlyErrLock);
	run mutexMonitor(core_expiration_tokenStore_baseBarrierView_readOnlyErrLock);
	run mutexMonitor(core_expiration_tokenStore_idBarrierView_readOnlyErrLock);
	run mutexMonitor(core_expiration_tokenStore_accessorBarrierView_readOnlyErrLock);
	run mutexMonitor(core_expiration_tokenStore_parentBarrierView_readOnlyErrLock);
	run mutexMonitor(core_expiration_tokenStore_rolesBarrierView_readOnlyErrLock);
	run mutexMonitor(core_expiration_tokenStore_activityLog_l);
	run mutexMonitor(core_expiration_tokenStore_activityLog_fragmentLock);
	run mutexMonitor(core_expiration_tokenStore_activityLog_view_readOnlyErrLock);
	run mutexMonitor(core_expiration_tokenStore_activityLog_fragment_state_atomicMessageInfo_initMu);
	run mutexMonitor(core_expiration_tokenStore_activityLog_currentSegment_currentEntities_state_atomicMessageInfo_initMu);
	run mutexMonitor(core_expiration_tokenStore_activityLog_currentSegment_tokenCount_state_atomicMessageInfo_initMu);
	run mutexMonitor(core_expiration_tokenStore_tokensPendingDeletion_mu);
	run mutexMonitor(core_expiration_tokenStore_saltLock);
	run mutexMonitor(core_expiration_pending_mu);
	run mutexMonitor(core_expiration_nonexpiring_mu);
	run mutexMonitor(core_expiration_pendingLock);
	run mutexMonitor(core_expiration_restoreModeLock);
	run mutexMonitor(core_expiration_restoreRequestLock);
	run mutexMonitor(core_expiration_restoreLoaded_mu);
	run mutexMonitor(core_expiration_jobManager_workerPool_onceStart_m);
	run mutexMonitor(core_expiration_jobManager_workerPool_onceStop_m);
	run wgMonitor(core_expiration_jobManager_workerPool_wg);
	run mutexMonitor(core_expiration_jobManager_onceStart_m);
	run mutexMonitor(core_expiration_jobManager_onceStop_m);
	run wgMonitor(core_expiration_jobManager_wg);
	run mutexMonitor(core_expiration_jobManager_l);
	run mutexMonitor(core_rollback_router_l);
	run wgMonitor(core_rollback_inflightAll);
	run mutexMonitor(core_rollback_inflightLock);
	run mutexMonitor(core_rollback_shutdownLock);
	run mutexMonitor(core_policyStore_aclView_readOnlyErrLock);
	run mutexMonitor(core_policyStore_rgpView_readOnlyErrLock);
	run mutexMonitor(core_policyStore_egpView_readOnlyErrLock);
	run mutexMonitor(core_policyStore_tokenPoliciesLRU_lock);
	run mutexMonitor(core_policyStore_egpLRU_lock);
	run mutexMonitor(core_policyStore_modifyLock);
	run mutexMonitor(core_policyStore_policyTypeMap_mu);
	run mutexMonitor(core_tokenStore_baseBarrierView_readOnlyErrLock);
	run mutexMonitor(core_tokenStore_idBarrierView_readOnlyErrLock);
	run mutexMonitor(core_tokenStore_accessorBarrierView_readOnlyErrLock);
	run mutexMonitor(core_tokenStore_parentBarrierView_readOnlyErrLock);
	run mutexMonitor(core_tokenStore_rolesBarrierView_readOnlyErrLock);
	run mutexMonitor(core_tokenStore_expiration_router_l);
	run mutexMonitor(core_tokenStore_expiration_idView_readOnlyErrLock);
	run mutexMonitor(core_tokenStore_expiration_tokenView_readOnlyErrLock);
	run mutexMonitor(core_tokenStore_expiration_pending_mu);
	run mutexMonitor(core_tokenStore_expiration_nonexpiring_mu);
	run mutexMonitor(core_tokenStore_expiration_pendingLock);
	run mutexMonitor(core_tokenStore_expiration_restoreModeLock);
	run mutexMonitor(core_tokenStore_expiration_restoreRequestLock);
	run mutexMonitor(core_tokenStore_expiration_restoreLoaded_mu);
	run mutexMonitor(core_tokenStore_expiration_jobManager_workerPool_onceStart_m);
	run mutexMonitor(core_tokenStore_expiration_jobManager_workerPool_onceStop_m);
	run wgMonitor(core_tokenStore_expiration_jobManager_workerPool_wg);
	run mutexMonitor(core_tokenStore_expiration_jobManager_onceStart_m);
	run mutexMonitor(core_tokenStore_expiration_jobManager_onceStop_m);
	run wgMonitor(core_tokenStore_expiration_jobManager_wg);
	run mutexMonitor(core_tokenStore_expiration_jobManager_l);
	run mutexMonitor(core_tokenStore_activityLog_l);
	run mutexMonitor(core_tokenStore_activityLog_fragmentLock);
	run mutexMonitor(core_tokenStore_activityLog_view_readOnlyErrLock);
	run mutexMonitor(core_tokenStore_activityLog_fragment_state_atomicMessageInfo_initMu);
	run mutexMonitor(core_tokenStore_activityLog_currentSegment_currentEntities_state_atomicMessageInfo_initMu);
	run mutexMonitor(core_tokenStore_activityLog_currentSegment_tokenCount_state_atomicMessageInfo_initMu);
	run mutexMonitor(core_tokenStore_tokensPendingDeletion_mu);
	run mutexMonitor(core_tokenStore_saltLock);
	run mutexMonitor(core_identityStore_db_writer);
	run mutexMonitor(core_identityStore_lock);
	run mutexMonitor(core_identityStore_oidcLock);
	run mutexMonitor(core_identityStore_groupLock);
	run mutexMonitor(core_activityLog_l);
	run mutexMonitor(core_activityLog_fragmentLock);
	run mutexMonitor(core_activityLog_view_readOnlyErrLock);
	run mutexMonitor(core_activityLog_fragment_state_atomicMessageInfo_initMu);
	run mutexMonitor(core_activityLog_currentSegment_currentEntities_state_atomicMessageInfo_initMu);
	run mutexMonitor(core_activityLog_currentSegment_tokenCount_state_atomicMessageInfo_initMu);
	run mutexMonitor(core_metricsMutex);
	run mutexMonitor(core_reloadFuncsLock);
	run mutexMonitor(core_clusterParamsLock);
	run mutexMonitor(core_requestForwardingConnectionLock);
	run mutexMonitor(core_leaderParamsLock);
	run mutexMonitor(core_rpcClientConn_csMgr_mu);
	run mutexMonitor(core_rpcClientConn_blockingpicker_mu);
	run mutexMonitor(core_rpcClientConn_mu);
	run mutexMonitor(core_rpcClientConn_resolverWrapper_resolverMu);
	run mutexMonitor(core_rpcClientConn_resolverWrapper_done_o_m);
	run mutexMonitor(core_rpcClientConn_resolverWrapper_pollingMu);
	run mutexMonitor(core_rpcClientConn_balancerWrapper_balancerMu);
	run mutexMonitor(core_rpcClientConn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(core_rpcClientConn_balancerWrapper_done_o_m);
	run mutexMonitor(core_rpcClientConn_balancerWrapper_mu);
	run mutexMonitor(core_rpcClientConn_firstResolveEvent_o_m);
	run mutexMonitor(core_uiConfig_l);
	run mutexMonitor(core_pluginCatalog_catalogView_readOnlyErrLock);
	run mutexMonitor(core_pluginCatalog_lock);
	run mutexMonitor(core_unsealWithStoredKeysLock);
	run mutexMonitor(core_allLoggersLock);
	run mutexMonitor(core_metricsHelper_inMemSink_intervalLock);
	run mutexMonitor(core_metricsHelper_LoopMetrics_Metrics_mu);
	run mutexMonitor(core_raftFollowerStates_l);
	run mutexMonitor(core_pendingRaftPeers_mu);
	run mutexMonitor(core_quotaManager_db_writer);
	run mutexMonitor(core_quotaManager_rateLimitPathManager_l);
	run mutexMonitor(core_quotaManager_lock);
	run Get205(core_pluginCatalog_catalogView_readOnlyErrLock,core_pluginCatalog_lock,child_Get2050);
	child_Get2050?0;
	run Set258(core_pluginCatalog_catalogView_readOnlyErrLock,core_pluginCatalog_lock,child_Set2581);
	child_Set2581?0;
	run Get205(core_pluginCatalog_catalogView_readOnlyErrLock,core_pluginCatalog_lock,child_Get2052);
	child_Get2052?0;
	run Delete342(core_pluginCatalog_catalogView_readOnlyErrLock,core_pluginCatalog_lock,child_Delete3423);
	child_Delete3423?0;
	run Get205(core_pluginCatalog_catalogView_readOnlyErrLock,core_pluginCatalog_lock,child_Get2054);
	child_Get2054?0;
	stop_process: skip;
	child!0
}
proctype Get205(Mutexdef c_catalogView_readOnlyErrLock;Mutexdef c_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_get2120 = [1] of {int};
	c_lock.RLock!false;
	run get212(c_catalogView_readOnlyErrLock,c_lock,child_get2120);
	child_get2120?0;
	c_lock.RUnlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype get212(Mutexdef c_catalogView_readOnlyErrLock;Mutexdef c_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get571 = [1] of {int};
	chan child_Get570 = [1] of {int};
	

	if
	:: true -> 
		run Get57(c_catalogView_readOnlyErrLock,child_Get570);
		child_Get570?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			run Get57(c_catalogView_readOnlyErrLock,child_Get571);
			child_Get571?0;
			

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
proctype Get57(Mutexdef v_readOnlyErrLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Set258(Mutexdef c_catalogView_readOnlyErrLock;Mutexdef c_lock;chan child) {
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
	run setInternal276(c_catalogView_readOnlyErrLock,c_lock,child_setInternal2761);
	child_setInternal2761?0;
	goto stop_process;
	stop_process: skip;
		c_lock.Unlock!false;
	child!0
}
proctype setInternal276(Mutexdef c_catalogView_readOnlyErrLock;Mutexdef c_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Put622 = [1] of {int};
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
		run getPluginTypeFromUnknown66(c_catalogView_readOnlyErrLock,c_lock,child_getPluginTypeFromUnknown661);
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
	run Put62(c_catalogView_readOnlyErrLock,child_Put622);
	child_Put622?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getPluginTypeFromUnknown66(Mutexdef c_catalogView_readOnlyErrLock;Mutexdef c_lock;chan child) {
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
proctype Put62(Mutexdef v_readOnlyErrLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_runICheck53 = [1] of {int};
	chan child_getReadOnlyErr432 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run getReadOnlyErr43(v_readOnlyErrLock,child_getReadOnlyErr432);
	child_getReadOnlyErr432?0;
	

	if
	:: true -> 
		run runICheck5(v_readOnlyErrLock,child_runICheck53);
		child_runICheck53?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getReadOnlyErr43(Mutexdef v_readOnlyErrLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	v_readOnlyErrLock.RLock!false;
	goto stop_process;
	stop_process: skip;
		v_readOnlyErrLock.RUnlock!false;
	child!0
}
proctype runICheck5(Mutexdef v_readOnlyErrLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Delete342(Mutexdef c_catalogView_readOnlyErrLock;Mutexdef c_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Delete804 = [1] of {int};
	chan child_Get573 = [1] of {int};
	c_lock.Lock!false;
	run Get57(c_catalogView_readOnlyErrLock,child_Get573);
	child_Get573?0;
	run Delete80(c_catalogView_readOnlyErrLock,child_Delete804);
	child_Delete804?0;
	goto stop_process;
	stop_process: skip;
		c_lock.Unlock!false;
	child!0
}
proctype Delete80(Mutexdef v_readOnlyErrLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_runICheck55 = [1] of {int};
	chan child_getReadOnlyErr434 = [1] of {int};
	run getReadOnlyErr43(v_readOnlyErrLock,child_getReadOnlyErr434);
	child_getReadOnlyErr434?0;
	

	if
	:: true -> 
		run runICheck5(v_readOnlyErrLock,child_runICheck55);
		child_runICheck55?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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

