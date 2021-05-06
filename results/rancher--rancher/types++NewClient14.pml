
// https://github.com/rancher/rancher/blob/master/pkg/kontainer-engine/types/rpc_client.go#L14
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewClient140 = [1] of {int};
	run NewClient14(child_NewClient140)
stop_process:skip
}

proctype NewClient14(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewDriverClient12590 = [1] of {int};
	Mutexdef conn_firstResolveEvent_o_m;
	Mutexdef conn_balancerWrapper_mu;
	Mutexdef conn_balancerWrapper_done_o_m;
	Mutexdef conn_balancerWrapper_scBuffer_mu;
	Mutexdef conn_balancerWrapper_balancerMu;
	Mutexdef conn_resolverWrapper_pollingMu;
	Mutexdef conn_resolverWrapper_done_o_m;
	Mutexdef conn_resolverWrapper_resolverMu;
	Mutexdef conn_mu;
	Mutexdef conn_blockingpicker_mu;
	Mutexdef conn_csMgr_mu;
	run mutexMonitor(conn_csMgr_mu);
	run mutexMonitor(conn_blockingpicker_mu);
	run mutexMonitor(conn_mu);
	run mutexMonitor(conn_resolverWrapper_resolverMu);
	run mutexMonitor(conn_resolverWrapper_done_o_m);
	run mutexMonitor(conn_resolverWrapper_pollingMu);
	run mutexMonitor(conn_balancerWrapper_balancerMu);
	run mutexMonitor(conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(conn_balancerWrapper_done_o_m);
	run mutexMonitor(conn_balancerWrapper_mu);
	run mutexMonitor(conn_firstResolveEvent_o_m);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run NewDriverClient1259(conn_csMgr_mu,conn_blockingpicker_mu,conn_mu,conn_resolverWrapper_resolverMu,conn_resolverWrapper_done_o_m,conn_resolverWrapper_pollingMu,conn_balancerWrapper_balancerMu,conn_balancerWrapper_scBuffer_mu,conn_balancerWrapper_done_o_m,conn_balancerWrapper_mu,conn_firstResolveEvent_o_m,child_NewDriverClient12590);
	child_NewDriverClient12590?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewDriverClient1259(Mutexdef cc_csMgr_mu;Mutexdef cc_blockingpicker_mu;Mutexdef cc_mu;Mutexdef cc_resolverWrapper_resolverMu;Mutexdef cc_resolverWrapper_done_o_m;Mutexdef cc_resolverWrapper_pollingMu;Mutexdef cc_balancerWrapper_balancerMu;Mutexdef cc_balancerWrapper_scBuffer_mu;Mutexdef cc_balancerWrapper_done_o_m;Mutexdef cc_balancerWrapper_mu;Mutexdef cc_firstResolveEvent_o_m;chan child) {
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

