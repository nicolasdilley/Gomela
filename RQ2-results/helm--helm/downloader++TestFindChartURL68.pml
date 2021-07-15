#define not_found_84  -2

// https://github.com/helm/helm/blob/master/pkg/downloader/manager_test.go#L68
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFindChartURL680 = [1] of {int};
	run TestFindChartURL68(child_TestFindChartURL680)
stop_process:skip
}

proctype TestFindChartURL68(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_findChartURL6881 = [1] of {int};
	chan child_loadChartRepositories7860 = [1] of {int};
	Mutexdef m_RegistryClient_cache_memoryStore_lock;
	run mutexMonitor(m_RegistryClient_cache_memoryStore_lock);
	run loadChartRepositories786(m_RegistryClient_cache_memoryStore_lock,child_loadChartRepositories7860);
	child_loadChartRepositories7860?0;
	run findChartURL688(m_RegistryClient_cache_memoryStore_lock,not_found_84,child_findChartURL6881);
	child_findChartURL6881?0;
	stop_process: skip;
	child!0
}
proctype loadChartRepositories786(Mutexdef m_RegistryClient_cache_memoryStore_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype findChartURL688(Mutexdef m_RegistryClient_cache_memoryStore_lock;int repos;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

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

