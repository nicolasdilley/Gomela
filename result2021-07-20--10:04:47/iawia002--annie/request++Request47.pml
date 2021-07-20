// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/iawia002/annie/blob/abc3c9df18173c91a5ca7a77fecc0665dea01aa1/request/request.go#L47
#define var_headers  -2 // opt headers line 47
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Request470 = [1] of {int};
	run Request47(var_headers,child_Request470);
	run receiver(child_Request470)
stop_process:skip
}

proctype Request47(int headers;chan child) {
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
	int var_cookiescookies = -2; // opt var_cookiescookies
	int var_config_FakeHeadersconfig_FakeHeaders = -2; // opt var_config_FakeHeadersconfig_FakeHeaders
	run mutexMonitor(transport_idleMu);
	run mutexMonitor(transport_reqMu);
	run mutexMonitor(transport_altMu);
	run mutexMonitor(transport_connsPerHostMu);
	run mutexMonitor(transport_TLSClientConfig_mutex);
	run mutexMonitor(transport_nextProtoOnce_m);
	

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

proctype receiver(chan c) {
c?0
}

