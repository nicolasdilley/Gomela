
// https://github.com/moby/moby/blob/master/daemon/daemon_test.go#L28
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGetContainer280 = [1] of {int};
	run TestGetContainer28(child_TestGetContainer280)
stop_process:skip
}

proctype TestGetContainer28(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetContainer3811 = [1] of {int};
	chan child_GetContainer3810 = [1] of {int};
	chan child_GetContainer389 = [1] of {int};
	chan child_GetContainer388 = [1] of {int};
	chan child_GetContainer387 = [1] of {int};
	chan child_GetContainer386 = [1] of {int};
	chan child_GetContainer385 = [1] of {int};
	chan child_reserveName584 = [1] of {int};
	chan child_reserveName583 = [1] of {int};
	chan child_reserveName582 = [1] of {int};
	chan child_reserveName581 = [1] of {int};
	chan child_reserveName580 = [1] of {int};
	Mutexdef daemon_mdDB_statlock;
	Mutexdef daemon_mdDB_mmaplock;
	Mutexdef daemon_mdDB_metalock;
	Mutexdef daemon_mdDB_rwlock;
	Mutexdef daemon_mdDB_batch_start_m;
	Mutexdef daemon_mdDB_batchMu;
	Mutexdef daemon_mdDB_freelistLoad_m;
	Mutexdef daemon_attachableNetworkLock_mu;
	Mutexdef daemon_containerdCli_conn_firstResolveEvent_o_m;
	Mutexdef daemon_containerdCli_conn_balancerWrapper_mu;
	Mutexdef daemon_containerdCli_conn_balancerWrapper_done_o_m;
	Mutexdef daemon_containerdCli_conn_balancerWrapper_scBuffer_mu;
	Mutexdef daemon_containerdCli_conn_balancerWrapper_balancerMu;
	Mutexdef daemon_containerdCli_conn_resolverWrapper_pollingMu;
	Mutexdef daemon_containerdCli_conn_resolverWrapper_done_o_m;
	Mutexdef daemon_containerdCli_conn_resolverWrapper_resolverMu;
	Mutexdef daemon_containerdCli_conn_mu;
	Mutexdef daemon_containerdCli_conn_blockingpicker_mu;
	Mutexdef daemon_containerdCli_conn_csMgr_mu;
	Mutexdef daemon_containerdCli_connMu;
	Mutexdef daemon_linkIndex_mu;
	run mutexMonitor(daemon_linkIndex_mu);
	run mutexMonitor(daemon_containerdCli_connMu);
	run mutexMonitor(daemon_containerdCli_conn_csMgr_mu);
	run mutexMonitor(daemon_containerdCli_conn_blockingpicker_mu);
	run mutexMonitor(daemon_containerdCli_conn_mu);
	run mutexMonitor(daemon_containerdCli_conn_resolverWrapper_resolverMu);
	run mutexMonitor(daemon_containerdCli_conn_resolverWrapper_done_o_m);
	run mutexMonitor(daemon_containerdCli_conn_resolverWrapper_pollingMu);
	run mutexMonitor(daemon_containerdCli_conn_balancerWrapper_balancerMu);
	run mutexMonitor(daemon_containerdCli_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(daemon_containerdCli_conn_balancerWrapper_done_o_m);
	run mutexMonitor(daemon_containerdCli_conn_balancerWrapper_mu);
	run mutexMonitor(daemon_containerdCli_conn_firstResolveEvent_o_m);
	run mutexMonitor(daemon_attachableNetworkLock_mu);
	run mutexMonitor(daemon_mdDB_freelistLoad_m);
	run mutexMonitor(daemon_mdDB_batchMu);
	run mutexMonitor(daemon_mdDB_batch_start_m);
	run mutexMonitor(daemon_mdDB_rwlock);
	run mutexMonitor(daemon_mdDB_metalock);
	run mutexMonitor(daemon_mdDB_mmaplock);
	run mutexMonitor(daemon_mdDB_statlock);
	run reserveName58(daemon_linkIndex_mu,daemon_containerdCli_connMu,daemon_containerdCli_conn_csMgr_mu,daemon_containerdCli_conn_blockingpicker_mu,daemon_containerdCli_conn_mu,daemon_containerdCli_conn_resolverWrapper_resolverMu,daemon_containerdCli_conn_resolverWrapper_done_o_m,daemon_containerdCli_conn_resolverWrapper_pollingMu,daemon_containerdCli_conn_balancerWrapper_balancerMu,daemon_containerdCli_conn_balancerWrapper_scBuffer_mu,daemon_containerdCli_conn_balancerWrapper_done_o_m,daemon_containerdCli_conn_balancerWrapper_mu,daemon_containerdCli_conn_firstResolveEvent_o_m,daemon_attachableNetworkLock_mu,daemon_mdDB_freelistLoad_m,daemon_mdDB_batchMu,daemon_mdDB_batch_start_m,daemon_mdDB_rwlock,daemon_mdDB_metalock,daemon_mdDB_mmaplock,daemon_mdDB_statlock,child_reserveName580);
	child_reserveName580?0;
	run reserveName58(daemon_linkIndex_mu,daemon_containerdCli_connMu,daemon_containerdCli_conn_csMgr_mu,daemon_containerdCli_conn_blockingpicker_mu,daemon_containerdCli_conn_mu,daemon_containerdCli_conn_resolverWrapper_resolverMu,daemon_containerdCli_conn_resolverWrapper_done_o_m,daemon_containerdCli_conn_resolverWrapper_pollingMu,daemon_containerdCli_conn_balancerWrapper_balancerMu,daemon_containerdCli_conn_balancerWrapper_scBuffer_mu,daemon_containerdCli_conn_balancerWrapper_done_o_m,daemon_containerdCli_conn_balancerWrapper_mu,daemon_containerdCli_conn_firstResolveEvent_o_m,daemon_attachableNetworkLock_mu,daemon_mdDB_freelistLoad_m,daemon_mdDB_batchMu,daemon_mdDB_batch_start_m,daemon_mdDB_rwlock,daemon_mdDB_metalock,daemon_mdDB_mmaplock,daemon_mdDB_statlock,child_reserveName581);
	child_reserveName581?0;
	run reserveName58(daemon_linkIndex_mu,daemon_containerdCli_connMu,daemon_containerdCli_conn_csMgr_mu,daemon_containerdCli_conn_blockingpicker_mu,daemon_containerdCli_conn_mu,daemon_containerdCli_conn_resolverWrapper_resolverMu,daemon_containerdCli_conn_resolverWrapper_done_o_m,daemon_containerdCli_conn_resolverWrapper_pollingMu,daemon_containerdCli_conn_balancerWrapper_balancerMu,daemon_containerdCli_conn_balancerWrapper_scBuffer_mu,daemon_containerdCli_conn_balancerWrapper_done_o_m,daemon_containerdCli_conn_balancerWrapper_mu,daemon_containerdCli_conn_firstResolveEvent_o_m,daemon_attachableNetworkLock_mu,daemon_mdDB_freelistLoad_m,daemon_mdDB_batchMu,daemon_mdDB_batch_start_m,daemon_mdDB_rwlock,daemon_mdDB_metalock,daemon_mdDB_mmaplock,daemon_mdDB_statlock,child_reserveName582);
	child_reserveName582?0;
	run reserveName58(daemon_linkIndex_mu,daemon_containerdCli_connMu,daemon_containerdCli_conn_csMgr_mu,daemon_containerdCli_conn_blockingpicker_mu,daemon_containerdCli_conn_mu,daemon_containerdCli_conn_resolverWrapper_resolverMu,daemon_containerdCli_conn_resolverWrapper_done_o_m,daemon_containerdCli_conn_resolverWrapper_pollingMu,daemon_containerdCli_conn_balancerWrapper_balancerMu,daemon_containerdCli_conn_balancerWrapper_scBuffer_mu,daemon_containerdCli_conn_balancerWrapper_done_o_m,daemon_containerdCli_conn_balancerWrapper_mu,daemon_containerdCli_conn_firstResolveEvent_o_m,daemon_attachableNetworkLock_mu,daemon_mdDB_freelistLoad_m,daemon_mdDB_batchMu,daemon_mdDB_batch_start_m,daemon_mdDB_rwlock,daemon_mdDB_metalock,daemon_mdDB_mmaplock,daemon_mdDB_statlock,child_reserveName583);
	child_reserveName583?0;
	run reserveName58(daemon_linkIndex_mu,daemon_containerdCli_connMu,daemon_containerdCli_conn_csMgr_mu,daemon_containerdCli_conn_blockingpicker_mu,daemon_containerdCli_conn_mu,daemon_containerdCli_conn_resolverWrapper_resolverMu,daemon_containerdCli_conn_resolverWrapper_done_o_m,daemon_containerdCli_conn_resolverWrapper_pollingMu,daemon_containerdCli_conn_balancerWrapper_balancerMu,daemon_containerdCli_conn_balancerWrapper_scBuffer_mu,daemon_containerdCli_conn_balancerWrapper_done_o_m,daemon_containerdCli_conn_balancerWrapper_mu,daemon_containerdCli_conn_firstResolveEvent_o_m,daemon_attachableNetworkLock_mu,daemon_mdDB_freelistLoad_m,daemon_mdDB_batchMu,daemon_mdDB_batch_start_m,daemon_mdDB_rwlock,daemon_mdDB_metalock,daemon_mdDB_mmaplock,daemon_mdDB_statlock,child_reserveName584);
	child_reserveName584?0;
	run GetContainer38(daemon_linkIndex_mu,daemon_containerdCli_connMu,daemon_containerdCli_conn_csMgr_mu,daemon_containerdCli_conn_blockingpicker_mu,daemon_containerdCli_conn_mu,daemon_containerdCli_conn_resolverWrapper_resolverMu,daemon_containerdCli_conn_resolverWrapper_done_o_m,daemon_containerdCli_conn_resolverWrapper_pollingMu,daemon_containerdCli_conn_balancerWrapper_balancerMu,daemon_containerdCli_conn_balancerWrapper_scBuffer_mu,daemon_containerdCli_conn_balancerWrapper_done_o_m,daemon_containerdCli_conn_balancerWrapper_mu,daemon_containerdCli_conn_firstResolveEvent_o_m,daemon_attachableNetworkLock_mu,daemon_mdDB_freelistLoad_m,daemon_mdDB_batchMu,daemon_mdDB_batch_start_m,daemon_mdDB_rwlock,daemon_mdDB_metalock,daemon_mdDB_mmaplock,daemon_mdDB_statlock,child_GetContainer385);
	child_GetContainer385?0;
	run GetContainer38(daemon_linkIndex_mu,daemon_containerdCli_connMu,daemon_containerdCli_conn_csMgr_mu,daemon_containerdCli_conn_blockingpicker_mu,daemon_containerdCli_conn_mu,daemon_containerdCli_conn_resolverWrapper_resolverMu,daemon_containerdCli_conn_resolverWrapper_done_o_m,daemon_containerdCli_conn_resolverWrapper_pollingMu,daemon_containerdCli_conn_balancerWrapper_balancerMu,daemon_containerdCli_conn_balancerWrapper_scBuffer_mu,daemon_containerdCli_conn_balancerWrapper_done_o_m,daemon_containerdCli_conn_balancerWrapper_mu,daemon_containerdCli_conn_firstResolveEvent_o_m,daemon_attachableNetworkLock_mu,daemon_mdDB_freelistLoad_m,daemon_mdDB_batchMu,daemon_mdDB_batch_start_m,daemon_mdDB_rwlock,daemon_mdDB_metalock,daemon_mdDB_mmaplock,daemon_mdDB_statlock,child_GetContainer386);
	child_GetContainer386?0;
	run GetContainer38(daemon_linkIndex_mu,daemon_containerdCli_connMu,daemon_containerdCli_conn_csMgr_mu,daemon_containerdCli_conn_blockingpicker_mu,daemon_containerdCli_conn_mu,daemon_containerdCli_conn_resolverWrapper_resolverMu,daemon_containerdCli_conn_resolverWrapper_done_o_m,daemon_containerdCli_conn_resolverWrapper_pollingMu,daemon_containerdCli_conn_balancerWrapper_balancerMu,daemon_containerdCli_conn_balancerWrapper_scBuffer_mu,daemon_containerdCli_conn_balancerWrapper_done_o_m,daemon_containerdCli_conn_balancerWrapper_mu,daemon_containerdCli_conn_firstResolveEvent_o_m,daemon_attachableNetworkLock_mu,daemon_mdDB_freelistLoad_m,daemon_mdDB_batchMu,daemon_mdDB_batch_start_m,daemon_mdDB_rwlock,daemon_mdDB_metalock,daemon_mdDB_mmaplock,daemon_mdDB_statlock,child_GetContainer387);
	child_GetContainer387?0;
	run GetContainer38(daemon_linkIndex_mu,daemon_containerdCli_connMu,daemon_containerdCli_conn_csMgr_mu,daemon_containerdCli_conn_blockingpicker_mu,daemon_containerdCli_conn_mu,daemon_containerdCli_conn_resolverWrapper_resolverMu,daemon_containerdCli_conn_resolverWrapper_done_o_m,daemon_containerdCli_conn_resolverWrapper_pollingMu,daemon_containerdCli_conn_balancerWrapper_balancerMu,daemon_containerdCli_conn_balancerWrapper_scBuffer_mu,daemon_containerdCli_conn_balancerWrapper_done_o_m,daemon_containerdCli_conn_balancerWrapper_mu,daemon_containerdCli_conn_firstResolveEvent_o_m,daemon_attachableNetworkLock_mu,daemon_mdDB_freelistLoad_m,daemon_mdDB_batchMu,daemon_mdDB_batch_start_m,daemon_mdDB_rwlock,daemon_mdDB_metalock,daemon_mdDB_mmaplock,daemon_mdDB_statlock,child_GetContainer388);
	child_GetContainer388?0;
	run GetContainer38(daemon_linkIndex_mu,daemon_containerdCli_connMu,daemon_containerdCli_conn_csMgr_mu,daemon_containerdCli_conn_blockingpicker_mu,daemon_containerdCli_conn_mu,daemon_containerdCli_conn_resolverWrapper_resolverMu,daemon_containerdCli_conn_resolverWrapper_done_o_m,daemon_containerdCli_conn_resolverWrapper_pollingMu,daemon_containerdCli_conn_balancerWrapper_balancerMu,daemon_containerdCli_conn_balancerWrapper_scBuffer_mu,daemon_containerdCli_conn_balancerWrapper_done_o_m,daemon_containerdCli_conn_balancerWrapper_mu,daemon_containerdCli_conn_firstResolveEvent_o_m,daemon_attachableNetworkLock_mu,daemon_mdDB_freelistLoad_m,daemon_mdDB_batchMu,daemon_mdDB_batch_start_m,daemon_mdDB_rwlock,daemon_mdDB_metalock,daemon_mdDB_mmaplock,daemon_mdDB_statlock,child_GetContainer389);
	child_GetContainer389?0;
	run GetContainer38(daemon_linkIndex_mu,daemon_containerdCli_connMu,daemon_containerdCli_conn_csMgr_mu,daemon_containerdCli_conn_blockingpicker_mu,daemon_containerdCli_conn_mu,daemon_containerdCli_conn_resolverWrapper_resolverMu,daemon_containerdCli_conn_resolverWrapper_done_o_m,daemon_containerdCli_conn_resolverWrapper_pollingMu,daemon_containerdCli_conn_balancerWrapper_balancerMu,daemon_containerdCli_conn_balancerWrapper_scBuffer_mu,daemon_containerdCli_conn_balancerWrapper_done_o_m,daemon_containerdCli_conn_balancerWrapper_mu,daemon_containerdCli_conn_firstResolveEvent_o_m,daemon_attachableNetworkLock_mu,daemon_mdDB_freelistLoad_m,daemon_mdDB_batchMu,daemon_mdDB_batch_start_m,daemon_mdDB_rwlock,daemon_mdDB_metalock,daemon_mdDB_mmaplock,daemon_mdDB_statlock,child_GetContainer3810);
	child_GetContainer3810?0;
	run GetContainer38(daemon_linkIndex_mu,daemon_containerdCli_connMu,daemon_containerdCli_conn_csMgr_mu,daemon_containerdCli_conn_blockingpicker_mu,daemon_containerdCli_conn_mu,daemon_containerdCli_conn_resolverWrapper_resolverMu,daemon_containerdCli_conn_resolverWrapper_done_o_m,daemon_containerdCli_conn_resolverWrapper_pollingMu,daemon_containerdCli_conn_balancerWrapper_balancerMu,daemon_containerdCli_conn_balancerWrapper_scBuffer_mu,daemon_containerdCli_conn_balancerWrapper_done_o_m,daemon_containerdCli_conn_balancerWrapper_mu,daemon_containerdCli_conn_firstResolveEvent_o_m,daemon_attachableNetworkLock_mu,daemon_mdDB_freelistLoad_m,daemon_mdDB_batchMu,daemon_mdDB_batch_start_m,daemon_mdDB_rwlock,daemon_mdDB_metalock,daemon_mdDB_mmaplock,daemon_mdDB_statlock,child_GetContainer3811);
	child_GetContainer3811?0;
	stop_process: skip;
	child!0
}
proctype reserveName58(Mutexdef daemon_linkIndex_mu;Mutexdef daemon_containerdCli_connMu;Mutexdef daemon_containerdCli_conn_csMgr_mu;Mutexdef daemon_containerdCli_conn_blockingpicker_mu;Mutexdef daemon_containerdCli_conn_mu;Mutexdef daemon_containerdCli_conn_resolverWrapper_resolverMu;Mutexdef daemon_containerdCli_conn_resolverWrapper_done_o_m;Mutexdef daemon_containerdCli_conn_resolverWrapper_pollingMu;Mutexdef daemon_containerdCli_conn_balancerWrapper_balancerMu;Mutexdef daemon_containerdCli_conn_balancerWrapper_scBuffer_mu;Mutexdef daemon_containerdCli_conn_balancerWrapper_done_o_m;Mutexdef daemon_containerdCli_conn_balancerWrapper_mu;Mutexdef daemon_containerdCli_conn_firstResolveEvent_o_m;Mutexdef daemon_attachableNetworkLock_mu;Mutexdef daemon_mdDB_freelistLoad_m;Mutexdef daemon_mdDB_batchMu;Mutexdef daemon_mdDB_batch_start_m;Mutexdef daemon_mdDB_rwlock;Mutexdef daemon_mdDB_metalock;Mutexdef daemon_mdDB_mmaplock;Mutexdef daemon_mdDB_statlock;chan child) {
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
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetContainer38(Mutexdef daemon_linkIndex_mu;Mutexdef daemon_containerdCli_connMu;Mutexdef daemon_containerdCli_conn_csMgr_mu;Mutexdef daemon_containerdCli_conn_blockingpicker_mu;Mutexdef daemon_containerdCli_conn_mu;Mutexdef daemon_containerdCli_conn_resolverWrapper_resolverMu;Mutexdef daemon_containerdCli_conn_resolverWrapper_done_o_m;Mutexdef daemon_containerdCli_conn_resolverWrapper_pollingMu;Mutexdef daemon_containerdCli_conn_balancerWrapper_balancerMu;Mutexdef daemon_containerdCli_conn_balancerWrapper_scBuffer_mu;Mutexdef daemon_containerdCli_conn_balancerWrapper_done_o_m;Mutexdef daemon_containerdCli_conn_balancerWrapper_mu;Mutexdef daemon_containerdCli_conn_firstResolveEvent_o_m;Mutexdef daemon_attachableNetworkLock_mu;Mutexdef daemon_mdDB_freelistLoad_m;Mutexdef daemon_mdDB_batchMu;Mutexdef daemon_mdDB_batch_start_m;Mutexdef daemon_mdDB_rwlock;Mutexdef daemon_mdDB_metalock;Mutexdef daemon_mdDB_mmaplock;Mutexdef daemon_mdDB_statlock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetByName1675 = [1] of {int};
	

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
	run GetByName167(daemon_linkIndex_mu,daemon_containerdCli_connMu,daemon_containerdCli_conn_csMgr_mu,daemon_containerdCli_conn_blockingpicker_mu,daemon_containerdCli_conn_mu,daemon_containerdCli_conn_resolverWrapper_resolverMu,daemon_containerdCli_conn_resolverWrapper_done_o_m,daemon_containerdCli_conn_resolverWrapper_pollingMu,daemon_containerdCli_conn_balancerWrapper_balancerMu,daemon_containerdCli_conn_balancerWrapper_scBuffer_mu,daemon_containerdCli_conn_balancerWrapper_done_o_m,daemon_containerdCli_conn_balancerWrapper_mu,daemon_containerdCli_conn_firstResolveEvent_o_m,daemon_attachableNetworkLock_mu,daemon_mdDB_freelistLoad_m,daemon_mdDB_batchMu,daemon_mdDB_batch_start_m,daemon_mdDB_rwlock,daemon_mdDB_metalock,daemon_mdDB_mmaplock,daemon_mdDB_statlock,child_GetByName1675);
	child_GetByName1675?0;
	

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
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetByName167(Mutexdef daemon_linkIndex_mu;Mutexdef daemon_containerdCli_connMu;Mutexdef daemon_containerdCli_conn_csMgr_mu;Mutexdef daemon_containerdCli_conn_blockingpicker_mu;Mutexdef daemon_containerdCli_conn_mu;Mutexdef daemon_containerdCli_conn_resolverWrapper_resolverMu;Mutexdef daemon_containerdCli_conn_resolverWrapper_done_o_m;Mutexdef daemon_containerdCli_conn_resolverWrapper_pollingMu;Mutexdef daemon_containerdCli_conn_balancerWrapper_balancerMu;Mutexdef daemon_containerdCli_conn_balancerWrapper_scBuffer_mu;Mutexdef daemon_containerdCli_conn_balancerWrapper_done_o_m;Mutexdef daemon_containerdCli_conn_balancerWrapper_mu;Mutexdef daemon_containerdCli_conn_firstResolveEvent_o_m;Mutexdef daemon_attachableNetworkLock_mu;Mutexdef daemon_mdDB_freelistLoad_m;Mutexdef daemon_mdDB_batchMu;Mutexdef daemon_mdDB_batch_start_m;Mutexdef daemon_mdDB_rwlock;Mutexdef daemon_mdDB_metalock;Mutexdef daemon_mdDB_mmaplock;Mutexdef daemon_mdDB_statlock;chan child) {
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

