#define not_found_164  -2

// https://github.com/helm/helm/blob/master/pkg/downloader/manager_test.go#L99
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGetRepoNames990 = [1] of {int};
	run TestGetRepoNames99(child_TestGetRepoNames990)
stop_process:skip
}

proctype TestGetRepoNames99(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_resolveRepoNames5410 = [1] of {int};
	chan child_resolveRepoNames5411 = [1] of {int};
	Mutexdef m_RegistryClient_cache_memoryStore_lock;
	int tests = -2;
	run mutexMonitor(m_RegistryClient_cache_memoryStore_lock);
	

	if
	:: tests-1 != -3 -> 
				for(i : 0.. tests-1) {
			for10: skip;
			run resolveRepoNames541(m_RegistryClient_cache_memoryStore_lock,not_found_164,child_resolveRepoNames5410);
			child_resolveRepoNames5410?0;
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto for18_end
				:: true;
				fi
			:: true;
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for19: skip;
			run resolveRepoNames541(m_RegistryClient_cache_memoryStore_lock,not_found_164,child_resolveRepoNames5411);
			child_resolveRepoNames5411?0;
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto for19_end
				:: true;
				fi
			:: true;
			fi;
			for19_end: skip
		:: true -> 
			break
		od;
		for19_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype resolveRepoNames541(Mutexdef m_RegistryClient_cache_memoryStore_lock;int deps;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
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

