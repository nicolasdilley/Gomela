
// https://github.com/moby/moby/blob/master/daemon/daemon_unix_test.go#L224
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
	chan child_TestParseNNPSecurityOptions2240 = [1] of {int};
	run TestParseNNPSecurityOptions224(child_TestParseNNPSecurityOptions2240)
stop_process:skip
}

proctype TestParseNNPSecurityOptions224(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef ctr_attachContext_mu;
	Mutexdef ctr_LogCopier_closeOnce_m;
	Wgdef ctr_LogCopier_copyJobs;
	Mutexdef ctr_StreamConfig_stderr_mu;
	Mutexdef ctr_StreamConfig_stdout_mu;
	Wgdef ctr_StreamConfig_wg;
	Mutexdef daemon_mdDB_statlock;
	Mutexdef daemon_mdDB_mmaplock;
	Mutexdef daemon_mdDB_metalock;
	Mutexdef daemon_mdDB_rwlock;
	Mutexdef daemon_mdDB_batch_start_m;
	Mutexdef daemon_mdDB_batchMu;
	Mutexdef daemon_mdDB_freelistLoad_m;
	Mutexdef daemon_attachableNetworkLock_mu;
	Mutexdef daemon_containerdCli_conn_firstResolveEvent_o_m;
	Mutexdef daemon_containerdCli_conn_balancerWrapper_mu;
	Mutexdef daemon_containerdCli_conn_balancerWrapper_done_o_m;
	Mutexdef daemon_containerdCli_conn_balancerWrapper_scBuffer_mu;
	Mutexdef daemon_containerdCli_conn_balancerWrapper_balancerMu;
	Mutexdef daemon_containerdCli_conn_resolverWrapper_pollingMu;
	Mutexdef daemon_containerdCli_conn_resolverWrapper_done_o_m;
	Mutexdef daemon_containerdCli_conn_resolverWrapper_resolverMu;
	Mutexdef daemon_containerdCli_conn_mu;
	Mutexdef daemon_containerdCli_conn_blockingpicker_mu;
	Mutexdef daemon_containerdCli_conn_csMgr_mu;
	Mutexdef daemon_containerdCli_connMu;
	Mutexdef daemon_linkIndex_mu;
	Mutexdef daemon_pluginManager_publisher_m;
	Mutexdef daemon_pluginManager_muGC;
	Mutexdef daemon_pluginManager_mu;
	Mutexdef daemon_pluginManager_config_AuthzMiddleware_mu;
	Mutexdef daemon_volumes_vs_db_statlock;
	Mutexdef daemon_volumes_vs_db_mmaplock;
	Mutexdef daemon_volumes_vs_db_metalock;
	Mutexdef daemon_volumes_vs_db_rwlock;
	Mutexdef daemon_volumes_vs_db_batch_start_m;
	Mutexdef daemon_volumes_vs_db_batchMu;
	Mutexdef daemon_volumes_vs_db_freelistLoad_m;
	Mutexdef daemon_volumes_vs_globalLock;
	Mutexdef daemon_volumes_vs_drivers_driverLock_mu;
	Mutexdef daemon_volumes_vs_drivers_mu;
	Mutexdef daemon_volumes_vs_locks_mu;
	Mutexdef daemon_EventsService_pub_m;
	Mutexdef daemon_EventsService_mu;
	Mutexdef daemon_statsCollector_m;
	Mutexdef daemon_imageService_eventsService_pub_m;
	Mutexdef daemon_imageService_eventsService_mu;
	run mutexMonitor(daemon_imageService_eventsService_mu);
	run mutexMonitor(daemon_imageService_eventsService_pub_m);
	run mutexMonitor(daemon_statsCollector_m);
	run mutexMonitor(daemon_EventsService_mu);
	run mutexMonitor(daemon_EventsService_pub_m);
	run mutexMonitor(daemon_volumes_vs_locks_mu);
	run mutexMonitor(daemon_volumes_vs_drivers_mu);
	run mutexMonitor(daemon_volumes_vs_drivers_driverLock_mu);
	run mutexMonitor(daemon_volumes_vs_globalLock);
	run mutexMonitor(daemon_volumes_vs_db_freelistLoad_m);
	run mutexMonitor(daemon_volumes_vs_db_batchMu);
	run mutexMonitor(daemon_volumes_vs_db_batch_start_m);
	run mutexMonitor(daemon_volumes_vs_db_rwlock);
	run mutexMonitor(daemon_volumes_vs_db_metalock);
	run mutexMonitor(daemon_volumes_vs_db_mmaplock);
	run mutexMonitor(daemon_volumes_vs_db_statlock);
	run mutexMonitor(daemon_pluginManager_config_AuthzMiddleware_mu);
	run mutexMonitor(daemon_pluginManager_mu);
	run mutexMonitor(daemon_pluginManager_muGC);
	run mutexMonitor(daemon_pluginManager_publisher_m);
	run mutexMonitor(daemon_linkIndex_mu);
	run mutexMonitor(daemon_containerdCli_connMu);
	run mutexMonitor(daemon_containerdCli_conn_csMgr_mu);
	run mutexMonitor(daemon_containerdCli_conn_blockingpicker_mu);
	run mutexMonitor(daemon_containerdCli_conn_mu);
	run mutexMonitor(daemon_containerdCli_conn_resolverWrapper_resolverMu);
	run mutexMonitor(daemon_containerdCli_conn_resolverWrapper_done_o_m);
	run mutexMonitor(daemon_containerdCli_conn_resolverWrapper_pollingMu);
	run mutexMonitor(daemon_containerdCli_conn_balancerWrapper_balancerMu);
	run mutexMonitor(daemon_containerdCli_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(daemon_containerdCli_conn_balancerWrapper_done_o_m);
	run mutexMonitor(daemon_containerdCli_conn_balancerWrapper_mu);
	run mutexMonitor(daemon_containerdCli_conn_firstResolveEvent_o_m);
	run mutexMonitor(daemon_attachableNetworkLock_mu);
	run mutexMonitor(daemon_mdDB_freelistLoad_m);
	run mutexMonitor(daemon_mdDB_batchMu);
	run mutexMonitor(daemon_mdDB_batch_start_m);
	run mutexMonitor(daemon_mdDB_rwlock);
	run mutexMonitor(daemon_mdDB_metalock);
	run mutexMonitor(daemon_mdDB_mmaplock);
	run mutexMonitor(daemon_mdDB_statlock);
	run wgMonitor(ctr_StreamConfig_wg);
	run mutexMonitor(ctr_StreamConfig_stdout_mu);
	run mutexMonitor(ctr_StreamConfig_stderr_mu);
	run wgMonitor(ctr_LogCopier_copyJobs);
	run mutexMonitor(ctr_LogCopier_closeOnce_m);
	run mutexMonitor(ctr_attachContext_mu);
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

