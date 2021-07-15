
// https://github.com/mattermost/mattermost-server/blob/master/store/storetest/post_store.go#L2208
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_testPostStoreGetPostsCreatedAt22080 = [1] of {int};
	run testPostStoreGetPostsCreatedAt2208(child_testPostStoreGetPostsCreatedAt22080)
stop_process:skip
}

proctype testPostStoreGetPostsCreatedAt2208(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef o3_propsMu;
	Mutexdef o2_propsMu;
	Mutexdef o1_propsMu;
	Mutexdef o0_propsMu;
	run mutexMonitor(o0_propsMu);
	run mutexMonitor(o1_propsMu);
	run mutexMonitor(o2_propsMu);
	run mutexMonitor(o3_propsMu);
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

