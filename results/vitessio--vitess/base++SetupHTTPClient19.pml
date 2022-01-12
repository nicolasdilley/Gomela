// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vttablet/tabletserver/throttle/base/http.go#L19
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_SetupHTTPClient190 = [1] of {int};
	run SetupHTTPClient19(child_SetupHTTPClient190);
	run receiver(child_SetupHTTPClient190)
stop_process:skip
}

proctype SetupHTTPClient19(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef httpTransport_nextProtoOnce_m;
	Mutexdef httpTransport_TLSClientConfig_mutex;
	Mutexdef httpTransport_connsPerHostMu;
	Mutexdef httpTransport_altMu;
	Mutexdef httpTransport_reqMu;
	Mutexdef httpTransport_idleMu;
	run mutexMonitor(httpTransport_idleMu);
	run mutexMonitor(httpTransport_reqMu);
	run mutexMonitor(httpTransport_altMu);
	run mutexMonitor(httpTransport_connsPerHostMu);
	run mutexMonitor(httpTransport_TLSClientConfig_mutex);
	run mutexMonitor(httpTransport_nextProtoOnce_m);
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

