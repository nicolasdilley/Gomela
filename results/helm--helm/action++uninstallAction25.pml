// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/helm/helm/blob//pkg/action/uninstall_test.go#L25
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_uninstallAction250 = [1] of {int};
	run uninstallAction25(child_uninstallAction250);
	run receiver(child_uninstallAction250)
stop_process:skip
}

proctype uninstallAction25(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewUninstall450 = [1] of {int};
	Mutexdef config_RegistryClient_cache_memoryStore_lock;
	run mutexMonitor(config_RegistryClient_cache_memoryStore_lock);
	run NewUninstall45(config_RegistryClient_cache_memoryStore_lock,child_NewUninstall450);
	child_NewUninstall450?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewUninstall45(Mutexdef cfg_RegistryClient_cache_memoryStore_lock;chan child) {
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

