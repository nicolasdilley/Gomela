
// https://github.com/pingcap/tidb/blob/master/table/tables/tables.go#L1088
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
	chan child_writeSequenceUpdateValueBinlog10880 = [1] of {int};
	run writeSequenceUpdateValueBinlog1088(child_writeSequenceUpdateValueBinlog10880)
stop_process:skip
}

proctype writeSequenceUpdateValueBinlog1088(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef binlogCli_Security_mutex;
	Mutexdef binlogCli_EtcdRegistry_client_client_mu;
	Mutexdef binlogCli_EtcdRegistry_client_client_resolverGroup_mu;
	Mutexdef binlogCli_EtcdRegistry_client_client_cfg_TLS_mutex;
	Mutexdef binlogCli_EtcdRegistry_client_client_conn_firstResolveEvent_o_m;
	Mutexdef binlogCli_EtcdRegistry_client_client_conn_balancerWrapper_mu;
	Mutexdef binlogCli_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m;
	Mutexdef binlogCli_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu;
	Mutexdef binlogCli_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu;
	Mutexdef binlogCli_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu;
	Mutexdef binlogCli_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m;
	Mutexdef binlogCli_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu;
	Mutexdef binlogCli_EtcdRegistry_client_client_conn_mu;
	Mutexdef binlogCli_EtcdRegistry_client_client_conn_blockingpicker_mu;
	Mutexdef binlogCli_EtcdRegistry_client_client_conn_csMgr_mu;
	Wgdef binlogCli_wg;
	run wgMonitor(binlogCli_wg);
	run mutexMonitor(binlogCli_EtcdRegistry_client_client_conn_csMgr_mu);
	run mutexMonitor(binlogCli_EtcdRegistry_client_client_conn_blockingpicker_mu);
	run mutexMonitor(binlogCli_EtcdRegistry_client_client_conn_mu);
	run mutexMonitor(binlogCli_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu);
	run mutexMonitor(binlogCli_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m);
	run mutexMonitor(binlogCli_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu);
	run mutexMonitor(binlogCli_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu);
	run mutexMonitor(binlogCli_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(binlogCli_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m);
	run mutexMonitor(binlogCli_EtcdRegistry_client_client_conn_balancerWrapper_mu);
	run mutexMonitor(binlogCli_EtcdRegistry_client_client_conn_firstResolveEvent_o_m);
	run mutexMonitor(binlogCli_EtcdRegistry_client_client_cfg_TLS_mutex);
	run mutexMonitor(binlogCli_EtcdRegistry_client_client_resolverGroup_mu);
	run mutexMonitor(binlogCli_EtcdRegistry_client_client_mu);
	run mutexMonitor(binlogCli_Security_mutex);
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

