// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/pingcap/tidb/blob//executor/set.go#L303
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
	chan child_loadSnapshotInfoSchemaIfNeeded3030 = [1] of {int};
	run loadSnapshotInfoSchemaIfNeeded303(child_loadSnapshotInfoSchemaIfNeeded3030);
	run receiver(child_loadSnapshotInfoSchemaIfNeeded3030)
stop_process:skip
}

proctype loadSnapshotInfoSchemaIfNeeded303(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef dom_serverIDSession_client_mu;
	Mutexdef dom_serverIDSession_client_resolverGroup_mu;
	Mutexdef dom_serverIDSession_client_conn_mu;
	Wgdef dom_wg;
	Mutexdef dom_slowQuery_mu;
	Mutexdef dom_gvc_SingleFight_mu;
	Mutexdef dom_etcdClient_mu;
	Mutexdef dom_etcdClient_resolverGroup_mu;
	Mutexdef dom_etcdClient_cfg_TLS_mutex;
	Mutexdef dom_etcdClient_conn_balancerWrapper_mu;
	Mutexdef dom_etcdClient_conn_balancerWrapper_balancerMu;
	Mutexdef dom_etcdClient_conn_resolverWrapper_pollingMu;
	Mutexdef dom_etcdClient_conn_resolverWrapper_resolverMu;
	Mutexdef dom_etcdClient_conn_mu;
	Mutexdef dom_etcdClient_conn_blockingpicker_mu;
	Mutexdef dom_etcdClient_conn_csMgr_mu;
	Mutexdef dom_sysSessionPool_mu;
	Mutexdef dom_m;
	Mutexdef dom_info_topologySession_client_mu;
	Mutexdef dom_info_session_client_mu;
	Mutexdef dom_info_etcdCli_mu;
	Mutexdef dom_info_etcdCli_resolverGroup_mu;
	Mutexdef dom_info_etcdCli_conn_mu;
	Mutexdef dom_bindHandle_bindInfo;
	Mutexdef dom_bindHandle_sctx;
	Mutexdef vars_SequenceState_mu;
	Mutexdef vars_StmtCtx_digestMemo_m;
	Mutexdef vars_StmtCtx_RuntimeStatsColl_mu;
	Mutexdef vars_StmtCtx_DiskTracker_parMu;
	Mutexdef vars_StmtCtx_DiskTracker_actionMu;
	Mutexdef vars_StmtCtx_DiskTracker_mu;
	Mutexdef vars_StmtCtx_MemTracker_parMu;
	Mutexdef vars_StmtCtx_MemTracker_actionMu;
	Mutexdef vars_StmtCtx_MemTracker_mu;
	Mutexdef vars_StmtCtx_mu;
	Mutexdef vars_BinlogClient_Security_mutex;
	Wgdef vars_BinlogClient_wg;
	Mutexdef vars_TxnCtx_tdmLock;
	Mutexdef vars_UsersLock;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(vars_UsersLock);
	run mutexMonitor(vars_TxnCtx_tdmLock);
	run wgMonitor(vars_BinlogClient_wg);
	run mutexMonitor(vars_BinlogClient_Security_mutex);
	run mutexMonitor(vars_StmtCtx_mu);
	run mutexMonitor(vars_StmtCtx_MemTracker_mu);
	run mutexMonitor(vars_StmtCtx_MemTracker_actionMu);
	run mutexMonitor(vars_StmtCtx_MemTracker_parMu);
	run mutexMonitor(vars_StmtCtx_DiskTracker_mu);
	run mutexMonitor(vars_StmtCtx_DiskTracker_actionMu);
	run mutexMonitor(vars_StmtCtx_DiskTracker_parMu);
	run mutexMonitor(vars_StmtCtx_RuntimeStatsColl_mu);
	run mutexMonitor(vars_StmtCtx_digestMemo_m);
	run mutexMonitor(vars_SequenceState_mu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(dom_bindHandle_sctx);
	run mutexMonitor(dom_bindHandle_bindInfo);
	run mutexMonitor(dom_info_etcdCli_conn_mu);
	run mutexMonitor(dom_info_etcdCli_resolverGroup_mu);
	run mutexMonitor(dom_info_etcdCli_mu);
	run mutexMonitor(dom_info_session_client_mu);
	run mutexMonitor(dom_info_topologySession_client_mu);
	run mutexMonitor(dom_m);
	run mutexMonitor(dom_sysSessionPool_mu);
	run mutexMonitor(dom_etcdClient_conn_csMgr_mu);
	run mutexMonitor(dom_etcdClient_conn_blockingpicker_mu);
	run mutexMonitor(dom_etcdClient_conn_mu);
	run mutexMonitor(dom_etcdClient_conn_resolverWrapper_resolverMu);
	run mutexMonitor(dom_etcdClient_conn_resolverWrapper_pollingMu);
	run mutexMonitor(dom_etcdClient_conn_balancerWrapper_balancerMu);
	run mutexMonitor(dom_etcdClient_conn_balancerWrapper_mu);
	run mutexMonitor(dom_etcdClient_cfg_TLS_mutex);
	run mutexMonitor(dom_etcdClient_resolverGroup_mu);
	run mutexMonitor(dom_etcdClient_mu);
	run mutexMonitor(dom_gvc_SingleFight_mu);
	run mutexMonitor(dom_slowQuery_mu);
	run wgMonitor(dom_wg);
	run mutexMonitor(dom_serverIDSession_client_conn_mu);
	run mutexMonitor(dom_serverIDSession_client_resolverGroup_mu);
	run mutexMonitor(dom_serverIDSession_client_mu);
	

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

