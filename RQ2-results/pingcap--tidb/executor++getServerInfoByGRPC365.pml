
// https://github.com/pingcap/tidb/blob/master/executor/memtable_reader.go#L365
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_getServerInfoByGRPC3650 = [1] of {int};
	run getServerInfoByGRPC365(child_getServerInfoByGRPC3650)
stop_process:skip
}

proctype getServerInfoByGRPC365(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close1640 = [1] of {int};
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
	Mutexdef tlsConfig_mutex;
	

	if
	:: true -> 
		run mutexMonitor(tlsConfig_mutex);
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		run Close164(conn_csMgr_mu,conn_blockingpicker_mu,conn_mu,conn_resolverWrapper_resolverMu,conn_resolverWrapper_done_o_m,conn_resolverWrapper_pollingMu,conn_balancerWrapper_balancerMu,conn_balancerWrapper_scBuffer_mu,conn_balancerWrapper_done_o_m,conn_balancerWrapper_mu,conn_firstResolveEvent_o_m,child_Close1640);
	child_Close1640?0;
	child!0
}
proctype Close164(Mutexdef a_csMgr_mu;Mutexdef a_blockingpicker_mu;Mutexdef a_mu;Mutexdef a_resolverWrapper_resolverMu;Mutexdef a_resolverWrapper_done_o_m;Mutexdef a_resolverWrapper_pollingMu;Mutexdef a_balancerWrapper_balancerMu;Mutexdef a_balancerWrapper_scBuffer_mu;Mutexdef a_balancerWrapper_done_o_m;Mutexdef a_balancerWrapper_mu;Mutexdef a_firstResolveEvent_o_m;chan child) {
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

