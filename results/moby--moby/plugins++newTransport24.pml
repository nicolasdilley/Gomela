
// https://github.com/moby/moby/blob/master/pkg/plugins/client.go#L24
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_newTransport240 = [1] of {int};
	run newTransport24(child_newTransport240)
stop_process:skip
}

proctype newTransport24(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewHTTPTransport180 = [1] of {int};
	Mutexdef c_mutex;
	Mutexdef tr_nextProtoOnce_m;
	Mutexdef tr_TLSClientConfig_mutex;
	Mutexdef tr_connsPerHostMu;
	Mutexdef tr_altMu;
	Mutexdef tr_reqMu;
	Mutexdef tr_idleMu;
	run mutexMonitor(tr_idleMu);
	run mutexMonitor(tr_reqMu);
	run mutexMonitor(tr_altMu);
	run mutexMonitor(tr_connsPerHostMu);
	run mutexMonitor(tr_TLSClientConfig_mutex);
	run mutexMonitor(tr_nextProtoOnce_m);
	

	if
	:: true -> 
		run mutexMonitor(c_mutex);
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

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
	run NewHTTPTransport18(tr_idleMu,tr_reqMu,tr_altMu,tr_connsPerHostMu,tr_TLSClientConfig_mutex,tr_nextProtoOnce_m,child_NewHTTPTransport180);
	child_NewHTTPTransport180?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewHTTPTransport18(Mutexdef r_idleMu;Mutexdef r_reqMu;Mutexdef r_altMu;Mutexdef r_connsPerHostMu;Mutexdef r_TLSClientConfig_mutex;Mutexdef r_nextProtoOnce_m;chan child) {
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

