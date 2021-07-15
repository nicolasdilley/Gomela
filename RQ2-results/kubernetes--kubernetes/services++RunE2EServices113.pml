
// https://github.com/kubernetes/kubernetes/blob/master/test/e2e_node/services/services.go#L113
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
	chan child_RunE2EServices1130 = [1] of {int};
	run RunE2EServices113(child_RunE2EServices1130)
stop_process:skip
}

proctype RunE2EServices113(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_run460 = [1] of {int};
	Mutexdef e_etcdServer_V3Client_mu;
	Mutexdef e_etcdServer_V3Client_resolverGroup_mu;
	Mutexdef e_etcdServer_V3Client_cfg_TLS_mutex;
	Mutexdef e_etcdServer_V3Client_conn_firstResolveEvent_o_m;
	Mutexdef e_etcdServer_V3Client_conn_balancerWrapper_mu;
	Mutexdef e_etcdServer_V3Client_conn_balancerWrapper_done_o_m;
	Mutexdef e_etcdServer_V3Client_conn_balancerWrapper_scBuffer_mu;
	Mutexdef e_etcdServer_V3Client_conn_balancerWrapper_balancerMu;
	Mutexdef e_etcdServer_V3Client_conn_resolverWrapper_pollingMu;
	Mutexdef e_etcdServer_V3Client_conn_resolverWrapper_done_o_m;
	Mutexdef e_etcdServer_V3Client_conn_resolverWrapper_resolverMu;
	Mutexdef e_etcdServer_V3Client_conn_mu;
	Mutexdef e_etcdServer_V3Client_conn_blockingpicker_mu;
	Mutexdef e_etcdServer_V3Client_conn_csMgr_mu;
	Mutexdef e_etcdServer_v3Cluster_mu;
	Mutexdef e_etcdServer_s_leadTimeMu;
	Wgdef e_etcdServer_s_wg;
	Mutexdef e_etcdServer_s_wgMu;
	Mutexdef e_etcdServer_s_alarmStore_mu;
	Mutexdef e_etcdServer_s_bemu;
	Mutexdef e_etcdServer_s_leaderChangedMu;
	Mutexdef e_etcdServer_s_readMu;
	Mutexdef e_etcdServer_s_lgMu;
	Mutexdef e_etcdServer_s_r_td_mu;
	Mutexdef e_etcdServer_s_r_tickMu;
	run mutexMonitor(e_etcdServer_s_r_tickMu);
	run mutexMonitor(e_etcdServer_s_r_td_mu);
	run mutexMonitor(e_etcdServer_s_lgMu);
	run mutexMonitor(e_etcdServer_s_readMu);
	run mutexMonitor(e_etcdServer_s_leaderChangedMu);
	run mutexMonitor(e_etcdServer_s_bemu);
	run mutexMonitor(e_etcdServer_s_alarmStore_mu);
	run mutexMonitor(e_etcdServer_s_wgMu);
	run wgMonitor(e_etcdServer_s_wg);
	run mutexMonitor(e_etcdServer_s_leadTimeMu);
	run mutexMonitor(e_etcdServer_v3Cluster_mu);
	run mutexMonitor(e_etcdServer_V3Client_conn_csMgr_mu);
	run mutexMonitor(e_etcdServer_V3Client_conn_blockingpicker_mu);
	run mutexMonitor(e_etcdServer_V3Client_conn_mu);
	run mutexMonitor(e_etcdServer_V3Client_conn_resolverWrapper_resolverMu);
	run mutexMonitor(e_etcdServer_V3Client_conn_resolverWrapper_done_o_m);
	run mutexMonitor(e_etcdServer_V3Client_conn_resolverWrapper_pollingMu);
	run mutexMonitor(e_etcdServer_V3Client_conn_balancerWrapper_balancerMu);
	run mutexMonitor(e_etcdServer_V3Client_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(e_etcdServer_V3Client_conn_balancerWrapper_done_o_m);
	run mutexMonitor(e_etcdServer_V3Client_conn_balancerWrapper_mu);
	run mutexMonitor(e_etcdServer_V3Client_conn_firstResolveEvent_o_m);
	run mutexMonitor(e_etcdServer_V3Client_cfg_TLS_mutex);
	run mutexMonitor(e_etcdServer_V3Client_resolverGroup_mu);
	run mutexMonitor(e_etcdServer_V3Client_mu);
	run run46(e_etcdServer_s_wg,e_etcdServer_s_r_tickMu,e_etcdServer_s_r_td_mu,e_etcdServer_s_lgMu,e_etcdServer_s_readMu,e_etcdServer_s_leaderChangedMu,e_etcdServer_s_bemu,e_etcdServer_s_alarmStore_mu,e_etcdServer_s_wgMu,e_etcdServer_s_leadTimeMu,e_etcdServer_v3Cluster_mu,e_etcdServer_V3Client_conn_csMgr_mu,e_etcdServer_V3Client_conn_blockingpicker_mu,e_etcdServer_V3Client_conn_mu,e_etcdServer_V3Client_conn_resolverWrapper_resolverMu,e_etcdServer_V3Client_conn_resolverWrapper_done_o_m,e_etcdServer_V3Client_conn_resolverWrapper_pollingMu,e_etcdServer_V3Client_conn_balancerWrapper_balancerMu,e_etcdServer_V3Client_conn_balancerWrapper_scBuffer_mu,e_etcdServer_V3Client_conn_balancerWrapper_done_o_m,e_etcdServer_V3Client_conn_balancerWrapper_mu,e_etcdServer_V3Client_conn_firstResolveEvent_o_m,e_etcdServer_V3Client_cfg_TLS_mutex,e_etcdServer_V3Client_resolverGroup_mu,e_etcdServer_V3Client_mu,child_run460);
	child_run460?0;
	stop_process: skip;
	child!0
}
proctype run46(Wgdef es_etcdServer_s_wg;Mutexdef es_etcdServer_s_r_tickMu;Mutexdef es_etcdServer_s_r_td_mu;Mutexdef es_etcdServer_s_lgMu;Mutexdef es_etcdServer_s_readMu;Mutexdef es_etcdServer_s_leaderChangedMu;Mutexdef es_etcdServer_s_bemu;Mutexdef es_etcdServer_s_alarmStore_mu;Mutexdef es_etcdServer_s_wgMu;Mutexdef es_etcdServer_s_leadTimeMu;Mutexdef es_etcdServer_v3Cluster_mu;Mutexdef es_etcdServer_V3Client_conn_csMgr_mu;Mutexdef es_etcdServer_V3Client_conn_blockingpicker_mu;Mutexdef es_etcdServer_V3Client_conn_mu;Mutexdef es_etcdServer_V3Client_conn_resolverWrapper_resolverMu;Mutexdef es_etcdServer_V3Client_conn_resolverWrapper_done_o_m;Mutexdef es_etcdServer_V3Client_conn_resolverWrapper_pollingMu;Mutexdef es_etcdServer_V3Client_conn_balancerWrapper_balancerMu;Mutexdef es_etcdServer_V3Client_conn_balancerWrapper_scBuffer_mu;Mutexdef es_etcdServer_V3Client_conn_balancerWrapper_done_o_m;Mutexdef es_etcdServer_V3Client_conn_balancerWrapper_mu;Mutexdef es_etcdServer_V3Client_conn_firstResolveEvent_o_m;Mutexdef es_etcdServer_V3Client_cfg_TLS_mutex;Mutexdef es_etcdServer_V3Client_resolverGroup_mu;Mutexdef es_etcdServer_V3Client_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_stop760 = [1] of {int};
	chan child_start571 = [1] of {int};
	run start57(es_etcdServer_s_wg,es_etcdServer_s_r_tickMu,es_etcdServer_s_r_td_mu,es_etcdServer_s_lgMu,es_etcdServer_s_readMu,es_etcdServer_s_leaderChangedMu,es_etcdServer_s_bemu,es_etcdServer_s_alarmStore_mu,es_etcdServer_s_wgMu,es_etcdServer_s_leadTimeMu,es_etcdServer_v3Cluster_mu,es_etcdServer_V3Client_conn_csMgr_mu,es_etcdServer_V3Client_conn_blockingpicker_mu,es_etcdServer_V3Client_conn_mu,es_etcdServer_V3Client_conn_resolverWrapper_resolverMu,es_etcdServer_V3Client_conn_resolverWrapper_done_o_m,es_etcdServer_V3Client_conn_resolverWrapper_pollingMu,es_etcdServer_V3Client_conn_balancerWrapper_balancerMu,es_etcdServer_V3Client_conn_balancerWrapper_scBuffer_mu,es_etcdServer_V3Client_conn_balancerWrapper_done_o_m,es_etcdServer_V3Client_conn_balancerWrapper_mu,es_etcdServer_V3Client_conn_firstResolveEvent_o_m,es_etcdServer_V3Client_cfg_TLS_mutex,es_etcdServer_V3Client_resolverGroup_mu,es_etcdServer_V3Client_mu,child_start571);
	child_start571?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		run stop76(es_etcdServer_s_wg,es_etcdServer_s_r_tickMu,es_etcdServer_s_r_td_mu,es_etcdServer_s_lgMu,es_etcdServer_s_readMu,es_etcdServer_s_leaderChangedMu,es_etcdServer_s_bemu,es_etcdServer_s_alarmStore_mu,es_etcdServer_s_wgMu,es_etcdServer_s_leadTimeMu,es_etcdServer_v3Cluster_mu,es_etcdServer_V3Client_conn_csMgr_mu,es_etcdServer_V3Client_conn_blockingpicker_mu,es_etcdServer_V3Client_conn_mu,es_etcdServer_V3Client_conn_resolverWrapper_resolverMu,es_etcdServer_V3Client_conn_resolverWrapper_done_o_m,es_etcdServer_V3Client_conn_resolverWrapper_pollingMu,es_etcdServer_V3Client_conn_balancerWrapper_balancerMu,es_etcdServer_V3Client_conn_balancerWrapper_scBuffer_mu,es_etcdServer_V3Client_conn_balancerWrapper_done_o_m,es_etcdServer_V3Client_conn_balancerWrapper_mu,es_etcdServer_V3Client_conn_firstResolveEvent_o_m,es_etcdServer_V3Client_cfg_TLS_mutex,es_etcdServer_V3Client_resolverGroup_mu,es_etcdServer_V3Client_mu,child_stop760);
	child_stop760?0;
	child!0
}
proctype stop76(Wgdef es_etcdServer_s_wg;Mutexdef es_etcdServer_s_r_tickMu;Mutexdef es_etcdServer_s_r_td_mu;Mutexdef es_etcdServer_s_lgMu;Mutexdef es_etcdServer_s_readMu;Mutexdef es_etcdServer_s_leaderChangedMu;Mutexdef es_etcdServer_s_bemu;Mutexdef es_etcdServer_s_alarmStore_mu;Mutexdef es_etcdServer_s_wgMu;Mutexdef es_etcdServer_s_leadTimeMu;Mutexdef es_etcdServer_v3Cluster_mu;Mutexdef es_etcdServer_V3Client_conn_csMgr_mu;Mutexdef es_etcdServer_V3Client_conn_blockingpicker_mu;Mutexdef es_etcdServer_V3Client_conn_mu;Mutexdef es_etcdServer_V3Client_conn_resolverWrapper_resolverMu;Mutexdef es_etcdServer_V3Client_conn_resolverWrapper_done_o_m;Mutexdef es_etcdServer_V3Client_conn_resolverWrapper_pollingMu;Mutexdef es_etcdServer_V3Client_conn_balancerWrapper_balancerMu;Mutexdef es_etcdServer_V3Client_conn_balancerWrapper_scBuffer_mu;Mutexdef es_etcdServer_V3Client_conn_balancerWrapper_done_o_m;Mutexdef es_etcdServer_V3Client_conn_balancerWrapper_mu;Mutexdef es_etcdServer_V3Client_conn_firstResolveEvent_o_m;Mutexdef es_etcdServer_V3Client_cfg_TLS_mutex;Mutexdef es_etcdServer_V3Client_resolverGroup_mu;Mutexdef es_etcdServer_V3Client_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype start57(Wgdef es_etcdServer_s_wg;Mutexdef es_etcdServer_s_r_tickMu;Mutexdef es_etcdServer_s_r_td_mu;Mutexdef es_etcdServer_s_lgMu;Mutexdef es_etcdServer_s_readMu;Mutexdef es_etcdServer_s_leaderChangedMu;Mutexdef es_etcdServer_s_bemu;Mutexdef es_etcdServer_s_alarmStore_mu;Mutexdef es_etcdServer_s_wgMu;Mutexdef es_etcdServer_s_leadTimeMu;Mutexdef es_etcdServer_v3Cluster_mu;Mutexdef es_etcdServer_V3Client_conn_csMgr_mu;Mutexdef es_etcdServer_V3Client_conn_blockingpicker_mu;Mutexdef es_etcdServer_V3Client_conn_mu;Mutexdef es_etcdServer_V3Client_conn_resolverWrapper_resolverMu;Mutexdef es_etcdServer_V3Client_conn_resolverWrapper_done_o_m;Mutexdef es_etcdServer_V3Client_conn_resolverWrapper_pollingMu;Mutexdef es_etcdServer_V3Client_conn_balancerWrapper_balancerMu;Mutexdef es_etcdServer_V3Client_conn_balancerWrapper_scBuffer_mu;Mutexdef es_etcdServer_V3Client_conn_balancerWrapper_done_o_m;Mutexdef es_etcdServer_V3Client_conn_balancerWrapper_mu;Mutexdef es_etcdServer_V3Client_conn_firstResolveEvent_o_m;Mutexdef es_etcdServer_V3Client_cfg_TLS_mutex;Mutexdef es_etcdServer_V3Client_resolverGroup_mu;Mutexdef es_etcdServer_V3Client_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_startNamespaceController1273 = [1] of {int};
	chan child_startAPIServer1202 = [1] of {int};
	chan child_startEtcd1111 = [1] of {int};
	run startEtcd111(es_etcdServer_s_wg,es_etcdServer_s_r_tickMu,es_etcdServer_s_r_td_mu,es_etcdServer_s_lgMu,es_etcdServer_s_readMu,es_etcdServer_s_leaderChangedMu,es_etcdServer_s_bemu,es_etcdServer_s_alarmStore_mu,es_etcdServer_s_wgMu,es_etcdServer_s_leadTimeMu,es_etcdServer_v3Cluster_mu,es_etcdServer_V3Client_conn_csMgr_mu,es_etcdServer_V3Client_conn_blockingpicker_mu,es_etcdServer_V3Client_conn_mu,es_etcdServer_V3Client_conn_resolverWrapper_resolverMu,es_etcdServer_V3Client_conn_resolverWrapper_done_o_m,es_etcdServer_V3Client_conn_resolverWrapper_pollingMu,es_etcdServer_V3Client_conn_balancerWrapper_balancerMu,es_etcdServer_V3Client_conn_balancerWrapper_scBuffer_mu,es_etcdServer_V3Client_conn_balancerWrapper_done_o_m,es_etcdServer_V3Client_conn_balancerWrapper_mu,es_etcdServer_V3Client_conn_firstResolveEvent_o_m,es_etcdServer_V3Client_cfg_TLS_mutex,es_etcdServer_V3Client_resolverGroup_mu,es_etcdServer_V3Client_mu,child_startEtcd1111);
	child_startEtcd1111?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run startAPIServer120(es_etcdServer_s_wg,es_etcdServer_s_r_tickMu,es_etcdServer_s_r_td_mu,es_etcdServer_s_lgMu,es_etcdServer_s_readMu,es_etcdServer_s_leaderChangedMu,es_etcdServer_s_bemu,es_etcdServer_s_alarmStore_mu,es_etcdServer_s_wgMu,es_etcdServer_s_leadTimeMu,es_etcdServer_v3Cluster_mu,es_etcdServer_V3Client_conn_csMgr_mu,es_etcdServer_V3Client_conn_blockingpicker_mu,es_etcdServer_V3Client_conn_mu,es_etcdServer_V3Client_conn_resolverWrapper_resolverMu,es_etcdServer_V3Client_conn_resolverWrapper_done_o_m,es_etcdServer_V3Client_conn_resolverWrapper_pollingMu,es_etcdServer_V3Client_conn_balancerWrapper_balancerMu,es_etcdServer_V3Client_conn_balancerWrapper_scBuffer_mu,es_etcdServer_V3Client_conn_balancerWrapper_done_o_m,es_etcdServer_V3Client_conn_balancerWrapper_mu,es_etcdServer_V3Client_conn_firstResolveEvent_o_m,es_etcdServer_V3Client_cfg_TLS_mutex,es_etcdServer_V3Client_resolverGroup_mu,es_etcdServer_V3Client_mu,child_startAPIServer1202);
	child_startAPIServer1202?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run startNamespaceController127(es_etcdServer_s_wg,es_etcdServer_s_r_tickMu,es_etcdServer_s_r_td_mu,es_etcdServer_s_lgMu,es_etcdServer_s_readMu,es_etcdServer_s_leaderChangedMu,es_etcdServer_s_bemu,es_etcdServer_s_alarmStore_mu,es_etcdServer_s_wgMu,es_etcdServer_s_leadTimeMu,es_etcdServer_v3Cluster_mu,es_etcdServer_V3Client_conn_csMgr_mu,es_etcdServer_V3Client_conn_blockingpicker_mu,es_etcdServer_V3Client_conn_mu,es_etcdServer_V3Client_conn_resolverWrapper_resolverMu,es_etcdServer_V3Client_conn_resolverWrapper_done_o_m,es_etcdServer_V3Client_conn_resolverWrapper_pollingMu,es_etcdServer_V3Client_conn_balancerWrapper_balancerMu,es_etcdServer_V3Client_conn_balancerWrapper_scBuffer_mu,es_etcdServer_V3Client_conn_balancerWrapper_done_o_m,es_etcdServer_V3Client_conn_balancerWrapper_mu,es_etcdServer_V3Client_conn_firstResolveEvent_o_m,es_etcdServer_V3Client_cfg_TLS_mutex,es_etcdServer_V3Client_resolverGroup_mu,es_etcdServer_V3Client_mu,child_startNamespaceController1273);
	child_startNamespaceController1273?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype startEtcd111(Wgdef es_etcdServer_s_wg;Mutexdef es_etcdServer_s_r_tickMu;Mutexdef es_etcdServer_s_r_td_mu;Mutexdef es_etcdServer_s_lgMu;Mutexdef es_etcdServer_s_readMu;Mutexdef es_etcdServer_s_leaderChangedMu;Mutexdef es_etcdServer_s_bemu;Mutexdef es_etcdServer_s_alarmStore_mu;Mutexdef es_etcdServer_s_wgMu;Mutexdef es_etcdServer_s_leadTimeMu;Mutexdef es_etcdServer_v3Cluster_mu;Mutexdef es_etcdServer_V3Client_conn_csMgr_mu;Mutexdef es_etcdServer_V3Client_conn_blockingpicker_mu;Mutexdef es_etcdServer_V3Client_conn_mu;Mutexdef es_etcdServer_V3Client_conn_resolverWrapper_resolverMu;Mutexdef es_etcdServer_V3Client_conn_resolverWrapper_done_o_m;Mutexdef es_etcdServer_V3Client_conn_resolverWrapper_pollingMu;Mutexdef es_etcdServer_V3Client_conn_balancerWrapper_balancerMu;Mutexdef es_etcdServer_V3Client_conn_balancerWrapper_scBuffer_mu;Mutexdef es_etcdServer_V3Client_conn_balancerWrapper_done_o_m;Mutexdef es_etcdServer_V3Client_conn_balancerWrapper_mu;Mutexdef es_etcdServer_V3Client_conn_firstResolveEvent_o_m;Mutexdef es_etcdServer_V3Client_cfg_TLS_mutex;Mutexdef es_etcdServer_V3Client_resolverGroup_mu;Mutexdef es_etcdServer_V3Client_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef server_V3Client_mu;
	Mutexdef server_V3Client_resolverGroup_mu;
	Mutexdef server_V3Client_cfg_TLS_mutex;
	Mutexdef server_V3Client_conn_firstResolveEvent_o_m;
	Mutexdef server_V3Client_conn_balancerWrapper_mu;
	Mutexdef server_V3Client_conn_balancerWrapper_done_o_m;
	Mutexdef server_V3Client_conn_balancerWrapper_scBuffer_mu;
	Mutexdef server_V3Client_conn_balancerWrapper_balancerMu;
	Mutexdef server_V3Client_conn_resolverWrapper_pollingMu;
	Mutexdef server_V3Client_conn_resolverWrapper_done_o_m;
	Mutexdef server_V3Client_conn_resolverWrapper_resolverMu;
	Mutexdef server_V3Client_conn_mu;
	Mutexdef server_V3Client_conn_blockingpicker_mu;
	Mutexdef server_V3Client_conn_csMgr_mu;
	Mutexdef server_v3Cluster_mu;
	Mutexdef server_s_leadTimeMu;
	Wgdef server_s_wg;
	Mutexdef server_s_wgMu;
	Mutexdef server_s_alarmStore_mu;
	Mutexdef server_s_bemu;
	Mutexdef server_s_leaderChangedMu;
	Mutexdef server_s_readMu;
	Mutexdef server_s_lgMu;
	Mutexdef server_s_r_td_mu;
	Mutexdef server_s_r_tickMu;
	run mutexMonitor(server_s_r_tickMu);
	run mutexMonitor(server_s_r_td_mu);
	run mutexMonitor(server_s_lgMu);
	run mutexMonitor(server_s_readMu);
	run mutexMonitor(server_s_leaderChangedMu);
	run mutexMonitor(server_s_bemu);
	run mutexMonitor(server_s_alarmStore_mu);
	run mutexMonitor(server_s_wgMu);
	run wgMonitor(server_s_wg);
	run mutexMonitor(server_s_leadTimeMu);
	run mutexMonitor(server_v3Cluster_mu);
	run mutexMonitor(server_V3Client_conn_csMgr_mu);
	run mutexMonitor(server_V3Client_conn_blockingpicker_mu);
	run mutexMonitor(server_V3Client_conn_mu);
	run mutexMonitor(server_V3Client_conn_resolverWrapper_resolverMu);
	run mutexMonitor(server_V3Client_conn_resolverWrapper_done_o_m);
	run mutexMonitor(server_V3Client_conn_resolverWrapper_pollingMu);
	run mutexMonitor(server_V3Client_conn_balancerWrapper_balancerMu);
	run mutexMonitor(server_V3Client_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(server_V3Client_conn_balancerWrapper_done_o_m);
	run mutexMonitor(server_V3Client_conn_balancerWrapper_mu);
	run mutexMonitor(server_V3Client_conn_firstResolveEvent_o_m);
	run mutexMonitor(server_V3Client_cfg_TLS_mutex);
	run mutexMonitor(server_V3Client_resolverGroup_mu);
	run mutexMonitor(server_V3Client_mu);
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype startAPIServer120(Wgdef es_etcdServer_s_wg;Mutexdef es_etcdServer_s_r_tickMu;Mutexdef es_etcdServer_s_r_td_mu;Mutexdef es_etcdServer_s_lgMu;Mutexdef es_etcdServer_s_readMu;Mutexdef es_etcdServer_s_leaderChangedMu;Mutexdef es_etcdServer_s_bemu;Mutexdef es_etcdServer_s_alarmStore_mu;Mutexdef es_etcdServer_s_wgMu;Mutexdef es_etcdServer_s_leadTimeMu;Mutexdef es_etcdServer_v3Cluster_mu;Mutexdef es_etcdServer_V3Client_conn_csMgr_mu;Mutexdef es_etcdServer_V3Client_conn_blockingpicker_mu;Mutexdef es_etcdServer_V3Client_conn_mu;Mutexdef es_etcdServer_V3Client_conn_resolverWrapper_resolverMu;Mutexdef es_etcdServer_V3Client_conn_resolverWrapper_done_o_m;Mutexdef es_etcdServer_V3Client_conn_resolverWrapper_pollingMu;Mutexdef es_etcdServer_V3Client_conn_balancerWrapper_balancerMu;Mutexdef es_etcdServer_V3Client_conn_balancerWrapper_scBuffer_mu;Mutexdef es_etcdServer_V3Client_conn_balancerWrapper_done_o_m;Mutexdef es_etcdServer_V3Client_conn_balancerWrapper_mu;Mutexdef es_etcdServer_V3Client_conn_firstResolveEvent_o_m;Mutexdef es_etcdServer_V3Client_cfg_TLS_mutex;Mutexdef es_etcdServer_V3Client_resolverGroup_mu;Mutexdef es_etcdServer_V3Client_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype startNamespaceController127(Wgdef es_etcdServer_s_wg;Mutexdef es_etcdServer_s_r_tickMu;Mutexdef es_etcdServer_s_r_td_mu;Mutexdef es_etcdServer_s_lgMu;Mutexdef es_etcdServer_s_readMu;Mutexdef es_etcdServer_s_leaderChangedMu;Mutexdef es_etcdServer_s_bemu;Mutexdef es_etcdServer_s_alarmStore_mu;Mutexdef es_etcdServer_s_wgMu;Mutexdef es_etcdServer_s_leadTimeMu;Mutexdef es_etcdServer_v3Cluster_mu;Mutexdef es_etcdServer_V3Client_conn_csMgr_mu;Mutexdef es_etcdServer_V3Client_conn_blockingpicker_mu;Mutexdef es_etcdServer_V3Client_conn_mu;Mutexdef es_etcdServer_V3Client_conn_resolverWrapper_resolverMu;Mutexdef es_etcdServer_V3Client_conn_resolverWrapper_done_o_m;Mutexdef es_etcdServer_V3Client_conn_resolverWrapper_pollingMu;Mutexdef es_etcdServer_V3Client_conn_balancerWrapper_balancerMu;Mutexdef es_etcdServer_V3Client_conn_balancerWrapper_scBuffer_mu;Mutexdef es_etcdServer_V3Client_conn_balancerWrapper_done_o_m;Mutexdef es_etcdServer_V3Client_conn_balancerWrapper_mu;Mutexdef es_etcdServer_V3Client_conn_firstResolveEvent_o_m;Mutexdef es_etcdServer_V3Client_cfg_TLS_mutex;Mutexdef es_etcdServer_V3Client_resolverGroup_mu;Mutexdef es_etcdServer_V3Client_mu;chan child) {
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

