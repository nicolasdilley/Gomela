
// https://github.com/istio/istio/blob/master/pilot/pkg/xds/eds_test.go#L192
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTunnelServerEndpointEds1920 = [1] of {int};
	run TestTunnelServerEndpointEds192(child_TestTunnelServerEndpointEds1920)
stop_process:skip
}

proctype TestTunnelServerEndpointEds192(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef s_Listener_mu;
	Mutexdef s_Discovery_JwtKeyResolver_keyEntries_mu;
	Mutexdef s_Discovery_WorkloadEntryController_mutex;
	Mutexdef s_Discovery_WorkloadEntryController_cleanupLimit_mu;
	Mutexdef s_Discovery_adsClientsMutex;
	Mutexdef s_Discovery_updateMutex;
	Mutexdef s_Discovery_mutex;
	Mutexdef s_Discovery_MemRegistry_mutex;
	Mutexdef s_Discovery_Env_TrustBundle_endpointMutex;
	Mutexdef s_Discovery_Env_TrustBundle_mutex;
	Mutexdef s_Discovery_Env_PushContext_initializeMutex;
	Mutexdef s_Discovery_Env_PushContext_networksMu;
	Mutexdef s_Discovery_Env_PushContext_JwtKeyResolver_keyEntries_mu;
	Mutexdef s_Discovery_Env_PushContext_proxyStatusMutex;
	run mutexMonitor(s_Discovery_Env_PushContext_proxyStatusMutex);
	run mutexMonitor(s_Discovery_Env_PushContext_JwtKeyResolver_keyEntries_mu);
	run mutexMonitor(s_Discovery_Env_PushContext_networksMu);
	run mutexMonitor(s_Discovery_Env_PushContext_initializeMutex);
	run mutexMonitor(s_Discovery_Env_TrustBundle_mutex);
	run mutexMonitor(s_Discovery_Env_TrustBundle_endpointMutex);
	run mutexMonitor(s_Discovery_MemRegistry_mutex);
	run mutexMonitor(s_Discovery_mutex);
	run mutexMonitor(s_Discovery_updateMutex);
	run mutexMonitor(s_Discovery_adsClientsMutex);
	run mutexMonitor(s_Discovery_WorkloadEntryController_cleanupLimit_mu);
	run mutexMonitor(s_Discovery_WorkloadEntryController_mutex);
	run mutexMonitor(s_Discovery_JwtKeyResolver_keyEntries_mu);
	run mutexMonitor(s_Listener_mu);
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

