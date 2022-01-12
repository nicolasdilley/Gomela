// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/grafana/k6/blob//lib/executor/constant_arrival_rate_test.go#L257
#define def_var_testCases266  ?? // mand testCases line 266
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestArrivalRateCancel2570 = [1] of {int};
	run TestArrivalRateCancel257(child_TestArrivalRateCancel2570);
	run receiver(child_TestArrivalRateCancel2570)
stop_process:skip
}

proctype TestArrivalRateCancel257(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RegisterBuiltinMetrics1020 = [1] of {int};
	Mutexdef registry_l;
	int var_testCases = def_var_testCases266; // mand var_testCases
	run mutexMonitor(registry_l);
	run RegisterBuiltinMetrics102(registry_l,child_RegisterBuiltinMetrics1020);
	child_RegisterBuiltinMetrics1020?0;
	for10_exit: skip;
	stop_process: skip;
	child!0
}
proctype RegisterBuiltinMetrics102(Mutexdef registry_l;chan child) {
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

