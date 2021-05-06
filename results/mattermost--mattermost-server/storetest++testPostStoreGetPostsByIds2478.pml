
// https://github.com/mattermost/mattermost-server/blob/master/store/storetest/post_store.go#L2478
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_testPostStoreGetPostsByIds24780 = [1] of {int};
	run testPostStoreGetPostsByIds2478(child_testPostStoreGetPostsByIds24780)
stop_process:skip
}

proctype testPostStoreGetPostsByIds2478(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef ro3_propsMu;
	Mutexdef ro2_propsMu;
	Mutexdef ro1_propsMu;
	Mutexdef o3_propsMu;
	Mutexdef o2_propsMu;
	Mutexdef o1_propsMu;
	run mutexMonitor(o1_propsMu);
	run mutexMonitor(o2_propsMu);
	run mutexMonitor(o3_propsMu);
	run mutexMonitor(ro1_propsMu);
	run mutexMonitor(ro2_propsMu);
	run mutexMonitor(ro3_propsMu);
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

