// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/rclone/rclone/blob/a223b78872dc7a8713ca2aa4596ae3e30c173cdd/fs/walk/walk.go#L453
#define def_var_maxLevel  -2 // opt maxLevel line 453
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_walkRDirTree4530 = [1] of {int};
	run walkRDirTree453(def_var_maxLevel,child_walkRDirTree4530);
	run receiver(child_walkRDirTree4530)
stop_process:skip
}

proctype walkRDirTree453(int var_maxLevel;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef mu;
	int var_entries = -2; // opt var_entries
	run mutexMonitor(mu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

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

