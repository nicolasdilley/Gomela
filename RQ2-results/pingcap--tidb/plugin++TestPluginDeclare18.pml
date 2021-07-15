
// https://github.com/pingcap/tidb/blob/master/plugin/helper_test.go#L18
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPluginDeclare180 = [1] of {int};
	run TestPluginDeclare18(child_TestPluginDeclare180)
stop_process:skip
}

proctype TestPluginDeclare18(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DeclareDaemonManifest373 = [1] of {int};
	Mutexdef daemonExport_flushWatcher_etcd_mu;
	Mutexdef daemonExport_flushWatcher_etcd_resolverGroup_mu;
	Mutexdef daemonExport_flushWatcher_etcd_cfg_TLS_mutex;
	Mutexdef daemonExport_flushWatcher_etcd_conn_firstResolveEvent_o_m;
	Mutexdef daemonExport_flushWatcher_etcd_conn_balancerWrapper_mu;
	Mutexdef daemonExport_flushWatcher_etcd_conn_balancerWrapper_done_o_m;
	Mutexdef daemonExport_flushWatcher_etcd_conn_balancerWrapper_scBuffer_mu;
	Mutexdef daemonExport_flushWatcher_etcd_conn_balancerWrapper_balancerMu;
	Mutexdef daemonExport_flushWatcher_etcd_conn_resolverWrapper_pollingMu;
	Mutexdef daemonExport_flushWatcher_etcd_conn_resolverWrapper_done_o_m;
	Mutexdef daemonExport_flushWatcher_etcd_conn_resolverWrapper_resolverMu;
	Mutexdef daemonExport_flushWatcher_etcd_conn_mu;
	Mutexdef daemonExport_flushWatcher_etcd_conn_blockingpicker_mu;
	Mutexdef daemonExport_flushWatcher_etcd_conn_csMgr_mu;
	chan child_DeclareSchemaManifest322 = [1] of {int};
	Mutexdef schemaExport_flushWatcher_etcd_mu;
	Mutexdef schemaExport_flushWatcher_etcd_resolverGroup_mu;
	Mutexdef schemaExport_flushWatcher_etcd_cfg_TLS_mutex;
	Mutexdef schemaExport_flushWatcher_etcd_conn_firstResolveEvent_o_m;
	Mutexdef schemaExport_flushWatcher_etcd_conn_balancerWrapper_mu;
	Mutexdef schemaExport_flushWatcher_etcd_conn_balancerWrapper_done_o_m;
	Mutexdef schemaExport_flushWatcher_etcd_conn_balancerWrapper_scBuffer_mu;
	Mutexdef schemaExport_flushWatcher_etcd_conn_balancerWrapper_balancerMu;
	Mutexdef schemaExport_flushWatcher_etcd_conn_resolverWrapper_pollingMu;
	Mutexdef schemaExport_flushWatcher_etcd_conn_resolverWrapper_done_o_m;
	Mutexdef schemaExport_flushWatcher_etcd_conn_resolverWrapper_resolverMu;
	Mutexdef schemaExport_flushWatcher_etcd_conn_mu;
	Mutexdef schemaExport_flushWatcher_etcd_conn_blockingpicker_mu;
	Mutexdef schemaExport_flushWatcher_etcd_conn_csMgr_mu;
	chan child_DeclareAuthenticationManifest271 = [1] of {int};
	Mutexdef authExport_flushWatcher_etcd_mu;
	Mutexdef authExport_flushWatcher_etcd_resolverGroup_mu;
	Mutexdef authExport_flushWatcher_etcd_cfg_TLS_mutex;
	Mutexdef authExport_flushWatcher_etcd_conn_firstResolveEvent_o_m;
	Mutexdef authExport_flushWatcher_etcd_conn_balancerWrapper_mu;
	Mutexdef authExport_flushWatcher_etcd_conn_balancerWrapper_done_o_m;
	Mutexdef authExport_flushWatcher_etcd_conn_balancerWrapper_scBuffer_mu;
	Mutexdef authExport_flushWatcher_etcd_conn_balancerWrapper_balancerMu;
	Mutexdef authExport_flushWatcher_etcd_conn_resolverWrapper_pollingMu;
	Mutexdef authExport_flushWatcher_etcd_conn_resolverWrapper_done_o_m;
	Mutexdef authExport_flushWatcher_etcd_conn_resolverWrapper_resolverMu;
	Mutexdef authExport_flushWatcher_etcd_conn_mu;
	Mutexdef authExport_flushWatcher_etcd_conn_blockingpicker_mu;
	Mutexdef authExport_flushWatcher_etcd_conn_csMgr_mu;
	chan child_DeclareAuditManifest220 = [1] of {int};
	Mutexdef auditExport_flushWatcher_etcd_mu;
	Mutexdef auditExport_flushWatcher_etcd_resolverGroup_mu;
	Mutexdef auditExport_flushWatcher_etcd_cfg_TLS_mutex;
	Mutexdef auditExport_flushWatcher_etcd_conn_firstResolveEvent_o_m;
	Mutexdef auditExport_flushWatcher_etcd_conn_balancerWrapper_mu;
	Mutexdef auditExport_flushWatcher_etcd_conn_balancerWrapper_done_o_m;
	Mutexdef auditExport_flushWatcher_etcd_conn_balancerWrapper_scBuffer_mu;
	Mutexdef auditExport_flushWatcher_etcd_conn_balancerWrapper_balancerMu;
	Mutexdef auditExport_flushWatcher_etcd_conn_resolverWrapper_pollingMu;
	Mutexdef auditExport_flushWatcher_etcd_conn_resolverWrapper_done_o_m;
	Mutexdef auditExport_flushWatcher_etcd_conn_resolverWrapper_resolverMu;
	Mutexdef auditExport_flushWatcher_etcd_conn_mu;
	Mutexdef auditExport_flushWatcher_etcd_conn_blockingpicker_mu;
	Mutexdef auditExport_flushWatcher_etcd_conn_csMgr_mu;
	run mutexMonitor(auditExport_flushWatcher_etcd_conn_csMgr_mu);
	run mutexMonitor(auditExport_flushWatcher_etcd_conn_blockingpicker_mu);
	run mutexMonitor(auditExport_flushWatcher_etcd_conn_mu);
	run mutexMonitor(auditExport_flushWatcher_etcd_conn_resolverWrapper_resolverMu);
	run mutexMonitor(auditExport_flushWatcher_etcd_conn_resolverWrapper_done_o_m);
	run mutexMonitor(auditExport_flushWatcher_etcd_conn_resolverWrapper_pollingMu);
	run mutexMonitor(auditExport_flushWatcher_etcd_conn_balancerWrapper_balancerMu);
	run mutexMonitor(auditExport_flushWatcher_etcd_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(auditExport_flushWatcher_etcd_conn_balancerWrapper_done_o_m);
	run mutexMonitor(auditExport_flushWatcher_etcd_conn_balancerWrapper_mu);
	run mutexMonitor(auditExport_flushWatcher_etcd_conn_firstResolveEvent_o_m);
	run mutexMonitor(auditExport_flushWatcher_etcd_cfg_TLS_mutex);
	run mutexMonitor(auditExport_flushWatcher_etcd_resolverGroup_mu);
	run mutexMonitor(auditExport_flushWatcher_etcd_mu);
	run DeclareAuditManifest22(auditExport_flushWatcher_etcd_conn_csMgr_mu,auditExport_flushWatcher_etcd_conn_blockingpicker_mu,auditExport_flushWatcher_etcd_conn_mu,auditExport_flushWatcher_etcd_conn_resolverWrapper_resolverMu,auditExport_flushWatcher_etcd_conn_resolverWrapper_done_o_m,auditExport_flushWatcher_etcd_conn_resolverWrapper_pollingMu,auditExport_flushWatcher_etcd_conn_balancerWrapper_balancerMu,auditExport_flushWatcher_etcd_conn_balancerWrapper_scBuffer_mu,auditExport_flushWatcher_etcd_conn_balancerWrapper_done_o_m,auditExport_flushWatcher_etcd_conn_balancerWrapper_mu,auditExport_flushWatcher_etcd_conn_firstResolveEvent_o_m,auditExport_flushWatcher_etcd_cfg_TLS_mutex,auditExport_flushWatcher_etcd_resolverGroup_mu,auditExport_flushWatcher_etcd_mu,child_DeclareAuditManifest220);
	child_DeclareAuditManifest220?0;
	run mutexMonitor(authExport_flushWatcher_etcd_conn_csMgr_mu);
	run mutexMonitor(authExport_flushWatcher_etcd_conn_blockingpicker_mu);
	run mutexMonitor(authExport_flushWatcher_etcd_conn_mu);
	run mutexMonitor(authExport_flushWatcher_etcd_conn_resolverWrapper_resolverMu);
	run mutexMonitor(authExport_flushWatcher_etcd_conn_resolverWrapper_done_o_m);
	run mutexMonitor(authExport_flushWatcher_etcd_conn_resolverWrapper_pollingMu);
	run mutexMonitor(authExport_flushWatcher_etcd_conn_balancerWrapper_balancerMu);
	run mutexMonitor(authExport_flushWatcher_etcd_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(authExport_flushWatcher_etcd_conn_balancerWrapper_done_o_m);
	run mutexMonitor(authExport_flushWatcher_etcd_conn_balancerWrapper_mu);
	run mutexMonitor(authExport_flushWatcher_etcd_conn_firstResolveEvent_o_m);
	run mutexMonitor(authExport_flushWatcher_etcd_cfg_TLS_mutex);
	run mutexMonitor(authExport_flushWatcher_etcd_resolverGroup_mu);
	run mutexMonitor(authExport_flushWatcher_etcd_mu);
	run DeclareAuthenticationManifest27(authExport_flushWatcher_etcd_conn_csMgr_mu,authExport_flushWatcher_etcd_conn_blockingpicker_mu,authExport_flushWatcher_etcd_conn_mu,authExport_flushWatcher_etcd_conn_resolverWrapper_resolverMu,authExport_flushWatcher_etcd_conn_resolverWrapper_done_o_m,authExport_flushWatcher_etcd_conn_resolverWrapper_pollingMu,authExport_flushWatcher_etcd_conn_balancerWrapper_balancerMu,authExport_flushWatcher_etcd_conn_balancerWrapper_scBuffer_mu,authExport_flushWatcher_etcd_conn_balancerWrapper_done_o_m,authExport_flushWatcher_etcd_conn_balancerWrapper_mu,authExport_flushWatcher_etcd_conn_firstResolveEvent_o_m,authExport_flushWatcher_etcd_cfg_TLS_mutex,authExport_flushWatcher_etcd_resolverGroup_mu,authExport_flushWatcher_etcd_mu,child_DeclareAuthenticationManifest271);
	child_DeclareAuthenticationManifest271?0;
	run mutexMonitor(schemaExport_flushWatcher_etcd_conn_csMgr_mu);
	run mutexMonitor(schemaExport_flushWatcher_etcd_conn_blockingpicker_mu);
	run mutexMonitor(schemaExport_flushWatcher_etcd_conn_mu);
	run mutexMonitor(schemaExport_flushWatcher_etcd_conn_resolverWrapper_resolverMu);
	run mutexMonitor(schemaExport_flushWatcher_etcd_conn_resolverWrapper_done_o_m);
	run mutexMonitor(schemaExport_flushWatcher_etcd_conn_resolverWrapper_pollingMu);
	run mutexMonitor(schemaExport_flushWatcher_etcd_conn_balancerWrapper_balancerMu);
	run mutexMonitor(schemaExport_flushWatcher_etcd_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(schemaExport_flushWatcher_etcd_conn_balancerWrapper_done_o_m);
	run mutexMonitor(schemaExport_flushWatcher_etcd_conn_balancerWrapper_mu);
	run mutexMonitor(schemaExport_flushWatcher_etcd_conn_firstResolveEvent_o_m);
	run mutexMonitor(schemaExport_flushWatcher_etcd_cfg_TLS_mutex);
	run mutexMonitor(schemaExport_flushWatcher_etcd_resolverGroup_mu);
	run mutexMonitor(schemaExport_flushWatcher_etcd_mu);
	run DeclareSchemaManifest32(schemaExport_flushWatcher_etcd_conn_csMgr_mu,schemaExport_flushWatcher_etcd_conn_blockingpicker_mu,schemaExport_flushWatcher_etcd_conn_mu,schemaExport_flushWatcher_etcd_conn_resolverWrapper_resolverMu,schemaExport_flushWatcher_etcd_conn_resolverWrapper_done_o_m,schemaExport_flushWatcher_etcd_conn_resolverWrapper_pollingMu,schemaExport_flushWatcher_etcd_conn_balancerWrapper_balancerMu,schemaExport_flushWatcher_etcd_conn_balancerWrapper_scBuffer_mu,schemaExport_flushWatcher_etcd_conn_balancerWrapper_done_o_m,schemaExport_flushWatcher_etcd_conn_balancerWrapper_mu,schemaExport_flushWatcher_etcd_conn_firstResolveEvent_o_m,schemaExport_flushWatcher_etcd_cfg_TLS_mutex,schemaExport_flushWatcher_etcd_resolverGroup_mu,schemaExport_flushWatcher_etcd_mu,child_DeclareSchemaManifest322);
	child_DeclareSchemaManifest322?0;
	run mutexMonitor(daemonExport_flushWatcher_etcd_conn_csMgr_mu);
	run mutexMonitor(daemonExport_flushWatcher_etcd_conn_blockingpicker_mu);
	run mutexMonitor(daemonExport_flushWatcher_etcd_conn_mu);
	run mutexMonitor(daemonExport_flushWatcher_etcd_conn_resolverWrapper_resolverMu);
	run mutexMonitor(daemonExport_flushWatcher_etcd_conn_resolverWrapper_done_o_m);
	run mutexMonitor(daemonExport_flushWatcher_etcd_conn_resolverWrapper_pollingMu);
	run mutexMonitor(daemonExport_flushWatcher_etcd_conn_balancerWrapper_balancerMu);
	run mutexMonitor(daemonExport_flushWatcher_etcd_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(daemonExport_flushWatcher_etcd_conn_balancerWrapper_done_o_m);
	run mutexMonitor(daemonExport_flushWatcher_etcd_conn_balancerWrapper_mu);
	run mutexMonitor(daemonExport_flushWatcher_etcd_conn_firstResolveEvent_o_m);
	run mutexMonitor(daemonExport_flushWatcher_etcd_cfg_TLS_mutex);
	run mutexMonitor(daemonExport_flushWatcher_etcd_resolverGroup_mu);
	run mutexMonitor(daemonExport_flushWatcher_etcd_mu);
	run DeclareDaemonManifest37(daemonExport_flushWatcher_etcd_conn_csMgr_mu,daemonExport_flushWatcher_etcd_conn_blockingpicker_mu,daemonExport_flushWatcher_etcd_conn_mu,daemonExport_flushWatcher_etcd_conn_resolverWrapper_resolverMu,daemonExport_flushWatcher_etcd_conn_resolverWrapper_done_o_m,daemonExport_flushWatcher_etcd_conn_resolverWrapper_pollingMu,daemonExport_flushWatcher_etcd_conn_balancerWrapper_balancerMu,daemonExport_flushWatcher_etcd_conn_balancerWrapper_scBuffer_mu,daemonExport_flushWatcher_etcd_conn_balancerWrapper_done_o_m,daemonExport_flushWatcher_etcd_conn_balancerWrapper_mu,daemonExport_flushWatcher_etcd_conn_firstResolveEvent_o_m,daemonExport_flushWatcher_etcd_cfg_TLS_mutex,daemonExport_flushWatcher_etcd_resolverGroup_mu,daemonExport_flushWatcher_etcd_mu,child_DeclareDaemonManifest373);
	child_DeclareDaemonManifest373?0;
	stop_process: skip;
	child!0
}
proctype DeclareAuditManifest22(Mutexdef m_flushWatcher_etcd_conn_csMgr_mu;Mutexdef m_flushWatcher_etcd_conn_blockingpicker_mu;Mutexdef m_flushWatcher_etcd_conn_mu;Mutexdef m_flushWatcher_etcd_conn_resolverWrapper_resolverMu;Mutexdef m_flushWatcher_etcd_conn_resolverWrapper_done_o_m;Mutexdef m_flushWatcher_etcd_conn_resolverWrapper_pollingMu;Mutexdef m_flushWatcher_etcd_conn_balancerWrapper_balancerMu;Mutexdef m_flushWatcher_etcd_conn_balancerWrapper_scBuffer_mu;Mutexdef m_flushWatcher_etcd_conn_balancerWrapper_done_o_m;Mutexdef m_flushWatcher_etcd_conn_balancerWrapper_mu;Mutexdef m_flushWatcher_etcd_conn_firstResolveEvent_o_m;Mutexdef m_flushWatcher_etcd_cfg_TLS_mutex;Mutexdef m_flushWatcher_etcd_resolverGroup_mu;Mutexdef m_flushWatcher_etcd_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype DeclareAuthenticationManifest27(Mutexdef m_flushWatcher_etcd_conn_csMgr_mu;Mutexdef m_flushWatcher_etcd_conn_blockingpicker_mu;Mutexdef m_flushWatcher_etcd_conn_mu;Mutexdef m_flushWatcher_etcd_conn_resolverWrapper_resolverMu;Mutexdef m_flushWatcher_etcd_conn_resolverWrapper_done_o_m;Mutexdef m_flushWatcher_etcd_conn_resolverWrapper_pollingMu;Mutexdef m_flushWatcher_etcd_conn_balancerWrapper_balancerMu;Mutexdef m_flushWatcher_etcd_conn_balancerWrapper_scBuffer_mu;Mutexdef m_flushWatcher_etcd_conn_balancerWrapper_done_o_m;Mutexdef m_flushWatcher_etcd_conn_balancerWrapper_mu;Mutexdef m_flushWatcher_etcd_conn_firstResolveEvent_o_m;Mutexdef m_flushWatcher_etcd_cfg_TLS_mutex;Mutexdef m_flushWatcher_etcd_resolverGroup_mu;Mutexdef m_flushWatcher_etcd_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype DeclareSchemaManifest32(Mutexdef m_flushWatcher_etcd_conn_csMgr_mu;Mutexdef m_flushWatcher_etcd_conn_blockingpicker_mu;Mutexdef m_flushWatcher_etcd_conn_mu;Mutexdef m_flushWatcher_etcd_conn_resolverWrapper_resolverMu;Mutexdef m_flushWatcher_etcd_conn_resolverWrapper_done_o_m;Mutexdef m_flushWatcher_etcd_conn_resolverWrapper_pollingMu;Mutexdef m_flushWatcher_etcd_conn_balancerWrapper_balancerMu;Mutexdef m_flushWatcher_etcd_conn_balancerWrapper_scBuffer_mu;Mutexdef m_flushWatcher_etcd_conn_balancerWrapper_done_o_m;Mutexdef m_flushWatcher_etcd_conn_balancerWrapper_mu;Mutexdef m_flushWatcher_etcd_conn_firstResolveEvent_o_m;Mutexdef m_flushWatcher_etcd_cfg_TLS_mutex;Mutexdef m_flushWatcher_etcd_resolverGroup_mu;Mutexdef m_flushWatcher_etcd_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype DeclareDaemonManifest37(Mutexdef m_flushWatcher_etcd_conn_csMgr_mu;Mutexdef m_flushWatcher_etcd_conn_blockingpicker_mu;Mutexdef m_flushWatcher_etcd_conn_mu;Mutexdef m_flushWatcher_etcd_conn_resolverWrapper_resolverMu;Mutexdef m_flushWatcher_etcd_conn_resolverWrapper_done_o_m;Mutexdef m_flushWatcher_etcd_conn_resolverWrapper_pollingMu;Mutexdef m_flushWatcher_etcd_conn_balancerWrapper_balancerMu;Mutexdef m_flushWatcher_etcd_conn_balancerWrapper_scBuffer_mu;Mutexdef m_flushWatcher_etcd_conn_balancerWrapper_done_o_m;Mutexdef m_flushWatcher_etcd_conn_balancerWrapper_mu;Mutexdef m_flushWatcher_etcd_conn_firstResolveEvent_o_m;Mutexdef m_flushWatcher_etcd_cfg_TLS_mutex;Mutexdef m_flushWatcher_etcd_resolverGroup_mu;Mutexdef m_flushWatcher_etcd_mu;chan child) {
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

