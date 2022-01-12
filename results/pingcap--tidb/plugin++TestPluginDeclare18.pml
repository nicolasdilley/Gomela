// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/pingcap/tidb/blob//plugin/helper_test.go#L18
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPluginDeclare180 = [1] of {int};
	run TestPluginDeclare18(child_TestPluginDeclare180);
	run receiver(child_TestPluginDeclare180)
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
	Mutexdef daemonExport_flushWatcher_etcd_conn_mu;
	chan child_DeclareSchemaManifest322 = [1] of {int};
	Mutexdef schemaExport_flushWatcher_etcd_mu;
	Mutexdef schemaExport_flushWatcher_etcd_resolverGroup_mu;
	Mutexdef schemaExport_flushWatcher_etcd_conn_mu;
	chan child_DeclareAuthenticationManifest271 = [1] of {int};
	Mutexdef authExport_flushWatcher_etcd_mu;
	Mutexdef authExport_flushWatcher_etcd_resolverGroup_mu;
	Mutexdef authExport_flushWatcher_etcd_conn_mu;
	chan child_DeclareAuditManifest220 = [1] of {int};
	Mutexdef auditExport_flushWatcher_etcd_mu;
	Mutexdef auditExport_flushWatcher_etcd_resolverGroup_mu;
	Mutexdef auditExport_flushWatcher_etcd_conn_mu;
	run mutexMonitor(auditExport_flushWatcher_etcd_conn_mu);
	run mutexMonitor(auditExport_flushWatcher_etcd_resolverGroup_mu);
	run mutexMonitor(auditExport_flushWatcher_etcd_mu);
	run DeclareAuditManifest22(auditExport_flushWatcher_etcd_conn_mu,auditExport_flushWatcher_etcd_mu,auditExport_flushWatcher_etcd_resolverGroup_mu,child_DeclareAuditManifest220);
	child_DeclareAuditManifest220?0;
	run mutexMonitor(authExport_flushWatcher_etcd_conn_mu);
	run mutexMonitor(authExport_flushWatcher_etcd_resolverGroup_mu);
	run mutexMonitor(authExport_flushWatcher_etcd_mu);
	run DeclareAuthenticationManifest27(authExport_flushWatcher_etcd_conn_mu,authExport_flushWatcher_etcd_mu,authExport_flushWatcher_etcd_resolverGroup_mu,child_DeclareAuthenticationManifest271);
	child_DeclareAuthenticationManifest271?0;
	run mutexMonitor(schemaExport_flushWatcher_etcd_conn_mu);
	run mutexMonitor(schemaExport_flushWatcher_etcd_resolverGroup_mu);
	run mutexMonitor(schemaExport_flushWatcher_etcd_mu);
	run DeclareSchemaManifest32(schemaExport_flushWatcher_etcd_conn_mu,schemaExport_flushWatcher_etcd_mu,schemaExport_flushWatcher_etcd_resolverGroup_mu,child_DeclareSchemaManifest322);
	child_DeclareSchemaManifest322?0;
	run mutexMonitor(daemonExport_flushWatcher_etcd_conn_mu);
	run mutexMonitor(daemonExport_flushWatcher_etcd_resolverGroup_mu);
	run mutexMonitor(daemonExport_flushWatcher_etcd_mu);
	run DeclareDaemonManifest37(daemonExport_flushWatcher_etcd_conn_mu,daemonExport_flushWatcher_etcd_mu,daemonExport_flushWatcher_etcd_resolverGroup_mu,child_DeclareDaemonManifest373);
	child_DeclareDaemonManifest373?0;
	stop_process: skip;
	child!0
}
proctype DeclareAuditManifest22(Mutexdef m_flushWatcher_etcd_conn_mu;Mutexdef m_flushWatcher_etcd_mu;Mutexdef m_flushWatcher_etcd_resolverGroup_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype DeclareAuthenticationManifest27(Mutexdef m_flushWatcher_etcd_conn_mu;Mutexdef m_flushWatcher_etcd_mu;Mutexdef m_flushWatcher_etcd_resolverGroup_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype DeclareSchemaManifest32(Mutexdef m_flushWatcher_etcd_conn_mu;Mutexdef m_flushWatcher_etcd_mu;Mutexdef m_flushWatcher_etcd_resolverGroup_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype DeclareDaemonManifest37(Mutexdef m_flushWatcher_etcd_conn_mu;Mutexdef m_flushWatcher_etcd_mu;Mutexdef m_flushWatcher_etcd_resolverGroup_mu;chan child) {
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

proctype receiver(chan c) {
c?0
}

