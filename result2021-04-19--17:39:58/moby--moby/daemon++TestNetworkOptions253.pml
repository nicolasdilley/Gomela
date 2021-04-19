
// https://github.com/moby/moby/blob/master/daemon/daemon_unix_test.go#L253
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNetworkOptions2530 = [1] of {int};
	run TestNetworkOptions253(child_TestNetworkOptions2530)
stop_process:skip
}

proctype TestNetworkOptions253(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_networkOptions14371 = [1] of {int};
	chan child_networkOptions14370 = [1] of {int};
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
	run networkOptions1437(daemon_linkIndex_mu,daemon_containerdCli_connMu,daemon_containerdCli_conn_csMgr_mu,daemon_containerdCli_conn_blockingpicker_mu,daemon_containerdCli_conn_mu,daemon_containerdCli_conn_resolverWrapper_resolverMu,daemon_containerdCli_conn_resolverWrapper_done_o_m,daemon_containerdCli_conn_resolverWrapper_pollingMu,daemon_containerdCli_conn_balancerWrapper_balancerMu,daemon_containerdCli_conn_balancerWrapper_scBuffer_mu,daemon_containerdCli_conn_balancerWrapper_done_o_m,daemon_containerdCli_conn_balancerWrapper_mu,daemon_containerdCli_conn_firstResolveEvent_o_m,daemon_attachableNetworkLock_mu,daemon_mdDB_freelistLoad_m,daemon_mdDB_batchMu,daemon_mdDB_batch_start_m,daemon_mdDB_rwlock,daemon_mdDB_metalock,daemon_mdDB_mmaplock,daemon_mdDB_statlock,child_networkOptions14370);
	child_networkOptions14370?0;
	run networkOptions1437(daemon_linkIndex_mu,daemon_containerdCli_connMu,daemon_containerdCli_conn_csMgr_mu,daemon_containerdCli_conn_blockingpicker_mu,daemon_containerdCli_conn_mu,daemon_containerdCli_conn_resolverWrapper_resolverMu,daemon_containerdCli_conn_resolverWrapper_done_o_m,daemon_containerdCli_conn_resolverWrapper_pollingMu,daemon_containerdCli_conn_balancerWrapper_balancerMu,daemon_containerdCli_conn_balancerWrapper_scBuffer_mu,daemon_containerdCli_conn_balancerWrapper_done_o_m,daemon_containerdCli_conn_balancerWrapper_mu,daemon_containerdCli_conn_firstResolveEvent_o_m,daemon_attachableNetworkLock_mu,daemon_mdDB_freelistLoad_m,daemon_mdDB_batchMu,daemon_mdDB_batch_start_m,daemon_mdDB_rwlock,daemon_mdDB_metalock,daemon_mdDB_mmaplock,daemon_mdDB_statlock,child_networkOptions14371);
	child_networkOptions14371?0;
	stop_process: skip;
	child!0
}
proctype networkOptions1437(Mutexdef daemon_linkIndex_mu;Mutexdef daemon_containerdCli_connMu;Mutexdef daemon_containerdCli_conn_csMgr_mu;Mutexdef daemon_containerdCli_conn_blockingpicker_mu;Mutexdef daemon_containerdCli_conn_mu;Mutexdef daemon_containerdCli_conn_resolverWrapper_resolverMu;Mutexdef daemon_containerdCli_conn_resolverWrapper_done_o_m;Mutexdef daemon_containerdCli_conn_resolverWrapper_pollingMu;Mutexdef daemon_containerdCli_conn_balancerWrapper_balancerMu;Mutexdef daemon_containerdCli_conn_balancerWrapper_scBuffer_mu;Mutexdef daemon_containerdCli_conn_balancerWrapper_done_o_m;Mutexdef daemon_containerdCli_conn_balancerWrapper_mu;Mutexdef daemon_containerdCli_conn_firstResolveEvent_o_m;Mutexdef daemon_attachableNetworkLock_mu;Mutexdef daemon_mdDB_freelistLoad_m;Mutexdef daemon_mdDB_batchMu;Mutexdef daemon_mdDB_batch_start_m;Mutexdef daemon_mdDB_rwlock;Mutexdef daemon_mdDB_metalock;Mutexdef daemon_mdDB_mmaplock;Mutexdef daemon_mdDB_statlock;chan child) {
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

