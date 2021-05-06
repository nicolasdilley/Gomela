
// https://github.com/pingcap/tidb/blob/master/executor/builder.go#L662
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
	chan child_buildShow6620 = [1] of {int};
	run buildShow662(child_buildShow6620)
stop_process:skip
}

proctype buildShow662(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef vars_SequenceState_mu;
	Mutexdef vars_StmtCtx_digestMemo_m;
	Mutexdef vars_StmtCtx_RuntimeStatsColl_mu;
	Mutexdef vars_StmtCtx_DiskTracker_parMu;
	Mutexdef vars_StmtCtx_DiskTracker_actionMu;
	Mutexdef vars_StmtCtx_DiskTracker_mu;
	Mutexdef vars_StmtCtx_MemTracker_parMu;
	Mutexdef vars_StmtCtx_MemTracker_actionMu;
	Mutexdef vars_StmtCtx_MemTracker_mu;
	Mutexdef vars_StmtCtx_mu_LockKeysDetail_Mu;
	Mutexdef vars_StmtCtx_mu_CommitDetail_Mu;
	Mutexdef vars_StmtCtx_mu_execDetails_LockKeysDetail_Mu;
	Mutexdef vars_StmtCtx_mu_execDetails_CommitDetail_Mu;
	Mutexdef vars_BinlogClient_Security_mutex;
	Mutexdef vars_BinlogClient_EtcdRegistry_client_client_mu;
	Mutexdef vars_BinlogClient_EtcdRegistry_client_client_resolverGroup_mu;
	Mutexdef vars_BinlogClient_EtcdRegistry_client_client_cfg_TLS_mutex;
	Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_firstResolveEvent_o_m;
	Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_mu;
	Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m;
	Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu;
	Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu;
	Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu;
	Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m;
	Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu;
	Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_mu;
	Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_blockingpicker_mu;
	Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_csMgr_mu;
	Wgdef vars_BinlogClient_wg;
	Mutexdef vars_TxnCtx_tdmLock;
	Mutexdef vars_UsersLock;
	

	if
	:: true -> 
		run mutexMonitor(vars_UsersLock);
		run mutexMonitor(vars_TxnCtx_tdmLock);
		run wgMonitor(vars_BinlogClient_wg);
		run mutexMonitor(vars_BinlogClient_EtcdRegistry_client_client_conn_csMgr_mu);
		run mutexMonitor(vars_BinlogClient_EtcdRegistry_client_client_conn_blockingpicker_mu);
		run mutexMonitor(vars_BinlogClient_EtcdRegistry_client_client_conn_mu);
		run mutexMonitor(vars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu);
		run mutexMonitor(vars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m);
		run mutexMonitor(vars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu);
		run mutexMonitor(vars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu);
		run mutexMonitor(vars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu);
		run mutexMonitor(vars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m);
		run mutexMonitor(vars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_mu);
		run mutexMonitor(vars_BinlogClient_EtcdRegistry_client_client_conn_firstResolveEvent_o_m);
		run mutexMonitor(vars_BinlogClient_EtcdRegistry_client_client_cfg_TLS_mutex);
		run mutexMonitor(vars_BinlogClient_EtcdRegistry_client_client_resolverGroup_mu);
		run mutexMonitor(vars_BinlogClient_EtcdRegistry_client_client_mu);
		run mutexMonitor(vars_BinlogClient_Security_mutex);
		run mutexMonitor(vars_StmtCtx_mu_execDetails_CommitDetail_Mu);
		run mutexMonitor(vars_StmtCtx_mu_execDetails_LockKeysDetail_Mu);
		run mutexMonitor(vars_StmtCtx_mu_CommitDetail_Mu);
		run mutexMonitor(vars_StmtCtx_mu_LockKeysDetail_Mu);
		run mutexMonitor(vars_StmtCtx_MemTracker_mu);
		run mutexMonitor(vars_StmtCtx_MemTracker_actionMu);
		run mutexMonitor(vars_StmtCtx_MemTracker_parMu);
		run mutexMonitor(vars_StmtCtx_DiskTracker_mu);
		run mutexMonitor(vars_StmtCtx_DiskTracker_actionMu);
		run mutexMonitor(vars_StmtCtx_DiskTracker_parMu);
		run mutexMonitor(vars_StmtCtx_RuntimeStatsColl_mu);
		run mutexMonitor(vars_StmtCtx_digestMemo_m);
		run mutexMonitor(vars_SequenceState_mu)
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

