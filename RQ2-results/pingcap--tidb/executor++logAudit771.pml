
// https://github.com/pingcap/tidb/blob/master/executor/adapter.go#L771
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
	chan child_logAudit7710 = [1] of {int};
	run logAudit771(child_logAudit7710)
stop_process:skip
}

proctype logAudit771(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef sessVars_SequenceState_mu;
	Mutexdef sessVars_StmtCtx_digestMemo_m;
	Mutexdef sessVars_StmtCtx_RuntimeStatsColl_mu;
	Mutexdef sessVars_StmtCtx_DiskTracker_parMu;
	Mutexdef sessVars_StmtCtx_DiskTracker_actionMu;
	Mutexdef sessVars_StmtCtx_DiskTracker_mu;
	Mutexdef sessVars_StmtCtx_MemTracker_parMu;
	Mutexdef sessVars_StmtCtx_MemTracker_actionMu;
	Mutexdef sessVars_StmtCtx_MemTracker_mu;
	Mutexdef sessVars_StmtCtx_mu_LockKeysDetail_Mu;
	Mutexdef sessVars_StmtCtx_mu_CommitDetail_Mu;
	Mutexdef sessVars_StmtCtx_mu_execDetails_LockKeysDetail_Mu;
	Mutexdef sessVars_StmtCtx_mu_execDetails_CommitDetail_Mu;
	Mutexdef sessVars_BinlogClient_Security_mutex;
	Mutexdef sessVars_BinlogClient_EtcdRegistry_client_client_mu;
	Mutexdef sessVars_BinlogClient_EtcdRegistry_client_client_resolverGroup_mu;
	Mutexdef sessVars_BinlogClient_EtcdRegistry_client_client_cfg_TLS_mutex;
	Mutexdef sessVars_BinlogClient_EtcdRegistry_client_client_conn_firstResolveEvent_o_m;
	Mutexdef sessVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_mu;
	Mutexdef sessVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m;
	Mutexdef sessVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu;
	Mutexdef sessVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu;
	Mutexdef sessVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu;
	Mutexdef sessVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m;
	Mutexdef sessVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu;
	Mutexdef sessVars_BinlogClient_EtcdRegistry_client_client_conn_mu;
	Mutexdef sessVars_BinlogClient_EtcdRegistry_client_client_conn_blockingpicker_mu;
	Mutexdef sessVars_BinlogClient_EtcdRegistry_client_client_conn_csMgr_mu;
	Wgdef sessVars_BinlogClient_wg;
	Mutexdef sessVars_TxnCtx_tdmLock;
	Mutexdef sessVars_UsersLock;
	run mutexMonitor(sessVars_UsersLock);
	run mutexMonitor(sessVars_TxnCtx_tdmLock);
	run wgMonitor(sessVars_BinlogClient_wg);
	run mutexMonitor(sessVars_BinlogClient_EtcdRegistry_client_client_conn_csMgr_mu);
	run mutexMonitor(sessVars_BinlogClient_EtcdRegistry_client_client_conn_blockingpicker_mu);
	run mutexMonitor(sessVars_BinlogClient_EtcdRegistry_client_client_conn_mu);
	run mutexMonitor(sessVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu);
	run mutexMonitor(sessVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m);
	run mutexMonitor(sessVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu);
	run mutexMonitor(sessVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu);
	run mutexMonitor(sessVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(sessVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m);
	run mutexMonitor(sessVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_mu);
	run mutexMonitor(sessVars_BinlogClient_EtcdRegistry_client_client_conn_firstResolveEvent_o_m);
	run mutexMonitor(sessVars_BinlogClient_EtcdRegistry_client_client_cfg_TLS_mutex);
	run mutexMonitor(sessVars_BinlogClient_EtcdRegistry_client_client_resolverGroup_mu);
	run mutexMonitor(sessVars_BinlogClient_EtcdRegistry_client_client_mu);
	run mutexMonitor(sessVars_BinlogClient_Security_mutex);
	run mutexMonitor(sessVars_StmtCtx_mu_execDetails_CommitDetail_Mu);
	run mutexMonitor(sessVars_StmtCtx_mu_execDetails_LockKeysDetail_Mu);
	run mutexMonitor(sessVars_StmtCtx_mu_CommitDetail_Mu);
	run mutexMonitor(sessVars_StmtCtx_mu_LockKeysDetail_Mu);
	run mutexMonitor(sessVars_StmtCtx_MemTracker_mu);
	run mutexMonitor(sessVars_StmtCtx_MemTracker_actionMu);
	run mutexMonitor(sessVars_StmtCtx_MemTracker_parMu);
	run mutexMonitor(sessVars_StmtCtx_DiskTracker_mu);
	run mutexMonitor(sessVars_StmtCtx_DiskTracker_actionMu);
	run mutexMonitor(sessVars_StmtCtx_DiskTracker_parMu);
	run mutexMonitor(sessVars_StmtCtx_RuntimeStatsColl_mu);
	run mutexMonitor(sessVars_StmtCtx_digestMemo_m);
	run mutexMonitor(sessVars_SequenceState_mu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

