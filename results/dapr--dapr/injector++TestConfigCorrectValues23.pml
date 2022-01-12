// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/dapr/dapr/blob//pkg/injector/injector_test.go#L23
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfigCorrectValues230 = [1] of {int};
	run TestConfigCorrectValues23(child_TestConfigCorrectValues230);
	run receiver(child_TestConfigCorrectValues230)
stop_process:skip
}

proctype TestConfigCorrectValues23(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef injector_server_mu;
	Mutexdef injector_server_nextProtoOnce_m;
	Mutexdef injector_server_ErrorLog_mu;
	Mutexdef injector_server_TLSConfig_mutex;
	run mutexMonitor(injector_server_TLSConfig_mutex);
	run mutexMonitor(injector_server_ErrorLog_mu);
	run mutexMonitor(injector_server_nextProtoOnce_m);
	run mutexMonitor(injector_server_mu);
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

