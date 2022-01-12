// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob//test/e2e/framework/ingress/ingress_utils.go#L377
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_BuildInsecureClient3770 = [1] of {int};
	run BuildInsecureClient377(child_BuildInsecureClient3770);
	run receiver(child_BuildInsecureClient3770)
stop_process:skip
}

proctype BuildInsecureClient377(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef t_nextProtoOnce_m;
	Mutexdef t_TLSClientConfig_mutex;
	Mutexdef t_connsPerHostMu;
	Mutexdef t_altMu;
	Mutexdef t_reqMu;
	Mutexdef t_idleMu;
	run mutexMonitor(t_idleMu);
	run mutexMonitor(t_reqMu);
	run mutexMonitor(t_altMu);
	run mutexMonitor(t_connsPerHostMu);
	run mutexMonitor(t_TLSClientConfig_mutex);
	run mutexMonitor(t_nextProtoOnce_m);
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

proctype receiver(chan c) {
c?0
}

