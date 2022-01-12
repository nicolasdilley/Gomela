// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/google/grumpy/blob//runtime/file_test.go#L224
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFileReadLines2240 = [1] of {int};
	run TestFileReadLines224(child_TestFileReadLines2240);
	run receiver(child_TestFileReadLines2240)
stop_process:skip
}

proctype TestFileReadLines224(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_readLine790 = [1] of {int};
	Mutexdef partialReadFile_close_ref_mutex;
	Mutexdef partialReadFile_close_dict_mutex_mutex;
	Mutexdef partialReadFile_mutex;
	Mutexdef closedFile_close_ref_mutex;
	Mutexdef closedFile_close_dict_mutex_mutex;
	Mutexdef closedFile_mutex;
	int var_cases = -2; // opt var_cases
	run mutexMonitor(closedFile_mutex);
	run mutexMonitor(closedFile_close_dict_mutex_mutex);
	run mutexMonitor(closedFile_close_ref_mutex);
	run mutexMonitor(partialReadFile_mutex);
	run mutexMonitor(partialReadFile_close_dict_mutex_mutex);
	run mutexMonitor(partialReadFile_close_ref_mutex);
	run readLine79(partialReadFile_close_dict_mutex_mutex,partialReadFile_close_ref_mutex,partialReadFile_mutex,child_readLine790);
	child_readLine790?0;
	stop_process: skip;
	child!0
}
proctype readLine79(Mutexdef f_close_dict_mutex_mutex;Mutexdef f_close_ref_mutex;Mutexdef f_mutex;chan child) {
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

