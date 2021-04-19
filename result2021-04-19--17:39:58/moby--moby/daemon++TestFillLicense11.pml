
// https://github.com/moby/moby/blob/master/daemon/licensing_test.go#L11
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFillLicense110 = [1] of {int};
	run TestFillLicense11(child_TestFillLicense110)
stop_process:skip
}

proctype TestFillLicense11(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fillLicense80 = [1] of {int};
	Mutexdef d_mdDB_statlock;
	Mutexdef d_mdDB_mmaplock;
	Mutexdef d_mdDB_metalock;
	Mutexdef d_mdDB_rwlock;
	Mutexdef d_mdDB_batch_start_m;
	Mutexdef d_mdDB_batchMu;
	Mutexdef d_mdDB_freelistLoad_m;
	Mutexdef d_attachableNetworkLock_mu;
	Mutexdef d_containerdCli_conn_firstResolveEvent_o_m;
	Mutexdef d_containerdCli_conn_balancerWrapper_mu;
	Mutexdef d_containerdCli_conn_balancerWrapper_done_o_m;
	Mutexdef d_containerdCli_conn_balancerWrapper_scBuffer_mu;
	Mutexdef d_containerdCli_conn_balancerWrapper_balancerMu;
	Mutexdef d_containerdCli_conn_resolverWrapper_pollingMu;
	Mutexdef d_containerdCli_conn_resolverWrapper_done_o_m;
	Mutexdef d_containerdCli_conn_resolverWrapper_resolverMu;
	Mutexdef d_containerdCli_conn_mu;
	Mutexdef d_containerdCli_conn_blockingpicker_mu;
	Mutexdef d_containerdCli_conn_csMgr_mu;
	Mutexdef d_containerdCli_connMu;
	Mutexdef d_linkIndex_mu;
	run mutexMonitor(d_linkIndex_mu);
	run mutexMonitor(d_containerdCli_connMu);
	run mutexMonitor(d_containerdCli_conn_csMgr_mu);
	run mutexMonitor(d_containerdCli_conn_blockingpicker_mu);
	run mutexMonitor(d_containerdCli_conn_mu);
	run mutexMonitor(d_containerdCli_conn_resolverWrapper_resolverMu);
	run mutexMonitor(d_containerdCli_conn_resolverWrapper_done_o_m);
	run mutexMonitor(d_containerdCli_conn_resolverWrapper_pollingMu);
	run mutexMonitor(d_containerdCli_conn_balancerWrapper_balancerMu);
	run mutexMonitor(d_containerdCli_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(d_containerdCli_conn_balancerWrapper_done_o_m);
	run mutexMonitor(d_containerdCli_conn_balancerWrapper_mu);
	run mutexMonitor(d_containerdCli_conn_firstResolveEvent_o_m);
	run mutexMonitor(d_attachableNetworkLock_mu);
	run mutexMonitor(d_mdDB_freelistLoad_m);
	run mutexMonitor(d_mdDB_batchMu);
	run mutexMonitor(d_mdDB_batch_start_m);
	run mutexMonitor(d_mdDB_rwlock);
	run mutexMonitor(d_mdDB_metalock);
	run mutexMonitor(d_mdDB_mmaplock);
	run mutexMonitor(d_mdDB_statlock);
	run fillLicense8(d_linkIndex_mu,d_containerdCli_connMu,d_containerdCli_conn_csMgr_mu,d_containerdCli_conn_blockingpicker_mu,d_containerdCli_conn_mu,d_containerdCli_conn_resolverWrapper_resolverMu,d_containerdCli_conn_resolverWrapper_done_o_m,d_containerdCli_conn_resolverWrapper_pollingMu,d_containerdCli_conn_balancerWrapper_balancerMu,d_containerdCli_conn_balancerWrapper_scBuffer_mu,d_containerdCli_conn_balancerWrapper_done_o_m,d_containerdCli_conn_balancerWrapper_mu,d_containerdCli_conn_firstResolveEvent_o_m,d_attachableNetworkLock_mu,d_mdDB_freelistLoad_m,d_mdDB_batchMu,d_mdDB_batch_start_m,d_mdDB_rwlock,d_mdDB_metalock,d_mdDB_mmaplock,d_mdDB_statlock,child_fillLicense80);
	child_fillLicense80?0;
	stop_process: skip;
	child!0
}
proctype fillLicense8(Mutexdef daemon_linkIndex_mu;Mutexdef daemon_containerdCli_connMu;Mutexdef daemon_containerdCli_conn_csMgr_mu;Mutexdef daemon_containerdCli_conn_blockingpicker_mu;Mutexdef daemon_containerdCli_conn_mu;Mutexdef daemon_containerdCli_conn_resolverWrapper_resolverMu;Mutexdef daemon_containerdCli_conn_resolverWrapper_done_o_m;Mutexdef daemon_containerdCli_conn_resolverWrapper_pollingMu;Mutexdef daemon_containerdCli_conn_balancerWrapper_balancerMu;Mutexdef daemon_containerdCli_conn_balancerWrapper_scBuffer_mu;Mutexdef daemon_containerdCli_conn_balancerWrapper_done_o_m;Mutexdef daemon_containerdCli_conn_balancerWrapper_mu;Mutexdef daemon_containerdCli_conn_firstResolveEvent_o_m;Mutexdef daemon_attachableNetworkLock_mu;Mutexdef daemon_mdDB_freelistLoad_m;Mutexdef daemon_mdDB_batchMu;Mutexdef daemon_mdDB_batch_start_m;Mutexdef daemon_mdDB_rwlock;Mutexdef daemon_mdDB_metalock;Mutexdef daemon_mdDB_mmaplock;Mutexdef daemon_mdDB_statlock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

