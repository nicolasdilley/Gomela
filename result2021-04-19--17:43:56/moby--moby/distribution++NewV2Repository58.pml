
// https://github.com/moby/moby/blob/master/distribution/registry.go#L58
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewV2Repository580 = [1] of {int};
	run NewV2Repository58(child_NewV2Repository580)
stop_process:skip
}

proctype NewV2Repository58(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef base_nextProtoOnce_m;
	Mutexdef base_TLSClientConfig_mutex;
	Mutexdef base_connsPerHostMu;
	Mutexdef base_altMu;
	Mutexdef base_reqMu;
	Mutexdef base_idleMu;
	Mutexdef direct_Resolver_lookupGroup_mu;
	run mutexMonitor(direct_Resolver_lookupGroup_mu);
	run mutexMonitor(base_idleMu);
	run mutexMonitor(base_reqMu);
	run mutexMonitor(base_altMu);
	run mutexMonitor(base_connsPerHostMu);
	run mutexMonitor(base_TLSClientConfig_mutex);
	run mutexMonitor(base_nextProtoOnce_m);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

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

