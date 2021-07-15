
// https://github.com/rclone/rclone/blob/master/vfs/dir_test.go#L212
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDirSetModTime2120 = [1] of {int};
	run TestDirSetModTime212(child_TestDirSetModTime2120)
stop_process:skip
}

proctype TestDirSetModTime212(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetModTime7554 = [1] of {int};
	chan child_ModTime7423 = [1] of {int};
	chan child_SetModTime7552 = [1] of {int};
	chan child_ModTime7421 = [1] of {int};
	chan child_SetModTime7550 = [1] of {int};
	Mutexdef dir_modTimeMu;
	Mutexdef dir_mu;
	Mutexdef dir_vfs_usageMu;
	Mutexdef dir_vfs_cache_kickerMu;
	Mutexdef dir_vfs_cache_mu;
	Mutexdef dir_vfs_cache_writeback_mu;
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
	run mutexMonitor(dir_vfs_cache_writeback_mu);
	run mutexMonitor(dir_vfs_cache_mu);
	run mutexMonitor(dir_vfs_cache_kickerMu);
	run mutexMonitor(dir_vfs_usageMu);
	run mutexMonitor(dir_mu);
	run mutexMonitor(dir_modTimeMu);
	run SetModTime755(dir_vfs_cache_writeback_mu,dir_vfs_cache_mu,dir_vfs_cache_kickerMu,dir_vfs_usageMu,dir_mu,dir_modTimeMu,child_SetModTime7550);
	child_SetModTime7550?0;
	run ModTime742(dir_vfs_cache_writeback_mu,dir_vfs_cache_mu,dir_vfs_cache_kickerMu,dir_vfs_usageMu,dir_mu,dir_modTimeMu,child_ModTime7421);
	child_ModTime7421?0;
	run SetModTime755(dir_vfs_cache_writeback_mu,dir_vfs_cache_mu,dir_vfs_cache_kickerMu,dir_vfs_usageMu,dir_mu,dir_modTimeMu,child_SetModTime7552);
	child_SetModTime7552?0;
	run ModTime742(dir_vfs_cache_writeback_mu,dir_vfs_cache_mu,dir_vfs_cache_kickerMu,dir_vfs_usageMu,dir_mu,dir_modTimeMu,child_ModTime7423);
	child_ModTime7423?0;
	run SetModTime755(dir_vfs_cache_writeback_mu,dir_vfs_cache_mu,dir_vfs_cache_kickerMu,dir_vfs_usageMu,dir_mu,dir_modTimeMu,child_SetModTime7554);
	child_SetModTime7554?0;
	stop_process: skip;
	child!0
}
proctype SetModTime755(Mutexdef d_vfs_cache_writeback_mu;Mutexdef d_vfs_cache_mu;Mutexdef d_vfs_cache_kickerMu;Mutexdef d_vfs_usageMu;Mutexdef d_mu;Mutexdef d_modTimeMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	d_modTimeMu.Lock!false;
	d_modTimeMu.Unlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ModTime742(Mutexdef d_vfs_cache_writeback_mu;Mutexdef d_vfs_cache_mu;Mutexdef d_vfs_cache_kickerMu;Mutexdef d_vfs_usageMu;Mutexdef d_mu;Mutexdef d_modTimeMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	d_modTimeMu.Lock!false;
	goto stop_process;
	stop_process: skip;
		d_modTimeMu.Unlock!false;
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

