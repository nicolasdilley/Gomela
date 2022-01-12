// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/dapr/dapr/blob//pkg/runtime/runtime_test.go#L126
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNewRuntime1260 = [1] of {int};
	run TestNewRuntime126(child_TestNewRuntime1260);
	run receiver(child_TestNewRuntime1260)
stop_process:skip
}

proctype TestNewRuntime126(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef r_grpc_lock;
	Mutexdef r_grpc_AppClient_lceMu;
	Mutexdef r_grpc_AppClient_balancerWrapper_mu;
	Mutexdef r_grpc_AppClient_balancerWrapper_balancerMu;
	Mutexdef r_grpc_AppClient_resolverWrapper_pollingMu;
	Mutexdef r_grpc_AppClient_resolverWrapper_resolverMu;
	Mutexdef r_grpc_AppClient_mu;
	Mutexdef r_grpc_AppClient_safeConfigSelector_mu;
	Mutexdef r_grpc_AppClient_blockingpicker_mu;
	Mutexdef r_grpc_AppClient_csMgr_mu;
	Mutexdef r_componentsLock;
	run mutexMonitor(r_componentsLock);
	run mutexMonitor(r_grpc_AppClient_csMgr_mu);
	run mutexMonitor(r_grpc_AppClient_blockingpicker_mu);
	run mutexMonitor(r_grpc_AppClient_safeConfigSelector_mu);
	run mutexMonitor(r_grpc_AppClient_mu);
	run mutexMonitor(r_grpc_AppClient_resolverWrapper_resolverMu);
	run mutexMonitor(r_grpc_AppClient_resolverWrapper_pollingMu);
	run mutexMonitor(r_grpc_AppClient_balancerWrapper_balancerMu);
	run mutexMonitor(r_grpc_AppClient_balancerWrapper_mu);
	run mutexMonitor(r_grpc_AppClient_lceMu);
	run mutexMonitor(r_grpc_lock);
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

