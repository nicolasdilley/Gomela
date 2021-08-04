// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/restic/restic/blob/be6fc02c044f144f54779d9b0ed02f73df45a5eb/internal/backend/utils_test.go#L57
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLoadAllAppend570 = [1] of {int};
	run TestLoadAllAppend57(child_TestLoadAllAppend570);
	run receiver(child_TestLoadAllAppend570)
stop_process:skip
}

proctype TestLoadAllAppend57(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_save471 = [1] of {int};
	chan child_save470 = [1] of {int};
	Mutexdef b_m;
	int var_tests = -2; // opt var_tests
	run mutexMonitor(b_m);
	run save47(b_m,child_save470);
	child_save470?0;
	run save47(b_m,child_save471);
	child_save471?0;
	stop_process: skip;
	child!0
}
proctype save47(Mutexdef be_m;chan child) {
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

