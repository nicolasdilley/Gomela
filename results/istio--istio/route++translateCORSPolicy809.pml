
// https://github.com/istio/istio/blob/master/pilot/pkg/networking/core/v1alpha3/route/route.go#L809
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_translateCORSPolicy8090 = [1] of {int};
	run translateCORSPolicy809(child_translateCORSPolicy8090)
stop_process:skip
}

proctype translateCORSPolicy809(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef out_ShadowEnabled_DefaultValue_state_atomicMessageInfo_initMu;
	Mutexdef out_ShadowEnabled_state_atomicMessageInfo_initMu;
	Mutexdef out_AllowCredentials_state_atomicMessageInfo_initMu;
	Mutexdef out_state_atomicMessageInfo_initMu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(out_state_atomicMessageInfo_initMu);
	run mutexMonitor(out_AllowCredentials_state_atomicMessageInfo_initMu);
	run mutexMonitor(out_ShadowEnabled_state_atomicMessageInfo_initMu);
	run mutexMonitor(out_ShadowEnabled_DefaultValue_state_atomicMessageInfo_initMu);
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

