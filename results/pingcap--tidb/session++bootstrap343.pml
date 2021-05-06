
// https://github.com/pingcap/tidb/blob/master/session/bootstrap.go#L343
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
	chan child_bootstrap3430 = [1] of {int};
	run bootstrap343(child_bootstrap3430)
stop_process:skip
}

proctype bootstrap343(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef dom_serverIDSession_client_mu;
	Mutexdef dom_serverIDSession_client_resolverGroup_mu;
	Mutexdef dom_serverIDSession_client_cfg_TLS_mutex;
	Mutexdef dom_serverIDSession_client_conn_firstResolveEvent_o_m;
	Mutexdef dom_serverIDSession_client_conn_balancerWrapper_mu;
	Mutexdef dom_serverIDSession_client_conn_balancerWrapper_done_o_m;
	Mutexdef dom_serverIDSession_client_conn_balancerWrapper_scBuffer_mu;
	Mutexdef dom_serverIDSession_client_conn_balancerWrapper_balancerMu;
	Mutexdef dom_serverIDSession_client_conn_resolverWrapper_pollingMu;
	Mutexdef dom_serverIDSession_client_conn_resolverWrapper_done_o_m;
	Mutexdef dom_serverIDSession_client_conn_resolverWrapper_resolverMu;
	Mutexdef dom_serverIDSession_client_conn_mu;
	Mutexdef dom_serverIDSession_client_conn_blockingpicker_mu;
	Mutexdef dom_serverIDSession_client_conn_csMgr_mu;
	Wgdef dom_wg;
	Mutexdef dom_slowQuery_mu;
	Mutexdef dom_gvc_SingleFight_mu;
	Mutexdef dom_etcdClient_mu;
	Mutexdef dom_etcdClient_resolverGroup_mu;
	Mutexdef dom_etcdClient_cfg_TLS_mutex;
	Mutexdef dom_etcdClient_conn_firstResolveEvent_o_m;
	Mutexdef dom_etcdClient_conn_balancerWrapper_mu;
	Mutexdef dom_etcdClient_conn_balancerWrapper_done_o_m;
	Mutexdef dom_etcdClient_conn_balancerWrapper_scBuffer_mu;
	Mutexdef dom_etcdClient_conn_balancerWrapper_balancerMu;
	Mutexdef dom_etcdClient_conn_resolverWrapper_pollingMu;
	Mutexdef dom_etcdClient_conn_resolverWrapper_done_o_m;
	Mutexdef dom_etcdClient_conn_resolverWrapper_resolverMu;
	Mutexdef dom_etcdClient_conn_mu;
	Mutexdef dom_etcdClient_conn_blockingpicker_mu;
	Mutexdef dom_etcdClient_conn_csMgr_mu;
	Mutexdef dom_sysSessionPool_mu;
	Mutexdef dom_m;
	Mutexdef dom_info_topologySession_client_mu;
	Mutexdef dom_info_topologySession_client_resolverGroup_mu;
	Mutexdef dom_info_topologySession_client_cfg_TLS_mutex;
	Mutexdef dom_info_topologySession_client_conn_firstResolveEvent_o_m;
	Mutexdef dom_info_topologySession_client_conn_balancerWrapper_mu;
	Mutexdef dom_info_topologySession_client_conn_balancerWrapper_done_o_m;
	Mutexdef dom_info_topologySession_client_conn_balancerWrapper_scBuffer_mu;
	Mutexdef dom_info_topologySession_client_conn_balancerWrapper_balancerMu;
	Mutexdef dom_info_topologySession_client_conn_resolverWrapper_pollingMu;
	Mutexdef dom_info_topologySession_client_conn_resolverWrapper_done_o_m;
	Mutexdef dom_info_topologySession_client_conn_resolverWrapper_resolverMu;
	Mutexdef dom_info_topologySession_client_conn_mu;
	Mutexdef dom_info_topologySession_client_conn_blockingpicker_mu;
	Mutexdef dom_info_topologySession_client_conn_csMgr_mu;
	Mutexdef dom_info_session_client_mu;
	Mutexdef dom_info_session_client_resolverGroup_mu;
	Mutexdef dom_info_session_client_cfg_TLS_mutex;
	Mutexdef dom_info_session_client_conn_firstResolveEvent_o_m;
	Mutexdef dom_info_session_client_conn_balancerWrapper_mu;
	Mutexdef dom_info_session_client_conn_balancerWrapper_done_o_m;
	Mutexdef dom_info_session_client_conn_balancerWrapper_scBuffer_mu;
	Mutexdef dom_info_session_client_conn_balancerWrapper_balancerMu;
	Mutexdef dom_info_session_client_conn_resolverWrapper_pollingMu;
	Mutexdef dom_info_session_client_conn_resolverWrapper_done_o_m;
	Mutexdef dom_info_session_client_conn_resolverWrapper_resolverMu;
	Mutexdef dom_info_session_client_conn_mu;
	Mutexdef dom_info_session_client_conn_blockingpicker_mu;
	Mutexdef dom_info_session_client_conn_csMgr_mu;
	Mutexdef dom_info_etcdCli_mu;
	Mutexdef dom_info_etcdCli_resolverGroup_mu;
	Mutexdef dom_info_etcdCli_cfg_TLS_mutex;
	Mutexdef dom_info_etcdCli_conn_firstResolveEvent_o_m;
	Mutexdef dom_info_etcdCli_conn_balancerWrapper_mu;
	Mutexdef dom_info_etcdCli_conn_balancerWrapper_done_o_m;
	Mutexdef dom_info_etcdCli_conn_balancerWrapper_scBuffer_mu;
	Mutexdef dom_info_etcdCli_conn_balancerWrapper_balancerMu;
	Mutexdef dom_info_etcdCli_conn_resolverWrapper_pollingMu;
	Mutexdef dom_info_etcdCli_conn_resolverWrapper_done_o_m;
	Mutexdef dom_info_etcdCli_conn_resolverWrapper_resolverMu;
	Mutexdef dom_info_etcdCli_conn_mu;
	Mutexdef dom_info_etcdCli_conn_blockingpicker_mu;
	Mutexdef dom_info_etcdCli_conn_csMgr_mu;
	Mutexdef dom_bindHandle_bindInfo;
	Mutexdef dom_bindHandle_sctx;
	run mutexMonitor(dom_bindHandle_sctx);
	run mutexMonitor(dom_bindHandle_bindInfo);
	run mutexMonitor(dom_info_etcdCli_conn_csMgr_mu);
	run mutexMonitor(dom_info_etcdCli_conn_blockingpicker_mu);
	run mutexMonitor(dom_info_etcdCli_conn_mu);
	run mutexMonitor(dom_info_etcdCli_conn_resolverWrapper_resolverMu);
	run mutexMonitor(dom_info_etcdCli_conn_resolverWrapper_done_o_m);
	run mutexMonitor(dom_info_etcdCli_conn_resolverWrapper_pollingMu);
	run mutexMonitor(dom_info_etcdCli_conn_balancerWrapper_balancerMu);
	run mutexMonitor(dom_info_etcdCli_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(dom_info_etcdCli_conn_balancerWrapper_done_o_m);
	run mutexMonitor(dom_info_etcdCli_conn_balancerWrapper_mu);
	run mutexMonitor(dom_info_etcdCli_conn_firstResolveEvent_o_m);
	run mutexMonitor(dom_info_etcdCli_cfg_TLS_mutex);
	run mutexMonitor(dom_info_etcdCli_resolverGroup_mu);
	run mutexMonitor(dom_info_etcdCli_mu);
	run mutexMonitor(dom_info_session_client_conn_csMgr_mu);
	run mutexMonitor(dom_info_session_client_conn_blockingpicker_mu);
	run mutexMonitor(dom_info_session_client_conn_mu);
	run mutexMonitor(dom_info_session_client_conn_resolverWrapper_resolverMu);
	run mutexMonitor(dom_info_session_client_conn_resolverWrapper_done_o_m);
	run mutexMonitor(dom_info_session_client_conn_resolverWrapper_pollingMu);
	run mutexMonitor(dom_info_session_client_conn_balancerWrapper_balancerMu);
	run mutexMonitor(dom_info_session_client_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(dom_info_session_client_conn_balancerWrapper_done_o_m);
	run mutexMonitor(dom_info_session_client_conn_balancerWrapper_mu);
	run mutexMonitor(dom_info_session_client_conn_firstResolveEvent_o_m);
	run mutexMonitor(dom_info_session_client_cfg_TLS_mutex);
	run mutexMonitor(dom_info_session_client_resolverGroup_mu);
	run mutexMonitor(dom_info_session_client_mu);
	run mutexMonitor(dom_info_topologySession_client_conn_csMgr_mu);
	run mutexMonitor(dom_info_topologySession_client_conn_blockingpicker_mu);
	run mutexMonitor(dom_info_topologySession_client_conn_mu);
	run mutexMonitor(dom_info_topologySession_client_conn_resolverWrapper_resolverMu);
	run mutexMonitor(dom_info_topologySession_client_conn_resolverWrapper_done_o_m);
	run mutexMonitor(dom_info_topologySession_client_conn_resolverWrapper_pollingMu);
	run mutexMonitor(dom_info_topologySession_client_conn_balancerWrapper_balancerMu);
	run mutexMonitor(dom_info_topologySession_client_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(dom_info_topologySession_client_conn_balancerWrapper_done_o_m);
	run mutexMonitor(dom_info_topologySession_client_conn_balancerWrapper_mu);
	run mutexMonitor(dom_info_topologySession_client_conn_firstResolveEvent_o_m);
	run mutexMonitor(dom_info_topologySession_client_cfg_TLS_mutex);
	run mutexMonitor(dom_info_topologySession_client_resolverGroup_mu);
	run mutexMonitor(dom_info_topologySession_client_mu);
	run mutexMonitor(dom_m);
	run mutexMonitor(dom_sysSessionPool_mu);
	run mutexMonitor(dom_etcdClient_conn_csMgr_mu);
	run mutexMonitor(dom_etcdClient_conn_blockingpicker_mu);
	run mutexMonitor(dom_etcdClient_conn_mu);
	run mutexMonitor(dom_etcdClient_conn_resolverWrapper_resolverMu);
	run mutexMonitor(dom_etcdClient_conn_resolverWrapper_done_o_m);
	run mutexMonitor(dom_etcdClient_conn_resolverWrapper_pollingMu);
	run mutexMonitor(dom_etcdClient_conn_balancerWrapper_balancerMu);
	run mutexMonitor(dom_etcdClient_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(dom_etcdClient_conn_balancerWrapper_done_o_m);
	run mutexMonitor(dom_etcdClient_conn_balancerWrapper_mu);
	run mutexMonitor(dom_etcdClient_conn_firstResolveEvent_o_m);
	run mutexMonitor(dom_etcdClient_cfg_TLS_mutex);
	run mutexMonitor(dom_etcdClient_resolverGroup_mu);
	run mutexMonitor(dom_etcdClient_mu);
	run mutexMonitor(dom_gvc_SingleFight_mu);
	run mutexMonitor(dom_slowQuery_mu);
	run wgMonitor(dom_wg);
	run mutexMonitor(dom_serverIDSession_client_conn_csMgr_mu);
	run mutexMonitor(dom_serverIDSession_client_conn_blockingpicker_mu);
	run mutexMonitor(dom_serverIDSession_client_conn_mu);
	run mutexMonitor(dom_serverIDSession_client_conn_resolverWrapper_resolverMu);
	run mutexMonitor(dom_serverIDSession_client_conn_resolverWrapper_done_o_m);
	run mutexMonitor(dom_serverIDSession_client_conn_resolverWrapper_pollingMu);
	run mutexMonitor(dom_serverIDSession_client_conn_balancerWrapper_balancerMu);
	run mutexMonitor(dom_serverIDSession_client_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(dom_serverIDSession_client_conn_balancerWrapper_done_o_m);
	run mutexMonitor(dom_serverIDSession_client_conn_balancerWrapper_mu);
	run mutexMonitor(dom_serverIDSession_client_conn_firstResolveEvent_o_m);
	run mutexMonitor(dom_serverIDSession_client_cfg_TLS_mutex);
	run mutexMonitor(dom_serverIDSession_client_resolverGroup_mu);
	run mutexMonitor(dom_serverIDSession_client_mu);
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

