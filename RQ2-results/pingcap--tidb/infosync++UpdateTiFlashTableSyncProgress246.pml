
// https://github.com/pingcap/tidb/blob/master/domain/infosync/info.go#L246
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_UpdateTiFlashTableSyncProgress2460 = [1] of {int};
	run UpdateTiFlashTableSyncProgress246(child_UpdateTiFlashTableSyncProgress2460)
stop_process:skip
}

proctype UpdateTiFlashTableSyncProgress246(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef is_topologySession_client_mu;
	Mutexdef is_topologySession_client_resolverGroup_mu;
	Mutexdef is_topologySession_client_cfg_TLS_mutex;
	Mutexdef is_topologySession_client_conn_firstResolveEvent_o_m;
	Mutexdef is_topologySession_client_conn_balancerWrapper_mu;
	Mutexdef is_topologySession_client_conn_balancerWrapper_done_o_m;
	Mutexdef is_topologySession_client_conn_balancerWrapper_scBuffer_mu;
	Mutexdef is_topologySession_client_conn_balancerWrapper_balancerMu;
	Mutexdef is_topologySession_client_conn_resolverWrapper_pollingMu;
	Mutexdef is_topologySession_client_conn_resolverWrapper_done_o_m;
	Mutexdef is_topologySession_client_conn_resolverWrapper_resolverMu;
	Mutexdef is_topologySession_client_conn_mu;
	Mutexdef is_topologySession_client_conn_blockingpicker_mu;
	Mutexdef is_topologySession_client_conn_csMgr_mu;
	Mutexdef is_session_client_mu;
	Mutexdef is_session_client_resolverGroup_mu;
	Mutexdef is_session_client_cfg_TLS_mutex;
	Mutexdef is_session_client_conn_firstResolveEvent_o_m;
	Mutexdef is_session_client_conn_balancerWrapper_mu;
	Mutexdef is_session_client_conn_balancerWrapper_done_o_m;
	Mutexdef is_session_client_conn_balancerWrapper_scBuffer_mu;
	Mutexdef is_session_client_conn_balancerWrapper_balancerMu;
	Mutexdef is_session_client_conn_resolverWrapper_pollingMu;
	Mutexdef is_session_client_conn_resolverWrapper_done_o_m;
	Mutexdef is_session_client_conn_resolverWrapper_resolverMu;
	Mutexdef is_session_client_conn_mu;
	Mutexdef is_session_client_conn_blockingpicker_mu;
	Mutexdef is_session_client_conn_csMgr_mu;
	Mutexdef is_etcdCli_mu;
	Mutexdef is_etcdCli_resolverGroup_mu;
	Mutexdef is_etcdCli_cfg_TLS_mutex;
	Mutexdef is_etcdCli_conn_firstResolveEvent_o_m;
	Mutexdef is_etcdCli_conn_balancerWrapper_mu;
	Mutexdef is_etcdCli_conn_balancerWrapper_done_o_m;
	Mutexdef is_etcdCli_conn_balancerWrapper_scBuffer_mu;
	Mutexdef is_etcdCli_conn_balancerWrapper_balancerMu;
	Mutexdef is_etcdCli_conn_resolverWrapper_pollingMu;
	Mutexdef is_etcdCli_conn_resolverWrapper_done_o_m;
	Mutexdef is_etcdCli_conn_resolverWrapper_resolverMu;
	Mutexdef is_etcdCli_conn_mu;
	Mutexdef is_etcdCli_conn_blockingpicker_mu;
	Mutexdef is_etcdCli_conn_csMgr_mu;
	run mutexMonitor(is_etcdCli_conn_csMgr_mu);
	run mutexMonitor(is_etcdCli_conn_blockingpicker_mu);
	run mutexMonitor(is_etcdCli_conn_mu);
	run mutexMonitor(is_etcdCli_conn_resolverWrapper_resolverMu);
	run mutexMonitor(is_etcdCli_conn_resolverWrapper_done_o_m);
	run mutexMonitor(is_etcdCli_conn_resolverWrapper_pollingMu);
	run mutexMonitor(is_etcdCli_conn_balancerWrapper_balancerMu);
	run mutexMonitor(is_etcdCli_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(is_etcdCli_conn_balancerWrapper_done_o_m);
	run mutexMonitor(is_etcdCli_conn_balancerWrapper_mu);
	run mutexMonitor(is_etcdCli_conn_firstResolveEvent_o_m);
	run mutexMonitor(is_etcdCli_cfg_TLS_mutex);
	run mutexMonitor(is_etcdCli_resolverGroup_mu);
	run mutexMonitor(is_etcdCli_mu);
	run mutexMonitor(is_session_client_conn_csMgr_mu);
	run mutexMonitor(is_session_client_conn_blockingpicker_mu);
	run mutexMonitor(is_session_client_conn_mu);
	run mutexMonitor(is_session_client_conn_resolverWrapper_resolverMu);
	run mutexMonitor(is_session_client_conn_resolverWrapper_done_o_m);
	run mutexMonitor(is_session_client_conn_resolverWrapper_pollingMu);
	run mutexMonitor(is_session_client_conn_balancerWrapper_balancerMu);
	run mutexMonitor(is_session_client_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(is_session_client_conn_balancerWrapper_done_o_m);
	run mutexMonitor(is_session_client_conn_balancerWrapper_mu);
	run mutexMonitor(is_session_client_conn_firstResolveEvent_o_m);
	run mutexMonitor(is_session_client_cfg_TLS_mutex);
	run mutexMonitor(is_session_client_resolverGroup_mu);
	run mutexMonitor(is_session_client_mu);
	run mutexMonitor(is_topologySession_client_conn_csMgr_mu);
	run mutexMonitor(is_topologySession_client_conn_blockingpicker_mu);
	run mutexMonitor(is_topologySession_client_conn_mu);
	run mutexMonitor(is_topologySession_client_conn_resolverWrapper_resolverMu);
	run mutexMonitor(is_topologySession_client_conn_resolverWrapper_done_o_m);
	run mutexMonitor(is_topologySession_client_conn_resolverWrapper_pollingMu);
	run mutexMonitor(is_topologySession_client_conn_balancerWrapper_balancerMu);
	run mutexMonitor(is_topologySession_client_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(is_topologySession_client_conn_balancerWrapper_done_o_m);
	run mutexMonitor(is_topologySession_client_conn_balancerWrapper_mu);
	run mutexMonitor(is_topologySession_client_conn_firstResolveEvent_o_m);
	run mutexMonitor(is_topologySession_client_cfg_TLS_mutex);
	run mutexMonitor(is_topologySession_client_resolverGroup_mu);
	run mutexMonitor(is_topologySession_client_mu);
	

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

