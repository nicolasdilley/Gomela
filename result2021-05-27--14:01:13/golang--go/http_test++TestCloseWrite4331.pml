// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/net/http/serve_test.go#L4331
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCloseWrite43310 = [1] of {int};
	run TestCloseWrite4331(child_TestCloseWrite43310);
	run receiver(child_TestCloseWrite43310)
stop_process:skip
}

proctype TestCloseWrite4331(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef srv_mu;
	Mutexdef srv_nextProtoOnce_m;
	Mutexdef srv_ErrorLog_mu;
	Mutexdef srv_TLSConfig_mutex;
	run mutexMonitor(srv_TLSConfig_mutex);
	run mutexMonitor(srv_ErrorLog_mu);
	run mutexMonitor(srv_nextProtoOnce_m);
	run mutexMonitor(srv_mu);
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

