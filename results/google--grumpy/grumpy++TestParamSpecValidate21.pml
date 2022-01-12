// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/google/grumpy/blob//runtime/param_test.go#L21
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestParamSpecValidate210 = [1] of {int};
	run TestParamSpecValidate21(child_TestParamSpecValidate210);
	run receiver(child_TestParamSpecValidate210)
stop_process:skip
}

proctype TestParamSpecValidate21(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ToObject1060 = [1] of {int};
	chan child_ToObject1061 = [1] of {int};
	Mutexdef testFunc_globals_mutex_mutex;
	int var_cases = -2; // opt var_cases
	run mutexMonitor(testFunc_globals_mutex_mutex);
	

	if
	:: var_cases-1 != -3 -> 
				for(i : 0.. var_cases-1) {
			for10: skip;
			run ToObject106(testFunc_globals_mutex_mutex,child_ToObject1060);
			child_ToObject1060?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run ToObject106(testFunc_globals_mutex_mutex,child_ToObject1061);
			child_ToObject1061?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype ToObject106(Mutexdef f_globals_mutex_mutex;chan child) {
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

