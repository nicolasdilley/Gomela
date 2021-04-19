
// https://github.com/moby/moby/blob/master/volume/service/service.go#L40
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewVolumeService400 = [1] of {int};
	run NewVolumeService40(child_NewVolumeService400)
stop_process:skip
}

proctype NewVolumeService40(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef vs_db_statlock;
	Mutexdef vs_db_mmaplock;
	Mutexdef vs_db_metalock;
	Mutexdef vs_db_rwlock;
	Mutexdef vs_db_batch_start_m;
	Mutexdef vs_db_batchMu;
	Mutexdef vs_db_freelistLoad_m;
	Mutexdef vs_globalLock;
	Mutexdef vs_locks_mu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(vs_locks_mu);
	run mutexMonitor(vs_globalLock);
	run mutexMonitor(vs_db_freelistLoad_m);
	run mutexMonitor(vs_db_batchMu);
	run mutexMonitor(vs_db_batch_start_m);
	run mutexMonitor(vs_db_rwlock);
	run mutexMonitor(vs_db_metalock);
	run mutexMonitor(vs_db_mmaplock);
	run mutexMonitor(vs_db_statlock);
	

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

