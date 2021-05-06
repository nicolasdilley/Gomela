
// https://github.com/kubernetes/kubernetes/blob/master/pkg/volume/quobyte/quobyte_util.go#L82
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_createQuobyteClient820 = [1] of {int};
	run createQuobyteClient82(child_createQuobyteClient820)
stop_process:skip
}

proctype createQuobyteClient82(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef rt_nextProtoOnce_m;
	Mutexdef rt_TLSClientConfig_mutex;
	Mutexdef rt_connsPerHostMu;
	Mutexdef rt_altMu;
	Mutexdef rt_reqMu;
	Mutexdef rt_idleMu;
	run mutexMonitor(rt_idleMu);
	run mutexMonitor(rt_reqMu);
	run mutexMonitor(rt_altMu);
	run mutexMonitor(rt_connsPerHostMu);
	run mutexMonitor(rt_TLSClientConfig_mutex);
	run mutexMonitor(rt_nextProtoOnce_m);
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

