
// https://github.com/istio/istio/blob/master/pilot/pkg/networking/core/v1alpha3/route/route.go#L986
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_consistentHashToHashPolicy9860 = [1] of {int};
	run consistentHashToHashPolicy986(child_consistentHashToHashPolicy9860)
stop_process:skip
}

proctype consistentHashToHashPolicy986(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef ttl_state_atomicMessageInfo_initMu;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		run mutexMonitor(ttl_state_atomicMessageInfo_initMu);
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
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

