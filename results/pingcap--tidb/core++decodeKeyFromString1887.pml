
// https://github.com/pingcap/tidb/blob/master/planner/core/expression_rewriter.go#L1887
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
	chan child_decodeKeyFromString18870 = [1] of {int};
	run decodeKeyFromString1887(child_decodeKeyFromString18870)
stop_process:skip
}

proctype decodeKeyFromString1887(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef dm_serverIDSession_client_mu;
	Mutexdef dm_serverIDSession_client_resolverGroup_mu;
	Mutexdef dm_serverIDSession_client_cfg_TLS_mutex;
	Mutexdef dm_serverIDSession_client_conn_firstResolveEvent_o_m;
	Mutexdef dm_serverIDSession_client_conn_balancerWrapper_mu;
	Mutexdef dm_serverIDSession_client_conn_balancerWrapper_done_o_m;
	Mutexdef dm_serverIDSession_client_conn_balancerWrapper_scBuffer_mu;
	Mutexdef dm_serverIDSession_client_conn_balancerWrapper_balancerMu;
	Mutexdef dm_serverIDSession_client_conn_resolverWrapper_pollingMu;
	Mutexdef dm_serverIDSession_client_conn_resolverWrapper_done_o_m;
	Mutexdef dm_serverIDSession_client_conn_resolverWrapper_resolverMu;
	Mutexdef dm_serverIDSession_client_conn_mu;
	Mutexdef dm_serverIDSession_client_conn_blockingpicker_mu;
	Mutexdef dm_serverIDSession_client_conn_csMgr_mu;
	Wgdef dm_wg;
	Mutexdef dm_slowQuery_mu;
	Mutexdef dm_gvc_SingleFight_mu;
	Mutexdef dm_etcdClient_mu;
	Mutexdef dm_etcdClient_resolverGroup_mu;
	Mutexdef dm_etcdClient_cfg_TLS_mutex;
	Mutexdef dm_etcdClient_conn_firstResolveEvent_o_m;
	Mutexdef dm_etcdClient_conn_balancerWrapper_mu;
	Mutexdef dm_etcdClient_conn_balancerWrapper_done_o_m;
	Mutexdef dm_etcdClient_conn_balancerWrapper_scBuffer_mu;
	Mutexdef dm_etcdClient_conn_balancerWrapper_balancerMu;
	Mutexdef dm_etcdClient_conn_resolverWrapper_pollingMu;
	Mutexdef dm_etcdClient_conn_resolverWrapper_done_o_m;
	Mutexdef dm_etcdClient_conn_resolverWrapper_resolverMu;
	Mutexdef dm_etcdClient_conn_mu;
	Mutexdef dm_etcdClient_conn_blockingpicker_mu;
	Mutexdef dm_etcdClient_conn_csMgr_mu;
	Mutexdef dm_sysSessionPool_mu;
	Mutexdef dm_m;
	Mutexdef dm_info_topologySession_client_mu;
	Mutexdef dm_info_topologySession_client_resolverGroup_mu;
	Mutexdef dm_info_topologySession_client_cfg_TLS_mutex;
	Mutexdef dm_info_topologySession_client_conn_firstResolveEvent_o_m;
	Mutexdef dm_info_topologySession_client_conn_balancerWrapper_mu;
	Mutexdef dm_info_topologySession_client_conn_balancerWrapper_done_o_m;
	Mutexdef dm_info_topologySession_client_conn_balancerWrapper_scBuffer_mu;
	Mutexdef dm_info_topologySession_client_conn_balancerWrapper_balancerMu;
	Mutexdef dm_info_topologySession_client_conn_resolverWrapper_pollingMu;
	Mutexdef dm_info_topologySession_client_conn_resolverWrapper_done_o_m;
	Mutexdef dm_info_topologySession_client_conn_resolverWrapper_resolverMu;
	Mutexdef dm_info_topologySession_client_conn_mu;
	Mutexdef dm_info_topologySession_client_conn_blockingpicker_mu;
	Mutexdef dm_info_topologySession_client_conn_csMgr_mu;
	Mutexdef dm_info_session_client_mu;
	Mutexdef dm_info_session_client_resolverGroup_mu;
	Mutexdef dm_info_session_client_cfg_TLS_mutex;
	Mutexdef dm_info_session_client_conn_firstResolveEvent_o_m;
	Mutexdef dm_info_session_client_conn_balancerWrapper_mu;
	Mutexdef dm_info_session_client_conn_balancerWrapper_done_o_m;
	Mutexdef dm_info_session_client_conn_balancerWrapper_scBuffer_mu;
	Mutexdef dm_info_session_client_conn_balancerWrapper_balancerMu;
	Mutexdef dm_info_session_client_conn_resolverWrapper_pollingMu;
	Mutexdef dm_info_session_client_conn_resolverWrapper_done_o_m;
	Mutexdef dm_info_session_client_conn_resolverWrapper_resolverMu;
	Mutexdef dm_info_session_client_conn_mu;
	Mutexdef dm_info_session_client_conn_blockingpicker_mu;
	Mutexdef dm_info_session_client_conn_csMgr_mu;
	Mutexdef dm_info_etcdCli_mu;
	Mutexdef dm_info_etcdCli_resolverGroup_mu;
	Mutexdef dm_info_etcdCli_cfg_TLS_mutex;
	Mutexdef dm_info_etcdCli_conn_firstResolveEvent_o_m;
	Mutexdef dm_info_etcdCli_conn_balancerWrapper_mu;
	Mutexdef dm_info_etcdCli_conn_balancerWrapper_done_o_m;
	Mutexdef dm_info_etcdCli_conn_balancerWrapper_scBuffer_mu;
	Mutexdef dm_info_etcdCli_conn_balancerWrapper_balancerMu;
	Mutexdef dm_info_etcdCli_conn_resolverWrapper_pollingMu;
	Mutexdef dm_info_etcdCli_conn_resolverWrapper_done_o_m;
	Mutexdef dm_info_etcdCli_conn_resolverWrapper_resolverMu;
	Mutexdef dm_info_etcdCli_conn_mu;
	Mutexdef dm_info_etcdCli_conn_blockingpicker_mu;
	Mutexdef dm_info_etcdCli_conn_csMgr_mu;
	Mutexdef dm_bindHandle_bindInfo;
	Mutexdef dm_bindHandle_sctx;
	

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
	run mutexMonitor(dm_bindHandle_sctx);
	run mutexMonitor(dm_bindHandle_bindInfo);
	run mutexMonitor(dm_info_etcdCli_conn_csMgr_mu);
	run mutexMonitor(dm_info_etcdCli_conn_blockingpicker_mu);
	run mutexMonitor(dm_info_etcdCli_conn_mu);
	run mutexMonitor(dm_info_etcdCli_conn_resolverWrapper_resolverMu);
	run mutexMonitor(dm_info_etcdCli_conn_resolverWrapper_done_o_m);
	run mutexMonitor(dm_info_etcdCli_conn_resolverWrapper_pollingMu);
	run mutexMonitor(dm_info_etcdCli_conn_balancerWrapper_balancerMu);
	run mutexMonitor(dm_info_etcdCli_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(dm_info_etcdCli_conn_balancerWrapper_done_o_m);
	run mutexMonitor(dm_info_etcdCli_conn_balancerWrapper_mu);
	run mutexMonitor(dm_info_etcdCli_conn_firstResolveEvent_o_m);
	run mutexMonitor(dm_info_etcdCli_cfg_TLS_mutex);
	run mutexMonitor(dm_info_etcdCli_resolverGroup_mu);
	run mutexMonitor(dm_info_etcdCli_mu);
	run mutexMonitor(dm_info_session_client_conn_csMgr_mu);
	run mutexMonitor(dm_info_session_client_conn_blockingpicker_mu);
	run mutexMonitor(dm_info_session_client_conn_mu);
	run mutexMonitor(dm_info_session_client_conn_resolverWrapper_resolverMu);
	run mutexMonitor(dm_info_session_client_conn_resolverWrapper_done_o_m);
	run mutexMonitor(dm_info_session_client_conn_resolverWrapper_pollingMu);
	run mutexMonitor(dm_info_session_client_conn_balancerWrapper_balancerMu);
	run mutexMonitor(dm_info_session_client_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(dm_info_session_client_conn_balancerWrapper_done_o_m);
	run mutexMonitor(dm_info_session_client_conn_balancerWrapper_mu);
	run mutexMonitor(dm_info_session_client_conn_firstResolveEvent_o_m);
	run mutexMonitor(dm_info_session_client_cfg_TLS_mutex);
	run mutexMonitor(dm_info_session_client_resolverGroup_mu);
	run mutexMonitor(dm_info_session_client_mu);
	run mutexMonitor(dm_info_topologySession_client_conn_csMgr_mu);
	run mutexMonitor(dm_info_topologySession_client_conn_blockingpicker_mu);
	run mutexMonitor(dm_info_topologySession_client_conn_mu);
	run mutexMonitor(dm_info_topologySession_client_conn_resolverWrapper_resolverMu);
	run mutexMonitor(dm_info_topologySession_client_conn_resolverWrapper_done_o_m);
	run mutexMonitor(dm_info_topologySession_client_conn_resolverWrapper_pollingMu);
	run mutexMonitor(dm_info_topologySession_client_conn_balancerWrapper_balancerMu);
	run mutexMonitor(dm_info_topologySession_client_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(dm_info_topologySession_client_conn_balancerWrapper_done_o_m);
	run mutexMonitor(dm_info_topologySession_client_conn_balancerWrapper_mu);
	run mutexMonitor(dm_info_topologySession_client_conn_firstResolveEvent_o_m);
	run mutexMonitor(dm_info_topologySession_client_cfg_TLS_mutex);
	run mutexMonitor(dm_info_topologySession_client_resolverGroup_mu);
	run mutexMonitor(dm_info_topologySession_client_mu);
	run mutexMonitor(dm_m);
	run mutexMonitor(dm_sysSessionPool_mu);
	run mutexMonitor(dm_etcdClient_conn_csMgr_mu);
	run mutexMonitor(dm_etcdClient_conn_blockingpicker_mu);
	run mutexMonitor(dm_etcdClient_conn_mu);
	run mutexMonitor(dm_etcdClient_conn_resolverWrapper_resolverMu);
	run mutexMonitor(dm_etcdClient_conn_resolverWrapper_done_o_m);
	run mutexMonitor(dm_etcdClient_conn_resolverWrapper_pollingMu);
	run mutexMonitor(dm_etcdClient_conn_balancerWrapper_balancerMu);
	run mutexMonitor(dm_etcdClient_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(dm_etcdClient_conn_balancerWrapper_done_o_m);
	run mutexMonitor(dm_etcdClient_conn_balancerWrapper_mu);
	run mutexMonitor(dm_etcdClient_conn_firstResolveEvent_o_m);
	run mutexMonitor(dm_etcdClient_cfg_TLS_mutex);
	run mutexMonitor(dm_etcdClient_resolverGroup_mu);
	run mutexMonitor(dm_etcdClient_mu);
	run mutexMonitor(dm_gvc_SingleFight_mu);
	run mutexMonitor(dm_slowQuery_mu);
	run wgMonitor(dm_wg);
	run mutexMonitor(dm_serverIDSession_client_conn_csMgr_mu);
	run mutexMonitor(dm_serverIDSession_client_conn_blockingpicker_mu);
	run mutexMonitor(dm_serverIDSession_client_conn_mu);
	run mutexMonitor(dm_serverIDSession_client_conn_resolverWrapper_resolverMu);
	run mutexMonitor(dm_serverIDSession_client_conn_resolverWrapper_done_o_m);
	run mutexMonitor(dm_serverIDSession_client_conn_resolverWrapper_pollingMu);
	run mutexMonitor(dm_serverIDSession_client_conn_balancerWrapper_balancerMu);
	run mutexMonitor(dm_serverIDSession_client_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(dm_serverIDSession_client_conn_balancerWrapper_done_o_m);
	run mutexMonitor(dm_serverIDSession_client_conn_balancerWrapper_mu);
	run mutexMonitor(dm_serverIDSession_client_conn_firstResolveEvent_o_m);
	run mutexMonitor(dm_serverIDSession_client_cfg_TLS_mutex);
	run mutexMonitor(dm_serverIDSession_client_resolverGroup_mu);
	run mutexMonitor(dm_serverIDSession_client_mu);
	

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
		fi
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

