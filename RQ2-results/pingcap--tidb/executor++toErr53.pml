
// https://github.com/pingcap/tidb/blob/master/executor/ddl.go#L53
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
	chan child_toErr530 = [1] of {int};
	run toErr53(child_toErr530)
stop_process:skip
}

proctype toErr53(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewSchemaChecker450 = [1] of {int};
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
	run NewSchemaChecker45(dom_wg,dom_bindHandle_sctx,dom_bindHandle_bindInfo,dom_info_etcdCli_conn_csMgr_mu,dom_info_etcdCli_conn_blockingpicker_mu,dom_info_etcdCli_conn_mu,dom_info_etcdCli_conn_resolverWrapper_resolverMu,dom_info_etcdCli_conn_resolverWrapper_done_o_m,dom_info_etcdCli_conn_resolverWrapper_pollingMu,dom_info_etcdCli_conn_balancerWrapper_balancerMu,dom_info_etcdCli_conn_balancerWrapper_scBuffer_mu,dom_info_etcdCli_conn_balancerWrapper_done_o_m,dom_info_etcdCli_conn_balancerWrapper_mu,dom_info_etcdCli_conn_firstResolveEvent_o_m,dom_info_etcdCli_cfg_TLS_mutex,dom_info_etcdCli_resolverGroup_mu,dom_info_etcdCli_mu,dom_info_session_client_conn_csMgr_mu,dom_info_session_client_conn_blockingpicker_mu,dom_info_session_client_conn_mu,dom_info_session_client_conn_resolverWrapper_resolverMu,dom_info_session_client_conn_resolverWrapper_done_o_m,dom_info_session_client_conn_resolverWrapper_pollingMu,dom_info_session_client_conn_balancerWrapper_balancerMu,dom_info_session_client_conn_balancerWrapper_scBuffer_mu,dom_info_session_client_conn_balancerWrapper_done_o_m,dom_info_session_client_conn_balancerWrapper_mu,dom_info_session_client_conn_firstResolveEvent_o_m,dom_info_session_client_cfg_TLS_mutex,dom_info_session_client_resolverGroup_mu,dom_info_session_client_mu,dom_info_topologySession_client_conn_csMgr_mu,dom_info_topologySession_client_conn_blockingpicker_mu,dom_info_topologySession_client_conn_mu,dom_info_topologySession_client_conn_resolverWrapper_resolverMu,dom_info_topologySession_client_conn_resolverWrapper_done_o_m,dom_info_topologySession_client_conn_resolverWrapper_pollingMu,dom_info_topologySession_client_conn_balancerWrapper_balancerMu,dom_info_topologySession_client_conn_balancerWrapper_scBuffer_mu,dom_info_topologySession_client_conn_balancerWrapper_done_o_m,dom_info_topologySession_client_conn_balancerWrapper_mu,dom_info_topologySession_client_conn_firstResolveEvent_o_m,dom_info_topologySession_client_cfg_TLS_mutex,dom_info_topologySession_client_resolverGroup_mu,dom_info_topologySession_client_mu,dom_m,dom_sysSessionPool_mu,dom_etcdClient_conn_csMgr_mu,dom_etcdClient_conn_blockingpicker_mu,dom_etcdClient_conn_mu,dom_etcdClient_conn_resolverWrapper_resolverMu,dom_etcdClient_conn_resolverWrapper_done_o_m,dom_etcdClient_conn_resolverWrapper_pollingMu,dom_etcdClient_conn_balancerWrapper_balancerMu,dom_etcdClient_conn_balancerWrapper_scBuffer_mu,dom_etcdClient_conn_balancerWrapper_done_o_m,dom_etcdClient_conn_balancerWrapper_mu,dom_etcdClient_conn_firstResolveEvent_o_m,dom_etcdClient_cfg_TLS_mutex,dom_etcdClient_resolverGroup_mu,dom_etcdClient_mu,dom_gvc_SingleFight_mu,dom_slowQuery_mu,dom_serverIDSession_client_conn_csMgr_mu,dom_serverIDSession_client_conn_blockingpicker_mu,dom_serverIDSession_client_conn_mu,dom_serverIDSession_client_conn_resolverWrapper_resolverMu,dom_serverIDSession_client_conn_resolverWrapper_done_o_m,dom_serverIDSession_client_conn_resolverWrapper_pollingMu,dom_serverIDSession_client_conn_balancerWrapper_balancerMu,dom_serverIDSession_client_conn_balancerWrapper_scBuffer_mu,dom_serverIDSession_client_conn_balancerWrapper_done_o_m,dom_serverIDSession_client_conn_balancerWrapper_mu,dom_serverIDSession_client_conn_firstResolveEvent_o_m,dom_serverIDSession_client_cfg_TLS_mutex,dom_serverIDSession_client_resolverGroup_mu,dom_serverIDSession_client_mu,child_NewSchemaChecker450);
	child_NewSchemaChecker450?0;
	

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
proctype NewSchemaChecker45(Wgdef do_wg;Mutexdef do_bindHandle_sctx;Mutexdef do_bindHandle_bindInfo;Mutexdef do_info_etcdCli_conn_csMgr_mu;Mutexdef do_info_etcdCli_conn_blockingpicker_mu;Mutexdef do_info_etcdCli_conn_mu;Mutexdef do_info_etcdCli_conn_resolverWrapper_resolverMu;Mutexdef do_info_etcdCli_conn_resolverWrapper_done_o_m;Mutexdef do_info_etcdCli_conn_resolverWrapper_pollingMu;Mutexdef do_info_etcdCli_conn_balancerWrapper_balancerMu;Mutexdef do_info_etcdCli_conn_balancerWrapper_scBuffer_mu;Mutexdef do_info_etcdCli_conn_balancerWrapper_done_o_m;Mutexdef do_info_etcdCli_conn_balancerWrapper_mu;Mutexdef do_info_etcdCli_conn_firstResolveEvent_o_m;Mutexdef do_info_etcdCli_cfg_TLS_mutex;Mutexdef do_info_etcdCli_resolverGroup_mu;Mutexdef do_info_etcdCli_mu;Mutexdef do_info_session_client_conn_csMgr_mu;Mutexdef do_info_session_client_conn_blockingpicker_mu;Mutexdef do_info_session_client_conn_mu;Mutexdef do_info_session_client_conn_resolverWrapper_resolverMu;Mutexdef do_info_session_client_conn_resolverWrapper_done_o_m;Mutexdef do_info_session_client_conn_resolverWrapper_pollingMu;Mutexdef do_info_session_client_conn_balancerWrapper_balancerMu;Mutexdef do_info_session_client_conn_balancerWrapper_scBuffer_mu;Mutexdef do_info_session_client_conn_balancerWrapper_done_o_m;Mutexdef do_info_session_client_conn_balancerWrapper_mu;Mutexdef do_info_session_client_conn_firstResolveEvent_o_m;Mutexdef do_info_session_client_cfg_TLS_mutex;Mutexdef do_info_session_client_resolverGroup_mu;Mutexdef do_info_session_client_mu;Mutexdef do_info_topologySession_client_conn_csMgr_mu;Mutexdef do_info_topologySession_client_conn_blockingpicker_mu;Mutexdef do_info_topologySession_client_conn_mu;Mutexdef do_info_topologySession_client_conn_resolverWrapper_resolverMu;Mutexdef do_info_topologySession_client_conn_resolverWrapper_done_o_m;Mutexdef do_info_topologySession_client_conn_resolverWrapper_pollingMu;Mutexdef do_info_topologySession_client_conn_balancerWrapper_balancerMu;Mutexdef do_info_topologySession_client_conn_balancerWrapper_scBuffer_mu;Mutexdef do_info_topologySession_client_conn_balancerWrapper_done_o_m;Mutexdef do_info_topologySession_client_conn_balancerWrapper_mu;Mutexdef do_info_topologySession_client_conn_firstResolveEvent_o_m;Mutexdef do_info_topologySession_client_cfg_TLS_mutex;Mutexdef do_info_topologySession_client_resolverGroup_mu;Mutexdef do_info_topologySession_client_mu;Mutexdef do_m;Mutexdef do_sysSessionPool_mu;Mutexdef do_etcdClient_conn_csMgr_mu;Mutexdef do_etcdClient_conn_blockingpicker_mu;Mutexdef do_etcdClient_conn_mu;Mutexdef do_etcdClient_conn_resolverWrapper_resolverMu;Mutexdef do_etcdClient_conn_resolverWrapper_done_o_m;Mutexdef do_etcdClient_conn_resolverWrapper_pollingMu;Mutexdef do_etcdClient_conn_balancerWrapper_balancerMu;Mutexdef do_etcdClient_conn_balancerWrapper_scBuffer_mu;Mutexdef do_etcdClient_conn_balancerWrapper_done_o_m;Mutexdef do_etcdClient_conn_balancerWrapper_mu;Mutexdef do_etcdClient_conn_firstResolveEvent_o_m;Mutexdef do_etcdClient_cfg_TLS_mutex;Mutexdef do_etcdClient_resolverGroup_mu;Mutexdef do_etcdClient_mu;Mutexdef do_gvc_SingleFight_mu;Mutexdef do_slowQuery_mu;Mutexdef do_serverIDSession_client_conn_csMgr_mu;Mutexdef do_serverIDSession_client_conn_blockingpicker_mu;Mutexdef do_serverIDSession_client_conn_mu;Mutexdef do_serverIDSession_client_conn_resolverWrapper_resolverMu;Mutexdef do_serverIDSession_client_conn_resolverWrapper_done_o_m;Mutexdef do_serverIDSession_client_conn_resolverWrapper_pollingMu;Mutexdef do_serverIDSession_client_conn_balancerWrapper_balancerMu;Mutexdef do_serverIDSession_client_conn_balancerWrapper_scBuffer_mu;Mutexdef do_serverIDSession_client_conn_balancerWrapper_done_o_m;Mutexdef do_serverIDSession_client_conn_balancerWrapper_mu;Mutexdef do_serverIDSession_client_conn_firstResolveEvent_o_m;Mutexdef do_serverIDSession_client_cfg_TLS_mutex;Mutexdef do_serverIDSession_client_resolverGroup_mu;Mutexdef do_serverIDSession_client_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

