// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/helm/helm/blob//pkg/downloader/manager_test.go#L99
#define def_var_tt_req  -2 // opt deps line 541
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGetRepoNames990 = [1] of {int};
	run TestGetRepoNames99(child_TestGetRepoNames990);
	run receiver(child_TestGetRepoNames990)
stop_process:skip
}

proctype TestGetRepoNames99(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_resolveRepoNames5410 = [1] of {int};
	int var_tt_req = def_var_tt_req;
	chan child_resolveRepoNames5411 = [1] of {int};
	int var_tt_req = def_var_tt_req;
	Mutexdef m_RegistryClient_cache_memoryStore_lock;
	int var_tests = -2; // opt var_tests
	run mutexMonitor(m_RegistryClient_cache_memoryStore_lock);
	

	if
	:: var_tests-1 != -3 -> 
				for(i : 0.. var_tests-1) {
			for10: skip;
			run resolveRepoNames541(m_RegistryClient_cache_memoryStore_lock,var_tt_req,child_resolveRepoNames5410);
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
			run resolveRepoNames541(m_RegistryClient_cache_memoryStore_lock,var_tt_req,child_resolveRepoNames5411);
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
proctype resolveRepoNames541(Mutexdef m_RegistryClient_cache_memoryStore_lock;int var_deps;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_missing = -2; // opt var_missing
	int var_repos = -2; // opt var_repos
	

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

proctype receiver(chan c) {
c?0
}

