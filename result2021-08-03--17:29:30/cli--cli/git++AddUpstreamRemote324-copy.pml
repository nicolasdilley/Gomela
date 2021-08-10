// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/cli/cli/blob/25d79c4e16d54d6f3621517269f07048748a6b97/git/git.go#L324
#define def_var_branches  -2 // opt branches line 324
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_AddUpstreamRemote3240 = [1] of {int};
	run AddUpstreamRemote324(def_var_branches,child_AddUpstreamRemote3240);
	run receiver(child_AddUpstreamRemote3240)
stop_process:skip
}

proctype AddUpstreamRemote324(int var_branches;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef cloneCmd_Process_sigMu;
	run mutexMonitor(cloneCmd_Process_sigMu);
	

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

