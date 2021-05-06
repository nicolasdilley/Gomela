
// https://github.com/istio/istio/blob/master/pilot/pkg/networking/core/v1alpha3/cluster_builder_test.go#L2155
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestShouldH2Upgrade21550 = [1] of {int};
	run TestShouldH2Upgrade2155(child_TestShouldH2Upgrade21550)
stop_process:skip
}

proctype TestShouldH2Upgrade2155(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef cb_push_initializeMutex;
	Mutexdef cb_push_networksMu;
	Mutexdef cb_push_JwtKeyResolver_keyEntries_mu;
	Mutexdef cb_push_proxyStatusMutex;
	Mutexdef cb_proxy_Locality_state_atomicMessageInfo_initMu;
	run mutexMonitor(cb_proxy_Locality_state_atomicMessageInfo_initMu);
	run mutexMonitor(cb_push_proxyStatusMutex);
	run mutexMonitor(cb_push_JwtKeyResolver_keyEntries_mu);
	run mutexMonitor(cb_push_networksMu);
	run mutexMonitor(cb_push_initializeMutex);
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

