// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/jesseduffield/lazygit/blob//pkg/commands/rebasing_test.go#L13
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGitCommandRebaseBranch130 = [1] of {int};
	run TestGitCommandRebaseBranch13(child_TestGitCommandRebaseBranch130);
	run receiver(child_TestGitCommandRebaseBranch130)
stop_process:skip
}

proctype TestGitCommandRebaseBranch13(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef gitCmd_Log_Logger_mu_lock;
	int var_scenarios = -2; // opt var_scenarios
	run mutexMonitor(gitCmd_Log_Logger_mu_lock);
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

