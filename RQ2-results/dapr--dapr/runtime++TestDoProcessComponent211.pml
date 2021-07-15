
// https://github.com/dapr/dapr/blob/master/pkg/runtime/runtime_test.go#L211
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDoProcessComponent2110 = [1] of {int};
	run TestDoProcessComponent211(child_TestDoProcessComponent2110)
stop_process:skip
}

proctype TestDoProcessComponent211(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef rt_grpc_lock;
	Mutexdef rt_grpc_AppClient_lceMu;
	Mutexdef rt_grpc_AppClient_firstResolveEvent_o_m;
	Mutexdef rt_grpc_AppClient_balancerWrapper_mu;
	Mutexdef rt_grpc_AppClient_balancerWrapper_done_o_m;
	Mutexdef rt_grpc_AppClient_balancerWrapper_scBuffer_mu;
	Mutexdef rt_grpc_AppClient_balancerWrapper_balancerMu;
	Mutexdef rt_grpc_AppClient_resolverWrapper_pollingMu;
	Mutexdef rt_grpc_AppClient_resolverWrapper_done_o_m;
	Mutexdef rt_grpc_AppClient_resolverWrapper_resolverMu;
	Mutexdef rt_grpc_AppClient_mu;
	Mutexdef rt_grpc_AppClient_safeConfigSelector_mu;
	Mutexdef rt_grpc_AppClient_blockingpicker_mu;
	Mutexdef rt_grpc_AppClient_csMgr_mu;
	Mutexdef rt_componentsLock;
	run mutexMonitor(rt_componentsLock);
	run mutexMonitor(rt_grpc_AppClient_csMgr_mu);
	run mutexMonitor(rt_grpc_AppClient_blockingpicker_mu);
	run mutexMonitor(rt_grpc_AppClient_safeConfigSelector_mu);
	run mutexMonitor(rt_grpc_AppClient_mu);
	run mutexMonitor(rt_grpc_AppClient_resolverWrapper_resolverMu);
	run mutexMonitor(rt_grpc_AppClient_resolverWrapper_done_o_m);
	run mutexMonitor(rt_grpc_AppClient_resolverWrapper_pollingMu);
	run mutexMonitor(rt_grpc_AppClient_balancerWrapper_balancerMu);
	run mutexMonitor(rt_grpc_AppClient_balancerWrapper_scBuffer_mu);
	run mutexMonitor(rt_grpc_AppClient_balancerWrapper_done_o_m);
	run mutexMonitor(rt_grpc_AppClient_balancerWrapper_mu);
	run mutexMonitor(rt_grpc_AppClient_firstResolveEvent_o_m);
	run mutexMonitor(rt_grpc_AppClient_lceMu);
	run mutexMonitor(rt_grpc_lock);
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

