// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//zrpc/internal/clientinterceptors/timeoutinterceptor_test.go#L31
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
	chan child_TestTimeoutInterceptor_timeout310 = [1] of {int};
	run TestTimeoutInterceptor_timeout31(child_TestTimeoutInterceptor_timeout310);
	run receiver(child_TestTimeoutInterceptor_timeout310)
stop_process:skip
}

proctype TestTimeoutInterceptor_timeout31(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef cc_lceMu;
	Mutexdef cc_firstResolveEvent_o_m;
	Mutexdef cc_balancerWrapper_mu;
	Mutexdef cc_balancerWrapper_done_o_m;
	Mutexdef cc_balancerWrapper_closed_o_m;
	Mutexdef cc_balancerWrapper_updateCh_mu;
	Mutexdef cc_balancerWrapper_balancerMu;
	Mutexdef cc_resolverWrapper_incomingMu;
	Mutexdef cc_resolverWrapper_done_o_m;
	Mutexdef cc_resolverWrapper_resolverMu;
	Mutexdef cc_mu;
	Mutexdef cc_safeConfigSelector_mu;
	Mutexdef cc_blockingpicker_mu;
	Mutexdef cc_csMgr_mu;
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!1;
	run mutexMonitor(cc_csMgr_mu);
	run mutexMonitor(cc_blockingpicker_mu);
	run mutexMonitor(cc_safeConfigSelector_mu);
	run mutexMonitor(cc_mu);
	run mutexMonitor(cc_resolverWrapper_resolverMu);
	run mutexMonitor(cc_resolverWrapper_done_o_m);
	run mutexMonitor(cc_resolverWrapper_incomingMu);
	run mutexMonitor(cc_balancerWrapper_balancerMu);
	run mutexMonitor(cc_balancerWrapper_updateCh_mu);
	run mutexMonitor(cc_balancerWrapper_closed_o_m);
	run mutexMonitor(cc_balancerWrapper_done_o_m);
	run mutexMonitor(cc_balancerWrapper_mu);
	run mutexMonitor(cc_firstResolveEvent_o_m);
	run mutexMonitor(cc_lceMu);
	wg.wait?0;
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

proctype receiver(chan c) {
c?0
}

