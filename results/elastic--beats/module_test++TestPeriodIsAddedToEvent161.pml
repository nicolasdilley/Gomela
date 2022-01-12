// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/elastic/beats/blob//metricbeat/mb/module/wrapper_test.go#L161
#define def_var_cases178  ?? // mand cases line 178
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPeriodIsAddedToEvent1610 = [1] of {int};
	run TestPeriodIsAddedToEvent161(child_TestPeriodIsAddedToEvent1610);
	run receiver(child_TestPeriodIsAddedToEvent1610)
stop_process:skip
}

proctype TestPeriodIsAddedToEvent161(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef registry_lock;
	int var_cases = def_var_cases178; // mand var_cases
	run mutexMonitor(registry_lock);
	for10_exit: skip;
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

