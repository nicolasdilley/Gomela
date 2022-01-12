// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/cli/cli/blob//pkg/cmd/repo/fork/fork_test.go#L225
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRepoFork_no_conflicting_remote2250 = [1] of {int};
	run TestRepoFork_no_conflicting_remote225(child_TestRepoFork_no_conflicting_remote2250);
	run receiver(child_TestRepoFork_no_conflicting_remote2250)
stop_process:skip
}

proctype TestRepoFork_no_conflicting_remote225(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Verify270 = [1] of {int};
	Mutexdef reg_mu;
	run mutexMonitor(reg_mu);
		defer1: skip;
	run Verify27(reg_mu,child_Verify270);
	child_Verify270?0;
	stop_process: skip;
	child!0
}
proctype Verify27(Mutexdef r_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_r_stubs = -2; // opt var_r_stubs
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

