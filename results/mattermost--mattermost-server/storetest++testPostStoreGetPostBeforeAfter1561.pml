
// https://github.com/mattermost/mattermost-server/blob/master/store/storetest/post_store.go#L1561
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_testPostStoreGetPostBeforeAfter15610 = [1] of {int};
	run testPostStoreGetPostBeforeAfter1561(child_testPostStoreGetPostBeforeAfter15610)
stop_process:skip
}

proctype testPostStoreGetPostBeforeAfter1561(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef rPost3_propsMu;
	Mutexdef rPost2_propsMu;
	Mutexdef rPost1_propsMu;
	Mutexdef o2a_propsMu;
	Mutexdef o2_propsMu;
	Mutexdef otherChannelPost_propsMu;
	Mutexdef o0b_propsMu;
	Mutexdef o0a_propsMu;
	Mutexdef o1_propsMu;
	Mutexdef __propsMu;
	Mutexdef o0_propsMu;
	run mutexMonitor(o0_propsMu);
	run mutexMonitor(__propsMu);
	run mutexMonitor(o1_propsMu);
	run mutexMonitor(o0a_propsMu);
	run mutexMonitor(o0b_propsMu);
	run mutexMonitor(otherChannelPost_propsMu);
	run mutexMonitor(o2_propsMu);
	run mutexMonitor(o2a_propsMu);
	run mutexMonitor(rPost1_propsMu);
	run mutexMonitor(rPost2_propsMu);
	run mutexMonitor(rPost3_propsMu);
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

