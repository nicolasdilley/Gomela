
// https://github.com/dapr/dapr/blob/master/pkg/grpc/grpc_test.go#L70
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSetAuthenticator700 = [1] of {int};
	run TestSetAuthenticator70(child_TestSetAuthenticator700)
stop_process:skip
}

proctype TestSetAuthenticator70(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetAuthenticator510 = [1] of {int};
	Mutexdef m_lock;
	Mutexdef m_AppClient_lceMu;
	Mutexdef m_AppClient_firstResolveEvent_o_m;
	Mutexdef m_AppClient_balancerWrapper_mu;
	Mutexdef m_AppClient_balancerWrapper_done_o_m;
	Mutexdef m_AppClient_balancerWrapper_scBuffer_mu;
	Mutexdef m_AppClient_balancerWrapper_balancerMu;
	Mutexdef m_AppClient_resolverWrapper_pollingMu;
	Mutexdef m_AppClient_resolverWrapper_done_o_m;
	Mutexdef m_AppClient_resolverWrapper_resolverMu;
	Mutexdef m_AppClient_mu;
	Mutexdef m_AppClient_safeConfigSelector_mu;
	Mutexdef m_AppClient_blockingpicker_mu;
	Mutexdef m_AppClient_csMgr_mu;
	run mutexMonitor(m_AppClient_csMgr_mu);
	run mutexMonitor(m_AppClient_blockingpicker_mu);
	run mutexMonitor(m_AppClient_safeConfigSelector_mu);
	run mutexMonitor(m_AppClient_mu);
	run mutexMonitor(m_AppClient_resolverWrapper_resolverMu);
	run mutexMonitor(m_AppClient_resolverWrapper_done_o_m);
	run mutexMonitor(m_AppClient_resolverWrapper_pollingMu);
	run mutexMonitor(m_AppClient_balancerWrapper_balancerMu);
	run mutexMonitor(m_AppClient_balancerWrapper_scBuffer_mu);
	run mutexMonitor(m_AppClient_balancerWrapper_done_o_m);
	run mutexMonitor(m_AppClient_balancerWrapper_mu);
	run mutexMonitor(m_AppClient_firstResolveEvent_o_m);
	run mutexMonitor(m_AppClient_lceMu);
	run mutexMonitor(m_lock);
	run SetAuthenticator51(m_AppClient_csMgr_mu,m_AppClient_blockingpicker_mu,m_AppClient_safeConfigSelector_mu,m_AppClient_mu,m_AppClient_resolverWrapper_resolverMu,m_AppClient_resolverWrapper_done_o_m,m_AppClient_resolverWrapper_pollingMu,m_AppClient_balancerWrapper_balancerMu,m_AppClient_balancerWrapper_scBuffer_mu,m_AppClient_balancerWrapper_done_o_m,m_AppClient_balancerWrapper_mu,m_AppClient_firstResolveEvent_o_m,m_AppClient_lceMu,m_lock,child_SetAuthenticator510);
	child_SetAuthenticator510?0;
	stop_process: skip;
	child!0
}
proctype SetAuthenticator51(Mutexdef g_AppClient_csMgr_mu;Mutexdef g_AppClient_blockingpicker_mu;Mutexdef g_AppClient_safeConfigSelector_mu;Mutexdef g_AppClient_mu;Mutexdef g_AppClient_resolverWrapper_resolverMu;Mutexdef g_AppClient_resolverWrapper_done_o_m;Mutexdef g_AppClient_resolverWrapper_pollingMu;Mutexdef g_AppClient_balancerWrapper_balancerMu;Mutexdef g_AppClient_balancerWrapper_scBuffer_mu;Mutexdef g_AppClient_balancerWrapper_done_o_m;Mutexdef g_AppClient_balancerWrapper_mu;Mutexdef g_AppClient_firstResolveEvent_o_m;Mutexdef g_AppClient_lceMu;Mutexdef g_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

