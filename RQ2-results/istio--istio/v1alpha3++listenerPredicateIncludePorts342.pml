
// https://github.com/istio/istio/blob/master/pilot/pkg/networking/core/v1alpha3/listener_builder.go#L342
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_listenerPredicateIncludePorts3420 = [1] of {int};
	run listenerPredicateIncludePorts342(child_listenerPredicateIncludePorts3420)
stop_process:skip
}

proctype listenerPredicateIncludePorts342(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef rule_state_atomicMessageInfo_initMu;
	run mutexMonitor(rule_state_atomicMessageInfo_initMu);
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

