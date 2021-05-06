
// https://github.com/jaegertracing/jaeger/blob/master/cmd/query/app/server_test.go#L424
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_newGRPCClientWithTLS4240 = [1] of {int};
	run newGRPCClientWithTLS424(child_newGRPCClientWithTLS4240)
stop_process:skip
}

proctype newGRPCClientWithTLS424(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

