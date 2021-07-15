
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/util/manager/cache_based_manager_test.go#L378
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCacheInvalidation3780 = [1] of {int};
	run TestCacheInvalidation378(child_TestCacheInvalidation3780)
stop_process:skip
}

proctype TestCacheInvalidation378(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get15512 = [1] of {int};
	chan child_Get15511 = [1] of {int};
	chan child_Get15510 = [1] of {int};
	chan child_Get1559 = [1] of {int};
	chan child_Get1558 = [1] of {int};
	chan child_Get1557 = [1] of {int};
	chan child_Get1556 = [1] of {int};
	chan child_Get1555 = [1] of {int};
	chan child_Get1554 = [1] of {int};
	chan child_Get1553 = [1] of {int};
	chan child_Get1552 = [1] of {int};
	chan child_Get1551 = [1] of {int};
	chan child_newCacheBasedSecretManager830 = [1] of {int};
	Mutexdef store_lock;
	run mutexMonitor(store_lock);
	run newCacheBasedSecretManager83(store_lock,child_newCacheBasedSecretManager830);
	child_newCacheBasedSecretManager830?0;
	run Get155(store_lock,child_Get1551);
	child_Get1551?0;
	run Get155(store_lock,child_Get1552);
	child_Get1552?0;
	run Get155(store_lock,child_Get1553);
	child_Get1553?0;
	run Get155(store_lock,child_Get1554);
	child_Get1554?0;
	run Get155(store_lock,child_Get1555);
	child_Get1555?0;
	run Get155(store_lock,child_Get1556);
	child_Get1556?0;
	run Get155(store_lock,child_Get1557);
	child_Get1557?0;
	run Get155(store_lock,child_Get1558);
	child_Get1558?0;
	run Get155(store_lock,child_Get1559);
	child_Get1559?0;
	run Get155(store_lock,child_Get15510);
	child_Get15510?0;
	run Get155(store_lock,child_Get15511);
	child_Get15511?0;
	run Get155(store_lock,child_Get15512);
	child_Get15512?0;
	stop_process: skip;
	child!0
}
proctype newCacheBasedSecretManager83(Mutexdef store_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewCacheBasedManager2660 = [1] of {int};
	run NewCacheBasedManager266(store_lock,child_NewCacheBasedManager2660);
	child_NewCacheBasedManager2660?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewCacheBasedManager266(Mutexdef objectStore_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Get155(Mutexdef s_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_isObjectFresh1471 = [1] of {int};
	s_lock.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
		s_lock.Unlock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run isObjectFresh147(s_lock,child_isObjectFresh1471);
	child_isObjectFresh1471?0;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype isObjectFresh147(Mutexdef s_lock;chan child) {
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

