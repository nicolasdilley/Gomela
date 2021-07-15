
// https://github.com/mattermost/mattermost-server/blob/master/model/post_list_test.go#L129
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPostListToSlice1290 = [1] of {int};
	run TestPostListToSlice129(child_TestPostListToSlice1290)
stop_process:skip
}

proctype TestPostListToSlice129(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AddPost932 = [1] of {int};
	Mutexdef p3_propsMu;
	chan child_AddPost931 = [1] of {int};
	Mutexdef p2_propsMu;
	chan child_AddPost930 = [1] of {int};
	Mutexdef p1_propsMu;
	run mutexMonitor(p1_propsMu);
	run AddPost93(p1_propsMu,child_AddPost930);
	child_AddPost930?0;
	run mutexMonitor(p2_propsMu);
	run AddPost93(p2_propsMu,child_AddPost931);
	child_AddPost931?0;
	run mutexMonitor(p3_propsMu);
	run AddPost93(p3_propsMu,child_AddPost932);
	child_AddPost932?0;
	stop_process: skip;
	child!0
}
proctype AddPost93(Mutexdef post_propsMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

