// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/cli/cli/blob/25d79c4e16d54d6f3621517269f07048748a6b97/pkg/cmd/repo/clone/clone_test.go#L97
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_runCloneCommand970 = [1] of {int};
	run runCloneCommand97(child_runCloneCommand970);
	run receiver(child_runCloneCommand970)
stop_process:skip
}

proctype runCloneCommand97(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef io_pagerProcess_sigMu;
	Mutexdef io_progressIndicator_mu;
	run mutexMonitor(io_progressIndicator_mu);
	run mutexMonitor(io_pagerProcess_sigMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

