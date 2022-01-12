// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/google/grumpy/blob//runtime/file_test.go#L130
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFileNext1300 = [1] of {int};
	run TestFileNext130(child_TestFileNext1300);
	run receiver(child_TestFileNext1300)
stop_process:skip
}

proctype TestFileNext130(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef closedFile_close_ref_mutex;
	Mutexdef closedFile_close_dict_mutex_mutex;
	Mutexdef closedFile_mutex;
	int var_cases = -2; // opt var_cases
	run mutexMonitor(closedFile_mutex);
	run mutexMonitor(closedFile_close_dict_mutex_mutex);
	run mutexMonitor(closedFile_close_ref_mutex);
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

