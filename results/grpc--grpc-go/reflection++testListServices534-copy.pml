// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grpc/grpc-go/blob//reflection/serverreflection_test.go#L534
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_testListServices5340 = [1] of {int};
	run testListServices534(child_testListServices5340);
	run receiver(child_testListServices5340)
stop_process:skip
}

proctype testListServices534(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef r_OriginalRequest_state_atomicMessageInfo_initMu;
	Mutexdef r_state_atomicMessageInfo_initMu;
	int var_want = -2; // opt var_want
	int var_services = -2; // opt var_services
	run mutexMonitor(r_state_atomicMessageInfo_initMu);
	run mutexMonitor(r_OriginalRequest_state_atomicMessageInfo_initMu);
	

	if
	:: true;
	:: true;
	fi;
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

