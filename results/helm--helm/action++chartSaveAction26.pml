// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/helm/helm/blob//pkg/action/chart_save_test.go#L26
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_chartSaveAction260 = [1] of {int};
	run chartSaveAction26(child_chartSaveAction260);
	run receiver(child_chartSaveAction260)
stop_process:skip
}

proctype chartSaveAction26(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewChartSave320 = [1] of {int};
	Mutexdef config_RegistryClient_cache_memoryStore_lock;
	run mutexMonitor(config_RegistryClient_cache_memoryStore_lock);
	run NewChartSave32(config_RegistryClient_cache_memoryStore_lock,child_NewChartSave320);
	child_NewChartSave320?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewChartSave32(Mutexdef cfg_RegistryClient_cache_memoryStore_lock;chan child) {
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

