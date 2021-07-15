
// https://github.com/istio/istio/blob/master/pilot/pkg/networking/core/v1alpha3/route/route_internal_test.go#L282
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTranslateCORSPolicy2820 = [1] of {int};
	run TestTranslateCORSPolicy282(child_TestTranslateCORSPolicy2820)
stop_process:skip
}

proctype TestTranslateCORSPolicy282(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef got_ShadowEnabled_DefaultValue_state_atomicMessageInfo_initMu;
	Mutexdef got_ShadowEnabled_state_atomicMessageInfo_initMu;
	Mutexdef got_AllowCredentials_state_atomicMessageInfo_initMu;
	Mutexdef got_state_atomicMessageInfo_initMu;
	Mutexdef expectedCorsPolicy_ShadowEnabled_DefaultValue_state_atomicMessageInfo_initMu;
	Mutexdef expectedCorsPolicy_ShadowEnabled_state_atomicMessageInfo_initMu;
	Mutexdef expectedCorsPolicy_AllowCredentials_state_atomicMessageInfo_initMu;
	Mutexdef expectedCorsPolicy_state_atomicMessageInfo_initMu;
	run mutexMonitor(expectedCorsPolicy_state_atomicMessageInfo_initMu);
	run mutexMonitor(expectedCorsPolicy_AllowCredentials_state_atomicMessageInfo_initMu);
	run mutexMonitor(expectedCorsPolicy_ShadowEnabled_state_atomicMessageInfo_initMu);
	run mutexMonitor(expectedCorsPolicy_ShadowEnabled_DefaultValue_state_atomicMessageInfo_initMu);
	run mutexMonitor(got_state_atomicMessageInfo_initMu);
	run mutexMonitor(got_AllowCredentials_state_atomicMessageInfo_initMu);
	run mutexMonitor(got_ShadowEnabled_state_atomicMessageInfo_initMu);
	run mutexMonitor(got_ShadowEnabled_DefaultValue_state_atomicMessageInfo_initMu);
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

