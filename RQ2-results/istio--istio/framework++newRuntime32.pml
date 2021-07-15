
// https://github.com/istio/istio/blob/master/pkg/test/framework/runtime.go#L32
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_newRuntime320 = [1] of {int};
	run newRuntime32(child_newRuntime320)
stop_process:skip
}

proctype newRuntime32(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef ctx_outcomeMu;
	Mutexdef ctx_contextMu;
	Mutexdef ctx_globalScope_mu;
	run mutexMonitor(ctx_globalScope_mu);
	run mutexMonitor(ctx_contextMu);
	run mutexMonitor(ctx_outcomeMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
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

