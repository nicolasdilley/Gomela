
// https://github.com/pingcap/tidb/blob/master/executor/show.go#L1472
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_createRegistry14720 = [1] of {int};
	run createRegistry1472(child_createRegistry14720)
stop_process:skip
}

proctype createRegistry1472(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef cli_client_mu;
	Mutexdef cli_client_resolverGroup_mu;
	Mutexdef cli_client_cfg_TLS_mutex;
	Mutexdef cli_client_conn_firstResolveEvent_o_m;
	Mutexdef cli_client_conn_balancerWrapper_mu;
	Mutexdef cli_client_conn_balancerWrapper_done_o_m;
	Mutexdef cli_client_conn_balancerWrapper_scBuffer_mu;
	Mutexdef cli_client_conn_balancerWrapper_balancerMu;
	Mutexdef cli_client_conn_resolverWrapper_pollingMu;
	Mutexdef cli_client_conn_resolverWrapper_done_o_m;
	Mutexdef cli_client_conn_resolverWrapper_resolverMu;
	Mutexdef cli_client_conn_mu;
	Mutexdef cli_client_conn_blockingpicker_mu;
	Mutexdef cli_client_conn_csMgr_mu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(cli_client_conn_csMgr_mu);
	run mutexMonitor(cli_client_conn_blockingpicker_mu);
	run mutexMonitor(cli_client_conn_mu);
	run mutexMonitor(cli_client_conn_resolverWrapper_resolverMu);
	run mutexMonitor(cli_client_conn_resolverWrapper_done_o_m);
	run mutexMonitor(cli_client_conn_resolverWrapper_pollingMu);
	run mutexMonitor(cli_client_conn_balancerWrapper_balancerMu);
	run mutexMonitor(cli_client_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(cli_client_conn_balancerWrapper_done_o_m);
	run mutexMonitor(cli_client_conn_balancerWrapper_mu);
	run mutexMonitor(cli_client_conn_firstResolveEvent_o_m);
	run mutexMonitor(cli_client_cfg_TLS_mutex);
	run mutexMonitor(cli_client_resolverGroup_mu);
	run mutexMonitor(cli_client_mu);
	

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

