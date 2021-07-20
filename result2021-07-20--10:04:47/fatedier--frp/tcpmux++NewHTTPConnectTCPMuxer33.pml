// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/fatedier/frp/blob/2408f1df04ad9128ee31a013799f5790dbda5cb3/pkg/util/tcpmux/httpconnect.go#L33
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewHTTPConnectTCPMuxer330 = [1] of {int};
	run NewHTTPConnectTCPMuxer33(child_NewHTTPConnectTCPMuxer330);
	run receiver(child_NewHTTPConnectTCPMuxer330)
stop_process:skip
}

proctype NewHTTPConnectTCPMuxer33(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef mux_registryRouter_mutex;
	run mutexMonitor(mux_registryRouter_mutex);
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
