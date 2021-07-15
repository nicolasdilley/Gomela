
// https://github.com/mattermost/mattermost-server/blob/master/store/storetest/post_store.go#L1449
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_testPostStoreGetPosts14490 = [1] of {int};
	run testPostStoreGetPosts1449(child_testPostStoreGetPosts14490)
stop_process:skip
}

proctype testPostStoreGetPosts1449(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef post6_propsMu;
	Mutexdef post5_propsMu;
	Mutexdef post4_propsMu;
	Mutexdef post3_propsMu;
	Mutexdef post2_propsMu;
	Mutexdef post1_propsMu;
	run mutexMonitor(post1_propsMu);
	run mutexMonitor(post2_propsMu);
	run mutexMonitor(post3_propsMu);
	run mutexMonitor(post4_propsMu);
	run mutexMonitor(post5_propsMu);
	run mutexMonitor(post6_propsMu);
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

