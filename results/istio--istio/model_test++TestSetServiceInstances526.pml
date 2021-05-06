
// https://github.com/istio/istio/blob/master/pilot/pkg/model/context_test.go#L526
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSetServiceInstances5260 = [1] of {int};
	run TestSetServiceInstances526(child_TestSetServiceInstances5260)
stop_process:skip
}

proctype TestSetServiceInstances526(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef proxy_Locality_state_atomicMessageInfo_initMu;
	Mutexdef env_TrustBundle_endpointMutex;
	Mutexdef env_TrustBundle_mutex;
	Mutexdef env_PushContext_initializeMutex;
	Mutexdef env_PushContext_networksMu;
	Mutexdef env_PushContext_JwtKeyResolver_keyEntries_mu;
	Mutexdef env_PushContext_proxyStatusMutex;
	Mutexdef serviceDiscovery_mutex;
	run mutexMonitor(serviceDiscovery_mutex);
	run mutexMonitor(env_PushContext_proxyStatusMutex);
	run mutexMonitor(env_PushContext_JwtKeyResolver_keyEntries_mu);
	run mutexMonitor(env_PushContext_networksMu);
	run mutexMonitor(env_PushContext_initializeMutex);
	run mutexMonitor(env_TrustBundle_mutex);
	run mutexMonitor(env_TrustBundle_endpointMutex);
	run mutexMonitor(proxy_Locality_state_atomicMessageInfo_initMu);
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

