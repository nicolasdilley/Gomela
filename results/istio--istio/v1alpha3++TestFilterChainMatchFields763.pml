
// https://github.com/istio/istio/blob/master/pilot/pkg/networking/core/v1alpha3/listener_test.go#L763
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFilterChainMatchFields7630 = [1] of {int};
	run TestFilterChainMatchFields763(child_TestFilterChainMatchFields7630)
stop_process:skip
}

proctype TestFilterChainMatchFields763(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef fcm_SuffixLen_state_atomicMessageInfo_initMu;
	Mutexdef fcm_DestinationPort_state_atomicMessageInfo_initMu;
	Mutexdef fcm_state_atomicMessageInfo_initMu;
	run mutexMonitor(fcm_state_atomicMessageInfo_initMu);
	run mutexMonitor(fcm_DestinationPort_state_atomicMessageInfo_initMu);
	run mutexMonitor(fcm_SuffixLen_state_atomicMessageInfo_initMu);
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

