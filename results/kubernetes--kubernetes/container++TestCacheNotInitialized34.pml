
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/container/cache_test.go#L34
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCacheNotInitialized340 = [1] of {int};
	run TestCacheNotInitialized34(child_TestCacheNotInitialized340)
stop_process:skip
}

proctype TestCacheNotInitialized34(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getIfNewerThan1430 = [1] of {int};
	Mutexdef cache_lock;
	run mutexMonitor(cache_lock);
	run getIfNewerThan143(cache_lock,child_getIfNewerThan1430);
	child_getIfNewerThan1430?0;
	stop_process: skip;
	child!0
}
proctype getIfNewerThan143(Mutexdef c_lock;chan child) {
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

