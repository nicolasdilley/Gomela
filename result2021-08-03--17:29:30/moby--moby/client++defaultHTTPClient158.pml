// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/moby/moby/blob/5a82cee6d499e51bc903a743e4f0f205adb161a9/client/client.go#L158
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_defaultHTTPClient1580 = [1] of {int};
	run defaultHTTPClient158(child_defaultHTTPClient1580);
	run receiver(child_defaultHTTPClient1580)
stop_process:skip
}

proctype defaultHTTPClient158(chan child) {
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

proctype receiver(chan c) {
c?0
}
