
// https://github.com/grpc/grpc-go/blob/master/xds/internal/client/singleton.go#L137
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewWithConfigForTesting1370 = [1] of {int};
	run NewWithConfigForTesting137(child_NewWithConfigForTesting1370)
stop_process:skip
}

proctype NewWithConfigForTesting137(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef cl_lrsMu;
	Mutexdef cl_mu;
	Mutexdef cl_updateCh_mu;
	Mutexdef cl_cc_lceMu;
	Mutexdef cl_cc_firstResolveEvent_o_m;
	Mutexdef cl_cc_balancerWrapper_mu;
	Mutexdef cl_cc_balancerWrapper_done_o_m;
	Mutexdef cl_cc_balancerWrapper_scBuffer_mu;
	Mutexdef cl_cc_balancerWrapper_balancerMu;
	Mutexdef cl_cc_resolverWrapper_pollingMu;
	Mutexdef cl_cc_resolverWrapper_done_o_m;
	Mutexdef cl_cc_resolverWrapper_resolverMu;
	Mutexdef cl_cc_mu;
	Mutexdef cl_cc_safeConfigSelector_mu;
	Mutexdef cl_cc_blockingpicker_mu;
	Mutexdef cl_cc_csMgr_mu;
	Mutexdef cl_done_o_m;
	run mutexMonitor(cl_done_o_m);
	run mutexMonitor(cl_cc_csMgr_mu);
	run mutexMonitor(cl_cc_blockingpicker_mu);
	run mutexMonitor(cl_cc_safeConfigSelector_mu);
	run mutexMonitor(cl_cc_mu);
	run mutexMonitor(cl_cc_resolverWrapper_resolverMu);
	run mutexMonitor(cl_cc_resolverWrapper_done_o_m);
	run mutexMonitor(cl_cc_resolverWrapper_pollingMu);
	run mutexMonitor(cl_cc_balancerWrapper_balancerMu);
	run mutexMonitor(cl_cc_balancerWrapper_scBuffer_mu);
	run mutexMonitor(cl_cc_balancerWrapper_done_o_m);
	run mutexMonitor(cl_cc_balancerWrapper_mu);
	run mutexMonitor(cl_cc_firstResolveEvent_o_m);
	run mutexMonitor(cl_cc_lceMu);
	run mutexMonitor(cl_updateCh_mu);
	run mutexMonitor(cl_mu);
	run mutexMonitor(cl_lrsMu);
	

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

