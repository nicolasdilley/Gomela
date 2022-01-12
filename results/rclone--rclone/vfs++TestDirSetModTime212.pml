// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/rclone/rclone/blob//vfs/dir_test.go#L212
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDirSetModTime2120 = [1] of {int};
	run TestDirSetModTime212(child_TestDirSetModTime2120);
	run receiver(child_TestDirSetModTime2120)
stop_process:skip
}

proctype TestDirSetModTime212(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetModTime6784 = [1] of {int};
	chan child_ModTime6653 = [1] of {int};
	chan child_SetModTime6782 = [1] of {int};
	chan child_ModTime6651 = [1] of {int};
	chan child_SetModTime6780 = [1] of {int};
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
	run SetModTime678(dir_modTimeMu,dir_mu,dir_vfs_cache_kickerMu,dir_vfs_cache_mu,dir_vfs_cache_writeback_mu,dir_vfs_usageMu,child_SetModTime6780);
	child_SetModTime6780?0;
	run ModTime665(dir_modTimeMu,dir_mu,dir_vfs_cache_kickerMu,dir_vfs_cache_mu,dir_vfs_cache_writeback_mu,dir_vfs_usageMu,child_ModTime6651);
	child_ModTime6651?0;
	run SetModTime678(dir_modTimeMu,dir_mu,dir_vfs_cache_kickerMu,dir_vfs_cache_mu,dir_vfs_cache_writeback_mu,dir_vfs_usageMu,child_SetModTime6782);
	child_SetModTime6782?0;
	run ModTime665(dir_modTimeMu,dir_mu,dir_vfs_cache_kickerMu,dir_vfs_cache_mu,dir_vfs_cache_writeback_mu,dir_vfs_usageMu,child_ModTime6653);
	child_ModTime6653?0;
	run SetModTime678(dir_modTimeMu,dir_mu,dir_vfs_cache_kickerMu,dir_vfs_cache_mu,dir_vfs_cache_writeback_mu,dir_vfs_usageMu,child_SetModTime6784);
	child_SetModTime6784?0;
	stop_process: skip;
	child!0
}
proctype SetModTime678(Mutexdef d_modTimeMu;Mutexdef d_mu;Mutexdef d_vfs_cache_kickerMu;Mutexdef d_vfs_cache_mu;Mutexdef d_vfs_cache_writeback_mu;Mutexdef d_vfs_usageMu;chan child) {
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
proctype ModTime665(Mutexdef d_modTimeMu;Mutexdef d_mu;Mutexdef d_vfs_cache_kickerMu;Mutexdef d_vfs_cache_mu;Mutexdef d_vfs_cache_writeback_mu;Mutexdef d_vfs_usageMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	d_modTimeMu.Lock!false;
	goto defer1;
		defer1: skip;
	d_modTimeMu.Unlock!false;
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

proctype receiver(chan c) {
c?0
}

