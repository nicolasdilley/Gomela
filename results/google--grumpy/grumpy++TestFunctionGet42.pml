// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/google/grumpy/blob//runtime/function_test.go#L42
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFunctionGet420 = [1] of {int};
	run TestFunctionGet42(child_TestFunctionGet420);
	run receiver(child_TestFunctionGet420)
stop_process:skip
}

proctype TestFunctionGet42(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_isInstance1000 = [1] of {int};
	Mutexdef appendMethod_ref_mutex;
	Mutexdef appendMethod_dict_mutex_mutex;
	run mutexMonitor(appendMethod_dict_mutex_mutex);
	run mutexMonitor(appendMethod_ref_mutex);
	run isInstance100(appendMethod_dict_mutex_mutex,appendMethod_ref_mutex,child_isInstance1000);
	child_isInstance1000?0;
	stop_process: skip;
	child!0
}
proctype isInstance100(Mutexdef o_dict_mutex_mutex;Mutexdef o_ref_mutex;chan child) {
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

