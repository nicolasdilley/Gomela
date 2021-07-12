// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/net/http/transport_test.go#L5431
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTransportCheckContextDoneEarly54310 = [1] of {int};
	run TestTransportCheckContextDoneEarly5431(child_TestTransportCheckContextDoneEarly54310);
	run receiver(child_TestTransportCheckContextDoneEarly54310)
stop_process:skip
}

proctype TestTransportCheckContextDoneEarly5431(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RoundTrip1090 = [1] of {int};
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
	run RoundTrip109(tr_altMu,tr_connsPerHostMu,tr_idleMu,tr_nextProtoOnce_m,tr_reqMu,tr_TLSClientConfig_mutex,child_RoundTrip1090);
	child_RoundTrip1090?0;
	stop_process: skip;
	child!0
}
proctype RoundTrip109(Mutexdef t_altMu;Mutexdef t_connsPerHostMu;Mutexdef t_idleMu;Mutexdef t_nextProtoOnce_m;Mutexdef t_reqMu;Mutexdef t_TLSClientConfig_mutex;chan child) {
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

