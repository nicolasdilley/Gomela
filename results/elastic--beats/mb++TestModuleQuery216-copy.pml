// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/elastic/beats/blob//metricbeat/mb/registry_test.go#L216
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestModuleQuery2160 = [1] of {int};
	run TestModuleQuery216(child_TestModuleQuery2160);
	run receiver(child_TestModuleQuery2160)
stop_process:skip
}

proctype TestModuleQuery216(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Modules3180 = [1] of {int};
	Mutexdef registry_lock;
	run mutexMonitor(registry_lock);
	run Modules318(registry_lock,child_Modules3180);
	child_Modules3180?0;
	stop_process: skip;
	child!0
}
proctype Modules318(Mutexdef r_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_dups = -2; // opt var_dups
	int var_r_metricSets = -2; // opt var_r_metricSets
	int var_sourceModules = -2; // opt var_sourceModules
	int var_r_modules = -2; // opt var_r_modules
	r_lock.RLock!false;
	goto defer1;
		defer1: skip;
	r_lock.RUnlock!false;
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

