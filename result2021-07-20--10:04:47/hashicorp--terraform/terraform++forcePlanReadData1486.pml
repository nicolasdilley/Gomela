// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/terraform/blob/c63c06d3c4d09a1bf1a1adc20216503e0cc2f881/terraform/node_resource_abstract_instance.go#L1486
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_forcePlanReadData14860 = [1] of {int};
	run forcePlanReadData1486(child_forcePlanReadData14860);
	run receiver(child_forcePlanReadData14860)
stop_process:skip
}

proctype forcePlanReadData1486(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef changes_lock;
	int var_changes_GetChangesForConfigResource_d_changes_GetChangesForConfigResource_d_ = -2; // opt var_changes_GetChangesForConfigResource_d_changes_GetChangesForConfigResource_d_
	int var_n_dependsOnn_dependsOn = -2; // opt var_n_dependsOnn_dependsOn
	run mutexMonitor(changes_lock);
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

