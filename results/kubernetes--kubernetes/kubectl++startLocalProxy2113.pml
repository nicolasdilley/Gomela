
// https://github.com/kubernetes/kubernetes/blob/master/test/e2e/kubectl/kubectl.go#L2113
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_startLocalProxy21130 = [1] of {int};
	run startLocalProxy2113(child_startLocalProxy21130)
stop_process:skip
}

proctype startLocalProxy2113(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef p_Tr_nextProtoOnce_m;
	Mutexdef p_Tr_TLSClientConfig_mutex;
	Mutexdef p_Tr_connsPerHostMu;
	Mutexdef p_Tr_altMu;
	Mutexdef p_Tr_reqMu;
	Mutexdef p_Tr_idleMu;
	Mutexdef p_Logger_mu;
	run mutexMonitor(p_Logger_mu);
	run mutexMonitor(p_Tr_idleMu);
	run mutexMonitor(p_Tr_reqMu);
	run mutexMonitor(p_Tr_altMu);
	run mutexMonitor(p_Tr_connsPerHostMu);
	run mutexMonitor(p_Tr_TLSClientConfig_mutex);
	run mutexMonitor(p_Tr_nextProtoOnce_m);
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

