// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/derailed/k9s/blob//internal/view/help_test.go#L13
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestHelp130 = [1] of {int};
	run TestHelp13(child_TestHelp130);
	run receiver(child_TestHelp130)
stop_process:skip
}

proctype TestHelp13(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewHelp380 = [1] of {int};
	Mutexdef app_clusterModel_cache_lock;
	Mutexdef app_clusterModel_cluster_cache_lock;
	Mutexdef app_factory_mx;
	Mutexdef app_command_mx;
	run mutexMonitor(app_command_mx);
	run mutexMonitor(app_factory_mx);
	run mutexMonitor(app_clusterModel_cluster_cache_lock);
	run mutexMonitor(app_clusterModel_cache_lock);
	run NewHelp38(app_clusterModel_cache_lock,app_clusterModel_cluster_cache_lock,app_command_mx,app_factory_mx,child_NewHelp380);
	child_NewHelp380?0;
	stop_process: skip;
	child!0
}
proctype NewHelp38(Mutexdef app_clusterModel_cache_lock;Mutexdef app_clusterModel_cluster_cache_lock;Mutexdef app_command_mx;Mutexdef app_factory_mx;chan child) {
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

