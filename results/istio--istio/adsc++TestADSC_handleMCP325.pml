// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob//pkg/adsc/adsc_test.go#L325
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
	chan child_TestADSC_handleMCP3250 = [1] of {int};
	run TestADSC_handleMCP325(child_TestADSC_handleMCP3250);
	run receiver(child_TestADSC_handleMCP3250)
stop_process:skip
}

proctype TestADSC_handleMCP325(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef adsc_Locality_state_atomicMessageInfo_initMu;
	Wgdef adsc_RecvWg;
	Mutexdef adsc_Registry_mutex;
	Mutexdef adsc_mutex;
	Mutexdef adsc_Metadata_state_atomicMessageInfo_initMu;
	Mutexdef adsc_conn_lceMu;
	Mutexdef adsc_conn_firstResolveEvent_o_m;
	Mutexdef adsc_conn_balancerWrapper_mu;
	Mutexdef adsc_conn_balancerWrapper_scBuffer_mu;
	Mutexdef adsc_conn_balancerWrapper_balancerMu;
	Mutexdef adsc_conn_resolverWrapper_pollingMu;
	Mutexdef adsc_conn_resolverWrapper_resolverMu;
	Mutexdef adsc_conn_mu;
	Mutexdef adsc_conn_safeConfigSelector_mu;
	Mutexdef adsc_conn_blockingpicker_mu;
	Mutexdef adsc_conn_csMgr_mu;
	int var_expected = -2; // opt var_expected
	int var_tt_expectedResources = -2; // opt var_tt_expectedResources
	int var_configs = -2; // opt var_configs
	int var_tests = -2; // opt var_tests
	run mutexMonitor(adsc_conn_csMgr_mu);
	run mutexMonitor(adsc_conn_blockingpicker_mu);
	run mutexMonitor(adsc_conn_safeConfigSelector_mu);
	run mutexMonitor(adsc_conn_mu);
	run mutexMonitor(adsc_conn_resolverWrapper_resolverMu);
	run mutexMonitor(adsc_conn_resolverWrapper_pollingMu);
	run mutexMonitor(adsc_conn_balancerWrapper_balancerMu);
	run mutexMonitor(adsc_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(adsc_conn_balancerWrapper_mu);
	run mutexMonitor(adsc_conn_firstResolveEvent_o_m);
	run mutexMonitor(adsc_conn_lceMu);
	run mutexMonitor(adsc_Metadata_state_atomicMessageInfo_initMu);
	run mutexMonitor(adsc_mutex);
	run mutexMonitor(adsc_Registry_mutex);
	run wgMonitor(adsc_RecvWg);
	run mutexMonitor(adsc_Locality_state_atomicMessageInfo_initMu);
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

