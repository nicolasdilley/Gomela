// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/google/grumpy/blob//runtime/list_test.go#L408
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestListStrRepr4080 = [1] of {int};
	run TestListStrRepr408(child_TestListStrRepr4080);
	run receiver(child_TestListStrRepr4080)
stop_process:skip
}

proctype TestListStrRepr408(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef recursiveList_ref_mutex;
	Mutexdef recursiveList_dict_mutex_mutex;
	int var_cases = -2; // opt var_cases
	run mutexMonitor(recursiveList_dict_mutex_mutex);
	run mutexMonitor(recursiveList_ref_mutex);
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

