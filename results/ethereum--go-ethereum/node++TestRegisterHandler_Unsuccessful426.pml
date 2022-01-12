// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/ethereum/go-ethereum/blob//node/node_test.go#L426
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
	chan child_TestRegisterHandler_Unsuccessful4260 = [1] of {int};
	run TestRegisterHandler_Unsuccessful426(child_TestRegisterHandler_Unsuccessful4260);
	run receiver(child_TestRegisterHandler_Unsuccessful4260)
stop_process:skip
}

proctype TestRegisterHandler_Unsuccessful426(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RegisterHandler4630 = [1] of {int};
	Mutexdef node_inprocHandler_services_mu;
	Mutexdef node_ipc_srv_services_mu;
	Mutexdef node_ipc_mu;
	Mutexdef node_ws_server_mu;
	Mutexdef node_ws_server_nextProtoOnce_m;
	Mutexdef node_ws_server_ErrorLog_mu;
	Mutexdef node_ws_server_TLSConfig_mutex;
	Mutexdef node_ws_mu;
	Mutexdef node_ws_mux_mu;
	Mutexdef node_http_server_mu;
	Mutexdef node_http_server_nextProtoOnce_m;
	Mutexdef node_http_server_ErrorLog_mu;
	Mutexdef node_http_server_TLSConfig_mutex;
	Mutexdef node_http_mu;
	Mutexdef node_http_mux_mu;
	Mutexdef node_lock;
	Mutexdef node_startStopLock;
	Wgdef node_server_dialsched_wg;
	Mutexdef node_server_discmix_mu;
	Wgdef node_server_discmix_wg;
	Wgdef node_server_DiscV5_wg;
	Mutexdef node_server_DiscV5_closeOnce_m;
	Mutexdef node_server_DiscV5_trlock;
	Mutexdef node_server_DiscV5_localNode_mu;
	Mutexdef node_server_DiscV5_tab_mutex;
	Wgdef node_server_ntab_wg;
	Mutexdef node_server_ntab_closeOnce_m;
	Mutexdef node_server_ntab_tab_mutex;
	Mutexdef node_server_ntab_localNode_mu;
	Mutexdef node_server_localnode_mu;
	Mutexdef node_server_nodedb_runner_m;
	Wgdef node_server_nodedb_lvl_closeW;
	Mutexdef node_server_nodedb_lvl_compCommitLk;
	Mutexdef node_server_nodedb_lvl_snapsMu;
	Mutexdef node_server_nodedb_lvl_memMu;
	Mutexdef node_server_peerFeed_mu;
	Mutexdef node_server_peerFeed_once_m;
	Wgdef node_server_loopWG;
	Mutexdef node_server_lock;
	Mutexdef node_accman_lock;
	Mutexdef node_accman_feed_mu;
	Mutexdef node_accman_feed_once_m;
	Mutexdef node_eventmux_mutex;
	run mutexMonitor(node_eventmux_mutex);
	run mutexMonitor(node_accman_feed_once_m);
	run mutexMonitor(node_accman_feed_mu);
	run mutexMonitor(node_accman_lock);
	run mutexMonitor(node_server_lock);
	run wgMonitor(node_server_loopWG);
	run mutexMonitor(node_server_peerFeed_once_m);
	run mutexMonitor(node_server_peerFeed_mu);
	run mutexMonitor(node_server_nodedb_lvl_memMu);
	run mutexMonitor(node_server_nodedb_lvl_snapsMu);
	run mutexMonitor(node_server_nodedb_lvl_compCommitLk);
	run wgMonitor(node_server_nodedb_lvl_closeW);
	run mutexMonitor(node_server_nodedb_runner_m);
	run mutexMonitor(node_server_localnode_mu);
	run mutexMonitor(node_server_ntab_localNode_mu);
	run mutexMonitor(node_server_ntab_tab_mutex);
	run mutexMonitor(node_server_ntab_closeOnce_m);
	run wgMonitor(node_server_ntab_wg);
	run mutexMonitor(node_server_DiscV5_tab_mutex);
	run mutexMonitor(node_server_DiscV5_localNode_mu);
	run mutexMonitor(node_server_DiscV5_trlock);
	run mutexMonitor(node_server_DiscV5_closeOnce_m);
	run wgMonitor(node_server_DiscV5_wg);
	run wgMonitor(node_server_discmix_wg);
	run mutexMonitor(node_server_discmix_mu);
	run wgMonitor(node_server_dialsched_wg);
	run mutexMonitor(node_startStopLock);
	run mutexMonitor(node_lock);
	run mutexMonitor(node_http_mux_mu);
	run mutexMonitor(node_http_mu);
	run mutexMonitor(node_http_server_TLSConfig_mutex);
	run mutexMonitor(node_http_server_ErrorLog_mu);
	run mutexMonitor(node_http_server_nextProtoOnce_m);
	run mutexMonitor(node_http_server_mu);
	run mutexMonitor(node_ws_mux_mu);
	run mutexMonitor(node_ws_mu);
	run mutexMonitor(node_ws_server_TLSConfig_mutex);
	run mutexMonitor(node_ws_server_ErrorLog_mu);
	run mutexMonitor(node_ws_server_nextProtoOnce_m);
	run mutexMonitor(node_ws_server_mu);
	run mutexMonitor(node_ipc_mu);
	run mutexMonitor(node_ipc_srv_services_mu);
	run mutexMonitor(node_inprocHandler_services_mu);
	run RegisterHandler463(node_server_DiscV5_wg,node_server_dialsched_wg,node_server_discmix_wg,node_server_loopWG,node_server_nodedb_lvl_closeW,node_server_ntab_wg,node_accman_feed_mu,node_accman_feed_once_m,node_accman_lock,node_eventmux_mutex,node_http_mu,node_http_mux_mu,node_http_server_ErrorLog_mu,node_http_server_mu,node_http_server_nextProtoOnce_m,node_http_server_TLSConfig_mutex,node_inprocHandler_services_mu,node_ipc_mu,node_ipc_srv_services_mu,node_lock,node_server_DiscV5_closeOnce_m,node_server_DiscV5_localNode_mu,node_server_DiscV5_tab_mutex,node_server_DiscV5_trlock,node_server_discmix_mu,node_server_localnode_mu,node_server_lock,node_server_nodedb_lvl_compCommitLk,node_server_nodedb_lvl_memMu,node_server_nodedb_lvl_snapsMu,node_server_nodedb_runner_m,node_server_ntab_closeOnce_m,node_server_ntab_localNode_mu,node_server_ntab_tab_mutex,node_server_peerFeed_mu,node_server_peerFeed_once_m,node_startStopLock,node_ws_mu,node_ws_mux_mu,node_ws_server_ErrorLog_mu,node_ws_server_mu,node_ws_server_nextProtoOnce_m,node_ws_server_TLSConfig_mutex,child_RegisterHandler4630);
	child_RegisterHandler4630?0;
	stop_process: skip;
	child!0
}
proctype RegisterHandler463(Wgdef n_server_DiscV5_wg;Wgdef n_server_dialsched_wg;Wgdef n_server_discmix_wg;Wgdef n_server_loopWG;Wgdef n_server_nodedb_lvl_closeW;Wgdef n_server_ntab_wg;Mutexdef n_accman_feed_mu;Mutexdef n_accman_feed_once_m;Mutexdef n_accman_lock;Mutexdef n_eventmux_mutex;Mutexdef n_http_mu;Mutexdef n_http_mux_mu;Mutexdef n_http_server_ErrorLog_mu;Mutexdef n_http_server_mu;Mutexdef n_http_server_nextProtoOnce_m;Mutexdef n_http_server_TLSConfig_mutex;Mutexdef n_inprocHandler_services_mu;Mutexdef n_ipc_mu;Mutexdef n_ipc_srv_services_mu;Mutexdef n_lock;Mutexdef n_server_DiscV5_closeOnce_m;Mutexdef n_server_DiscV5_localNode_mu;Mutexdef n_server_DiscV5_tab_mutex;Mutexdef n_server_DiscV5_trlock;Mutexdef n_server_discmix_mu;Mutexdef n_server_localnode_mu;Mutexdef n_server_lock;Mutexdef n_server_nodedb_lvl_compCommitLk;Mutexdef n_server_nodedb_lvl_memMu;Mutexdef n_server_nodedb_lvl_snapsMu;Mutexdef n_server_nodedb_runner_m;Mutexdef n_server_ntab_closeOnce_m;Mutexdef n_server_ntab_localNode_mu;Mutexdef n_server_ntab_tab_mutex;Mutexdef n_server_peerFeed_mu;Mutexdef n_server_peerFeed_once_m;Mutexdef n_startStopLock;Mutexdef n_ws_mu;Mutexdef n_ws_mux_mu;Mutexdef n_ws_server_ErrorLog_mu;Mutexdef n_ws_server_mu;Mutexdef n_ws_server_nextProtoOnce_m;Mutexdef n_ws_server_TLSConfig_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	n_lock.Lock!false;
		defer1: skip;
	n_lock.Unlock!false;
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

