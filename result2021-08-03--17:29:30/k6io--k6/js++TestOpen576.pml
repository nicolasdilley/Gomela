// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/k6io/k6/blob/af1e032ebf949cde092d4a2eddb78528ea0a5864/js/bundle_test.go#L576
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestOpen5760 = [1] of {int};
	run TestOpen576(child_TestOpen5760);
	run receiver(child_TestOpen5760)
stop_process:skip
}

proctype TestOpen576(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef logger_mu_lock;
	int var_testCases = -2; // opt var_testCases
	int var_fss = -2; // opt var_fss
	run mutexMonitor(logger_mu_lock);
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

