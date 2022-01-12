// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/helm/helm/blob//pkg/downloader/chart_downloader_test.go#L326
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestScanReposForURL3260 = [1] of {int};
	run TestScanReposForURL326(child_TestScanReposForURL3260);
	run receiver(child_TestScanReposForURL3260)
stop_process:skip
}

proctype TestScanReposForURL326(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_scanReposForURL3401 = [1] of {int};
	chan child_scanReposForURL3400 = [1] of {int};
	Mutexdef c_RegistryClient_cache_memoryStore_lock;
	run mutexMonitor(c_RegistryClient_cache_memoryStore_lock);
	run scanReposForURL340(c_RegistryClient_cache_memoryStore_lock,child_scanReposForURL3400);
	child_scanReposForURL3400?0;
	run scanReposForURL340(c_RegistryClient_cache_memoryStore_lock,child_scanReposForURL3401);
	child_scanReposForURL3401?0;
	stop_process: skip;
	child!0
}
proctype scanReposForURL340(Mutexdef c_RegistryClient_cache_memoryStore_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_ver_URLs = -2; // opt var_ver_URLs
	int var_entry = -2; // opt var_entry
	int var_i_Entries = -2; // opt var_i_Entries
	int var_rf_Repositories = -2; // opt var_rf_Repositories
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

