// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/ethereum/go-ethereum/blob//graphql/graphql_test.go#L42
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
	chan child_TestBuildSchema420 = [1] of {int};
	run TestBuildSchema42(child_TestBuildSchema420);
	run receiver(child_TestBuildSchema420)
stop_process:skip
}

proctype TestBuildSchema42(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newHandler690 = [1] of {int};
	Mutexdef stack_inprocHandler_services_mu;
	Mutexdef stack_ipc_srv_services_mu;
	Mutexdef stack_ipc_mu;
	Mutexdef stack_ws_server_mu;
	Mutexdef stack_ws_server_nextProtoOnce_m;
	Mutexdef stack_ws_server_ErrorLog_mu;
	Mutexdef stack_ws_server_TLSConfig_mutex;
	Mutexdef stack_ws_mu;
	Mutexdef stack_ws_mux_mu;
	Mutexdef stack_http_server_mu;
	Mutexdef stack_http_server_nextProtoOnce_m;
	Mutexdef stack_http_server_ErrorLog_mu;
	Mutexdef stack_http_server_TLSConfig_mutex;
	Mutexdef stack_http_mu;
	Mutexdef stack_http_mux_mu;
	Mutexdef stack_lock;
	Mutexdef stack_startStopLock;
	Wgdef stack_server_dialsched_wg;
	Mutexdef stack_server_discmix_mu;
	Wgdef stack_server_discmix_wg;
	Wgdef stack_server_DiscV5_wg;
	Mutexdef stack_server_DiscV5_closeOnce_m;
	Mutexdef stack_server_DiscV5_trlock;
	Mutexdef stack_server_DiscV5_localNode_mu;
	Mutexdef stack_server_DiscV5_tab_mutex;
	Wgdef stack_server_ntab_wg;
	Mutexdef stack_server_ntab_closeOnce_m;
	Mutexdef stack_server_ntab_tab_mutex;
	Mutexdef stack_server_ntab_localNode_mu;
	Mutexdef stack_server_localnode_mu;
	Mutexdef stack_server_nodedb_runner_m;
	Wgdef stack_server_nodedb_lvl_closeW;
	Mutexdef stack_server_nodedb_lvl_compCommitLk;
	Mutexdef stack_server_nodedb_lvl_snapsMu;
	Mutexdef stack_server_nodedb_lvl_memMu;
	Mutexdef stack_server_peerFeed_mu;
	Mutexdef stack_server_peerFeed_once_m;
	Wgdef stack_server_loopWG;
	Mutexdef stack_server_lock;
	Mutexdef stack_accman_lock;
	Mutexdef stack_accman_feed_mu;
	Mutexdef stack_accman_feed_once_m;
	Mutexdef stack_eventmux_mutex;
	run mutexMonitor(stack_eventmux_mutex);
	run mutexMonitor(stack_accman_feed_once_m);
	run mutexMonitor(stack_accman_feed_mu);
	run mutexMonitor(stack_accman_lock);
	run mutexMonitor(stack_server_lock);
	run wgMonitor(stack_server_loopWG);
	run mutexMonitor(stack_server_peerFeed_once_m);
	run mutexMonitor(stack_server_peerFeed_mu);
	run mutexMonitor(stack_server_nodedb_lvl_memMu);
	run mutexMonitor(stack_server_nodedb_lvl_snapsMu);
	run mutexMonitor(stack_server_nodedb_lvl_compCommitLk);
	run wgMonitor(stack_server_nodedb_lvl_closeW);
	run mutexMonitor(stack_server_nodedb_runner_m);
	run mutexMonitor(stack_server_localnode_mu);
	run mutexMonitor(stack_server_ntab_localNode_mu);
	run mutexMonitor(stack_server_ntab_tab_mutex);
	run mutexMonitor(stack_server_ntab_closeOnce_m);
	run wgMonitor(stack_server_ntab_wg);
	run mutexMonitor(stack_server_DiscV5_tab_mutex);
	run mutexMonitor(stack_server_DiscV5_localNode_mu);
	run mutexMonitor(stack_server_DiscV5_trlock);
	run mutexMonitor(stack_server_DiscV5_closeOnce_m);
	run wgMonitor(stack_server_DiscV5_wg);
	run wgMonitor(stack_server_discmix_wg);
	run mutexMonitor(stack_server_discmix_mu);
	run wgMonitor(stack_server_dialsched_wg);
	run mutexMonitor(stack_startStopLock);
	run mutexMonitor(stack_lock);
	run mutexMonitor(stack_http_mux_mu);
	run mutexMonitor(stack_http_mu);
	run mutexMonitor(stack_http_server_TLSConfig_mutex);
	run mutexMonitor(stack_http_server_ErrorLog_mu);
	run mutexMonitor(stack_http_server_nextProtoOnce_m);
	run mutexMonitor(stack_http_server_mu);
	run mutexMonitor(stack_ws_mux_mu);
	run mutexMonitor(stack_ws_mu);
	run mutexMonitor(stack_ws_server_TLSConfig_mutex);
	run mutexMonitor(stack_ws_server_ErrorLog_mu);
	run mutexMonitor(stack_ws_server_nextProtoOnce_m);
	run mutexMonitor(stack_ws_server_mu);
	run mutexMonitor(stack_ipc_mu);
	run mutexMonitor(stack_ipc_srv_services_mu);
	run mutexMonitor(stack_inprocHandler_services_mu);
	run newHandler69(stack_server_DiscV5_wg,stack_server_dialsched_wg,stack_server_discmix_wg,stack_server_loopWG,stack_server_nodedb_lvl_closeW,stack_server_ntab_wg,stack_accman_feed_mu,stack_accman_feed_once_m,stack_accman_lock,stack_eventmux_mutex,stack_http_mu,stack_http_mux_mu,stack_http_server_ErrorLog_mu,stack_http_server_mu,stack_http_server_nextProtoOnce_m,stack_http_server_TLSConfig_mutex,stack_inprocHandler_services_mu,stack_ipc_mu,stack_ipc_srv_services_mu,stack_lock,stack_server_DiscV5_closeOnce_m,stack_server_DiscV5_localNode_mu,stack_server_DiscV5_tab_mutex,stack_server_DiscV5_trlock,stack_server_discmix_mu,stack_server_localnode_mu,stack_server_lock,stack_server_nodedb_lvl_compCommitLk,stack_server_nodedb_lvl_memMu,stack_server_nodedb_lvl_snapsMu,stack_server_nodedb_runner_m,stack_server_ntab_closeOnce_m,stack_server_ntab_localNode_mu,stack_server_ntab_tab_mutex,stack_server_peerFeed_mu,stack_server_peerFeed_once_m,stack_startStopLock,stack_ws_mu,stack_ws_mux_mu,stack_ws_server_ErrorLog_mu,stack_ws_server_mu,stack_ws_server_nextProtoOnce_m,stack_ws_server_TLSConfig_mutex,child_newHandler690);
	child_newHandler690?0;
	stop_process: skip;
	child!0
}
proctype newHandler69(Wgdef stack_server_DiscV5_wg;Wgdef stack_server_dialsched_wg;Wgdef stack_server_discmix_wg;Wgdef stack_server_loopWG;Wgdef stack_server_nodedb_lvl_closeW;Wgdef stack_server_ntab_wg;Mutexdef stack_accman_feed_mu;Mutexdef stack_accman_feed_once_m;Mutexdef stack_accman_lock;Mutexdef stack_eventmux_mutex;Mutexdef stack_http_mu;Mutexdef stack_http_mux_mu;Mutexdef stack_http_server_ErrorLog_mu;Mutexdef stack_http_server_mu;Mutexdef stack_http_server_nextProtoOnce_m;Mutexdef stack_http_server_TLSConfig_mutex;Mutexdef stack_inprocHandler_services_mu;Mutexdef stack_ipc_mu;Mutexdef stack_ipc_srv_services_mu;Mutexdef stack_lock;Mutexdef stack_server_DiscV5_closeOnce_m;Mutexdef stack_server_DiscV5_localNode_mu;Mutexdef stack_server_DiscV5_tab_mutex;Mutexdef stack_server_DiscV5_trlock;Mutexdef stack_server_discmix_mu;Mutexdef stack_server_localnode_mu;Mutexdef stack_server_lock;Mutexdef stack_server_nodedb_lvl_compCommitLk;Mutexdef stack_server_nodedb_lvl_memMu;Mutexdef stack_server_nodedb_lvl_snapsMu;Mutexdef stack_server_nodedb_runner_m;Mutexdef stack_server_ntab_closeOnce_m;Mutexdef stack_server_ntab_localNode_mu;Mutexdef stack_server_ntab_tab_mutex;Mutexdef stack_server_peerFeed_mu;Mutexdef stack_server_peerFeed_once_m;Mutexdef stack_startStopLock;Mutexdef stack_ws_mu;Mutexdef stack_ws_mux_mu;Mutexdef stack_ws_server_ErrorLog_mu;Mutexdef stack_ws_server_mu;Mutexdef stack_ws_server_nextProtoOnce_m;Mutexdef stack_ws_server_TLSConfig_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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

