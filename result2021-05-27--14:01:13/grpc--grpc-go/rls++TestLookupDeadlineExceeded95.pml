// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grpc/grpc-go/blob/ebd6aba6754d073a696e5727158cd0c917ce1019/balancer/rls/internal/client_test.go#L95
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLookupDeadlineExceeded950 = [1] of {int};
	run TestLookupDeadlineExceeded95(child_TestLookupDeadlineExceeded950);
	run receiver(child_TestLookupDeadlineExceeded950)
stop_process:skip
}

proctype TestLookupDeadlineExceeded95(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newRLSClient550 = [1] of {int};
	Mutexdef cc_lceMu;
	Mutexdef cc_balancerWrapper_mu;
	Mutexdef cc_balancerWrapper_balancerMu;
	Mutexdef cc_resolverWrapper_pollingMu;
	Mutexdef cc_resolverWrapper_resolverMu;
	Mutexdef cc_mu;
	Mutexdef cc_safeConfigSelector_mu;
	Mutexdef cc_blockingpicker_mu;
	Mutexdef cc_csMgr_mu;
	run mutexMonitor(cc_csMgr_mu);
	run mutexMonitor(cc_blockingpicker_mu);
	run mutexMonitor(cc_safeConfigSelector_mu);
	run mutexMonitor(cc_mu);
	run mutexMonitor(cc_resolverWrapper_resolverMu);
	run mutexMonitor(cc_resolverWrapper_pollingMu);
	run mutexMonitor(cc_balancerWrapper_balancerMu);
	run mutexMonitor(cc_balancerWrapper_mu);
	run mutexMonitor(cc_lceMu);
	run newRLSClient55(cc_balancerWrapper_balancerMu,cc_balancerWrapper_mu,cc_blockingpicker_mu,cc_csMgr_mu,cc_lceMu,cc_mu,cc_resolverWrapper_pollingMu,cc_resolverWrapper_resolverMu,cc_safeConfigSelector_mu,child_newRLSClient550);
	child_newRLSClient550?0;
		stop_process: skip;
		stop_process: skip;
	stop_process: skip;
	child!0
}
proctype newRLSClient55(Mutexdef cc_balancerWrapper_balancerMu;Mutexdef cc_balancerWrapper_mu;Mutexdef cc_blockingpicker_mu;Mutexdef cc_csMgr_mu;Mutexdef cc_lceMu;Mutexdef cc_mu;Mutexdef cc_resolverWrapper_pollingMu;Mutexdef cc_resolverWrapper_resolverMu;Mutexdef cc_safeConfigSelector_mu;chan child) {
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

