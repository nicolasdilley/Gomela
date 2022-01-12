// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/derailed/k9s/blob//internal/client/client_test.go#L10
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCheckCacheBool100 = [1] of {int};
	run TestCheckCacheBool10(child_TestCheckCacheBool100);
	run receiver(child_TestCheckCacheBool100)
stop_process:skip
}

proctype TestCheckCacheBool10(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef c_cache_lock;
	Mutexdef c_mx;
	Mutexdef c_config_mutex;
	Mutexdef c_config_flags_lock;
	Mutexdef c_cachedClient_mutex;
	int var_uu = -2; // opt var_uu
	run mutexMonitor(c_cachedClient_mutex);
	run mutexMonitor(c_config_flags_lock);
	run mutexMonitor(c_config_mutex);
	run mutexMonitor(c_mx);
	run mutexMonitor(c_cache_lock);
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

