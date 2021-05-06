
// https://github.com/rclone/rclone/blob/master/vfs/rc_test.go#L80
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRcRefresh800 = [1] of {int};
	run TestRcRefresh80(child_TestRcRefresh800)
stop_process:skip
}

proctype TestRcRefresh80(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef vfs_usageMu;
	Mutexdef vfs_cache_kickerMu;
	Mutexdef vfs_cache_mu;
	Mutexdef vfs_cache_writeback_mu;
	Mutexdef vfs_root_modTimeMu;
	Mutexdef vfs_root_mu;
	run mutexMonitor(vfs_root_mu);
	run mutexMonitor(vfs_root_modTimeMu);
	run mutexMonitor(vfs_cache_writeback_mu);
	run mutexMonitor(vfs_cache_mu);
	run mutexMonitor(vfs_cache_kickerMu);
	run mutexMonitor(vfs_usageMu);
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

