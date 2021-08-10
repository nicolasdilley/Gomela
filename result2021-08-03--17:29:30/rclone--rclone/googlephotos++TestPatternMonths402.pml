// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/rclone/rclone/blob/a223b78872dc7a8713ca2aa4596ae3e30c173cdd/backend/googlephotos/pattern_test.go#L402
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPatternMonths4020 = [1] of {int};
	run TestPatternMonths402(child_TestPatternMonths4020);
	run receiver(child_TestPatternMonths4020)
stop_process:skip
}

proctype TestPatternMonths402(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_months2590 = [1] of {int};
	Mutexdef f_albums_mu;
	int var_entries = -2; // opt var_entries
	run mutexMonitor(f_albums_mu);
	run months259(f_albums_mu,child_months2590);
	child_months2590?0;
	stop_process: skip;
	child!0
}
proctype months259(Mutexdef f_albums_mu;chan child) {
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

