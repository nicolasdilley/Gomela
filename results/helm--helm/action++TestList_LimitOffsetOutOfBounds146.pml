#define not_found_187  -2
#define not_found_194  -2

// https://github.com/helm/helm/blob/master/pkg/action/list_test.go#L146
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestList_LimitOffsetOutOfBounds1460 = [1] of {int};
	run TestList_LimitOffsetOutOfBounds146(child_TestList_LimitOffsetOutOfBounds1460)
stop_process:skip
}

proctype TestList_LimitOffsetOutOfBounds146(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Run1471 = [1] of {int};
	chan child_Run1470 = [1] of {int};
	Mutexdef lister_cfg_RegistryClient_cache_memoryStore_lock;
	run mutexMonitor(lister_cfg_RegistryClient_cache_memoryStore_lock);
	run Run147(lister_cfg_RegistryClient_cache_memoryStore_lock,child_Run1470);
	child_Run1470?0;
	run Run147(lister_cfg_RegistryClient_cache_memoryStore_lock,child_Run1471);
	child_Run1471?0;
	stop_process: skip;
	child!0
}
proctype Run147(Mutexdef l_cfg_RegistryClient_cache_memoryStore_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_sort2192 = [1] of {int};
	chan child_filterSelector2781 = [1] of {int};
	chan child_filterStateMask2630 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

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
	run filterStateMask263(l_cfg_RegistryClient_cache_memoryStore_lock,not_found_187,child_filterStateMask2630);
	child_filterStateMask2630?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run filterSelector278(l_cfg_RegistryClient_cache_memoryStore_lock,not_found_194,child_filterSelector2781);
	child_filterSelector2781?0;
	run sort219(l_cfg_RegistryClient_cache_memoryStore_lock,child_sort2192);
	child_sort2192?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype filterStateMask263(Mutexdef l_cfg_RegistryClient_cache_memoryStore_lock;int releases;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype filterSelector278(Mutexdef l_cfg_RegistryClient_cache_memoryStore_lock;int releases;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype sort219(Mutexdef l_cfg_RegistryClient_cache_memoryStore_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	fi;
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

