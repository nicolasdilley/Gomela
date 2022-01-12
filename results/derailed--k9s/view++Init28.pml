// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/derailed/k9s/blob//internal/view/picker.go#L28
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Init280 = [1] of {int};
	run Init28(child_Init280);
	run receiver(child_Init280)
stop_process:skip
}

proctype Init28(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef app_clusterModel_cache_lock;
	Mutexdef app_clusterModel_cluster_cache_lock;
	Mutexdef app_factory_mx;
	Mutexdef app_command_mx;
	run mutexMonitor(app_command_mx);
	run mutexMonitor(app_factory_mx);
	run mutexMonitor(app_clusterModel_cluster_cache_lock);
	run mutexMonitor(app_clusterModel_cache_lock);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

