// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/moby/moby/blob/5a82cee6d499e51bc903a743e4f0f205adb161a9/pkg/plugins/transport/http_test.go#L12
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestHTTPTransport120 = [1] of {int};
	run TestHTTPTransport12(child_TestHTTPTransport120);
	run receiver(child_TestHTTPTransport120)
stop_process:skip
}

proctype TestHTTPTransport12(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewHTTPTransport180 = [1] of {int};
	Mutexdef roundTripper_nextProtoOnce_m;
	Mutexdef roundTripper_TLSClientConfig_mutex;
	Mutexdef roundTripper_connsPerHostMu;
	Mutexdef roundTripper_altMu;
	Mutexdef roundTripper_reqMu;
	Mutexdef roundTripper_idleMu;
	run mutexMonitor(roundTripper_idleMu);
	run mutexMonitor(roundTripper_reqMu);
	run mutexMonitor(roundTripper_altMu);
	run mutexMonitor(roundTripper_connsPerHostMu);
	run mutexMonitor(roundTripper_TLSClientConfig_mutex);
	run mutexMonitor(roundTripper_nextProtoOnce_m);
	run NewHTTPTransport18(roundTripper_altMu,roundTripper_connsPerHostMu,roundTripper_idleMu,roundTripper_nextProtoOnce_m,roundTripper_reqMu,roundTripper_TLSClientConfig_mutex,child_NewHTTPTransport180);
	child_NewHTTPTransport180?0;
	stop_process: skip;
	child!0
}
proctype NewHTTPTransport18(Mutexdef r_altMu;Mutexdef r_connsPerHostMu;Mutexdef r_idleMu;Mutexdef r_nextProtoOnce_m;Mutexdef r_reqMu;Mutexdef r_TLSClientConfig_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

