// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/google/grumpy/blob//runtime/weakref_test.go#L67
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestWeakRefNew670 = [1] of {int};
	run TestWeakRefNew67(child_TestWeakRefNew670);
	run receiver(child_TestWeakRefNew670)
stop_process:skip
}

proctype TestWeakRefNew67(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newTestWeakRef1290 = [1] of {int};
	Mutexdef aliveRef_hash_dict_mutex_mutex;
	Mutexdef aliveRef_mutex;
	Mutexdef alive_ref_mutex;
	Mutexdef alive_dict_mutex_mutex;
	int var_cases = -2; // opt var_cases
	run mutexMonitor(alive_dict_mutex_mutex);
	run mutexMonitor(alive_ref_mutex);
	run mutexMonitor(aliveRef_mutex);
	run mutexMonitor(aliveRef_hash_dict_mutex_mutex);
	run newTestWeakRef129(alive_dict_mutex_mutex,alive_ref_mutex,child_newTestWeakRef1290);
	child_newTestWeakRef1290?0;
	stop_process: skip;
	child!0
}
proctype newTestWeakRef129(Mutexdef o_dict_mutex_mutex;Mutexdef o_ref_mutex;chan child) {
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

