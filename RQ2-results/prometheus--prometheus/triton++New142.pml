
// https://github.com/prometheus/prometheus/blob/master/discovery/triton/triton.go#L142
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_New1420 = [1] of {int};
	run New142(child_New1420)
stop_process:skip
}

proctype New142(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef transport_nextProtoOnce_m;
	Mutexdef transport_TLSClientConfig_mutex;
	Mutexdef transport_connsPerHostMu;
	Mutexdef transport_altMu;
	Mutexdef transport_reqMu;
	Mutexdef transport_idleMu;
	Mutexdef tls_mutex;
	run mutexMonitor(tls_mutex);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(transport_idleMu);
	run mutexMonitor(transport_reqMu);
	run mutexMonitor(transport_altMu);
	run mutexMonitor(transport_connsPerHostMu);
	run mutexMonitor(transport_TLSClientConfig_mutex);
	run mutexMonitor(transport_nextProtoOnce_m);
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

