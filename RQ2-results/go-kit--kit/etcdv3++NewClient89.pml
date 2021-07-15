
// https://github.com/go-kit/kit/blob/master/sd/etcdv3/client.go#L89
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewClient890 = [1] of {int};
	run NewClient89(child_NewClient890)
stop_process:skip
}

proctype NewClient89(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef cli_mu;
	Mutexdef cli_resolverGroup_mu;
	Mutexdef cli_cfg_TLS_mutex;
	Mutexdef cli_conn_firstResolveEvent_o_m;
	Mutexdef cli_conn_balancerWrapper_mu;
	Mutexdef cli_conn_balancerWrapper_done_o_m;
	Mutexdef cli_conn_balancerWrapper_scBuffer_mu;
	Mutexdef cli_conn_balancerWrapper_balancerMu;
	Mutexdef cli_conn_resolverWrapper_pollingMu;
	Mutexdef cli_conn_resolverWrapper_done_o_m;
	Mutexdef cli_conn_resolverWrapper_resolverMu;
	Mutexdef cli_conn_mu;
	Mutexdef cli_conn_blockingpicker_mu;
	Mutexdef cli_conn_csMgr_mu;
	Mutexdef tlscfg_mutex;
	run mutexMonitor(tlscfg_mutex);
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run mutexMonitor(cli_conn_csMgr_mu);
	run mutexMonitor(cli_conn_blockingpicker_mu);
	run mutexMonitor(cli_conn_mu);
	run mutexMonitor(cli_conn_resolverWrapper_resolverMu);
	run mutexMonitor(cli_conn_resolverWrapper_done_o_m);
	run mutexMonitor(cli_conn_resolverWrapper_pollingMu);
	run mutexMonitor(cli_conn_balancerWrapper_balancerMu);
	run mutexMonitor(cli_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(cli_conn_balancerWrapper_done_o_m);
	run mutexMonitor(cli_conn_balancerWrapper_mu);
	run mutexMonitor(cli_conn_firstResolveEvent_o_m);
	run mutexMonitor(cli_cfg_TLS_mutex);
	run mutexMonitor(cli_resolverGroup_mu);
	run mutexMonitor(cli_mu);
	

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

