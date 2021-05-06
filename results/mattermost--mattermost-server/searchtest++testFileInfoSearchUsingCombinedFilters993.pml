
// https://github.com/mattermost/mattermost-server/blob/master/store/searchtest/file_info_layer.go#L993
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_testFileInfoSearchUsingCombinedFilters9930 = [1] of {int};
	run testFileInfoSearchUsingCombinedFilters993(child_testFileInfoSearchUsingCombinedFilters9930)
stop_process:skip
}

proctype testFileInfoSearchUsingCombinedFilters993(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef post2_propsMu;
	Mutexdef post1_propsMu;
	run mutexMonitor(post1_propsMu);
	run mutexMonitor(post2_propsMu);
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

