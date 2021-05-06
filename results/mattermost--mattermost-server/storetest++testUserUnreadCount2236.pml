
// https://github.com/mattermost/mattermost-server/blob/master/store/storetest/user_store.go#L2236
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_testUserUnreadCount22360 = [1] of {int};
	run testUserUnreadCount2236(child_testUserUnreadCount22360)
stop_process:skip
}

proctype testUserUnreadCount2236(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef p3_propsMu;
	Mutexdef p2_propsMu;
	Mutexdef p1_propsMu;
	run mutexMonitor(p1_propsMu);
	run mutexMonitor(p2_propsMu);
	run mutexMonitor(p3_propsMu);
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

