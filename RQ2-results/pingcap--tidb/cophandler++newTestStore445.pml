
// https://github.com/pingcap/tidb/blob/master/store/mockstore/unistore/cophandler/cop_handler_test.go#L445
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_newTestStore4450 = [1] of {int};
	run newTestStore445(child_newTestStore4450)
stop_process:skip
}

proctype newTestStore445(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef db_blobManger_filesLock;
	Mutexdef db_limiter_mu;
	Mutexdef db_orc_writeLock;
	Mutexdef db_manifest_appendLock;
	Wgdef db_closers_writes_waiting;
	Wgdef db_closers_memtable_waiting;
	Wgdef db_closers_blobManager_waiting;
	Wgdef db_closers_resourceManager_waiting;
	Wgdef db_closers_compactors_waiting;
	Wgdef db_closers_updateSize_waiting;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(db_closers_updateSize_waiting);
	run wgMonitor(db_closers_compactors_waiting);
	run wgMonitor(db_closers_resourceManager_waiting);
	run wgMonitor(db_closers_blobManager_waiting);
	run wgMonitor(db_closers_memtable_waiting);
	run wgMonitor(db_closers_writes_waiting);
	run mutexMonitor(db_manifest_appendLock);
	run mutexMonitor(db_orc_writeLock);
	run mutexMonitor(db_limiter_mu);
	run mutexMonitor(db_blobManger_filesLock);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

