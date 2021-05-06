
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/cm/devicemanager/endpoint.go#L60
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_newEndpointImpl600 = [1] of {int};
	run newEndpointImpl60(child_newEndpointImpl600)
stop_process:skip
}

proctype newEndpointImpl60(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef c_firstResolveEvent_o_m;
	Mutexdef c_balancerWrapper_mu;
	Mutexdef c_balancerWrapper_done_o_m;
	Mutexdef c_balancerWrapper_scBuffer_mu;
	Mutexdef c_balancerWrapper_balancerMu;
	Mutexdef c_resolverWrapper_pollingMu;
	Mutexdef c_resolverWrapper_done_o_m;
	Mutexdef c_resolverWrapper_resolverMu;
	Mutexdef c_mu;
	Mutexdef c_blockingpicker_mu;
	Mutexdef c_csMgr_mu;
	run mutexMonitor(c_csMgr_mu);
	run mutexMonitor(c_blockingpicker_mu);
	run mutexMonitor(c_mu);
	run mutexMonitor(c_resolverWrapper_resolverMu);
	run mutexMonitor(c_resolverWrapper_done_o_m);
	run mutexMonitor(c_resolverWrapper_pollingMu);
	run mutexMonitor(c_balancerWrapper_balancerMu);
	run mutexMonitor(c_balancerWrapper_scBuffer_mu);
	run mutexMonitor(c_balancerWrapper_done_o_m);
	run mutexMonitor(c_balancerWrapper_mu);
	run mutexMonitor(c_firstResolveEvent_o_m);
	

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

