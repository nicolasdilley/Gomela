// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/elastic/beats/blob//x-pack/libbeat/management/manager_test.go#L19
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfigBlocks190 = [1] of {int};
	run TestConfigBlocks19(child_TestConfigBlocks190);
	run receiver(child_TestConfigBlocks190)
stop_process:skip
}

proctype TestConfigBlocks19(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_toConfigBlocks3150 = [1] of {int};
	Mutexdef cm_lock;
	run mutexMonitor(cm_lock);
	run toConfigBlocks315(cm_lock,child_toConfigBlocks3150);
	child_toConfigBlocks3150?0;
	stop_process: skip;
	child!0
}
proctype toConfigBlocks315(Mutexdef cm_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_keys = -2; // opt var_keys
	int var_blocks = -2; // opt var_blocks
	int var_arrayBlock = -2; // opt var_arrayBlock
	int var_cm_registry_GetRegisteredNames = -2; // opt var_cm_registry_GetRegisteredNames
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
