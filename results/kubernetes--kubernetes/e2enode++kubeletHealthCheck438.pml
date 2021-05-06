
// https://github.com/kubernetes/kubernetes/blob/master/test/e2e_node/util.go#L438
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_kubeletHealthCheck4380 = [1] of {int};
	run kubeletHealthCheck438(child_kubeletHealthCheck4380)
stop_process:skip
}

proctype kubeletHealthCheck438(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef insecureTransport_nextProtoOnce_m;
	Mutexdef insecureTransport_TLSClientConfig_mutex;
	Mutexdef insecureTransport_connsPerHostMu;
	Mutexdef insecureTransport_altMu;
	Mutexdef insecureTransport_reqMu;
	Mutexdef insecureTransport_idleMu;
	run mutexMonitor(insecureTransport_idleMu);
	run mutexMonitor(insecureTransport_reqMu);
	run mutexMonitor(insecureTransport_altMu);
	run mutexMonitor(insecureTransport_connsPerHostMu);
	run mutexMonitor(insecureTransport_TLSClientConfig_mutex);
	run mutexMonitor(insecureTransport_nextProtoOnce_m);
	

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

