
// https://github.com/rclone/rclone/blob/master/fs/walk/walk_test.go#L279
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestWalkNDirTree2790 = [1] of {int};
	run TestWalkNDirTree279(child_TestWalkNDirTree2790)
stop_process:skip
}

proctype TestWalkNDirTree279(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef ls_t_context_mu;
	Mutexdef ls_t_context_match_mu;
	Mutexdef ls_mu;
	run mutexMonitor(ls_mu);
	run mutexMonitor(ls_t_context_match_mu);
	run mutexMonitor(ls_t_context_mu);
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

