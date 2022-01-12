// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob//sort/sort_test.go#L509
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAdversary5090 = [1] of {int};
	run TestAdversary509(child_TestAdversary5090);
	run receiver(child_TestAdversary5090)
stop_process:skip
}

proctype TestAdversary509(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Sort270 = [1] of {int};
	Mutexdef d_t_context_mu;
	Mutexdef d_t_context_match_mu;
	int var_d_data = -2; // opt var_d_data
	run mutexMonitor(d_t_context_match_mu);
	run mutexMonitor(d_t_context_mu);
	run Sort27(d_t_context_match_mu,d_t_context_mu,child_Sort270);
	child_Sort270?0;
	stop_process: skip;
	child!0
}
proctype Sort27(Mutexdef planets_t_context_match_mu;Mutexdef planets_t_context_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

