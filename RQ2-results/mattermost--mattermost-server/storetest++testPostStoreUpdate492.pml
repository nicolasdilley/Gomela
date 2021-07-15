
// https://github.com/mattermost/mattermost-server/blob/master/store/storetest/post_store.go#L492
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_testPostStoreUpdate4920 = [1] of {int};
	run testPostStoreUpdate492(child_testPostStoreUpdate4920)
stop_process:skip
}

proctype testPostStoreUpdate492(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef ro4a_propsMu;
	Mutexdef o4a_propsMu;
	Mutexdef ro4_propsMu;
	Mutexdef o4_propsMu;
	Mutexdef ro3a_propsMu;
	Mutexdef o3a_propsMu;
	Mutexdef ro2a_propsMu;
	Mutexdef o2a_propsMu;
	Mutexdef ro1a_propsMu;
	Mutexdef o1a_propsMu;
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
	run mutexMonitor(o1a_propsMu);
	run mutexMonitor(ro1a_propsMu);
	run mutexMonitor(o2a_propsMu);
	run mutexMonitor(ro2a_propsMu);
	run mutexMonitor(o3a_propsMu);
	run mutexMonitor(ro3a_propsMu);
	run mutexMonitor(o4_propsMu);
	run mutexMonitor(ro4_propsMu);
	run mutexMonitor(o4a_propsMu);
	run mutexMonitor(ro4a_propsMu);
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

