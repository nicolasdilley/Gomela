
// https://github.com/moby/moby/blob/master/builder/builder-next/controller.go#L46
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_newController460 = [1] of {int};
	run newController46(child_newController460)
stop_process:skip
}

proctype newController46(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef wc_workers_mu;
	Mutexdef cacheStorage_db_statlock;
	Mutexdef cacheStorage_db_mmaplock;
	Mutexdef cacheStorage_db_metalock;
	Mutexdef cacheStorage_db_rwlock;
	Mutexdef cacheStorage_db_batch_start_m;
	Mutexdef cacheStorage_db_batchMu;
	Mutexdef cacheStorage_db_freelistLoad_m;
	Mutexdef md_db_statlock;
	Mutexdef md_db_mmaplock;
	Mutexdef md_db_metalock;
	Mutexdef md_db_rwlock;
	Mutexdef md_db_batch_start_m;
	Mutexdef md_db_batchMu;
	Mutexdef md_db_freelistLoad_m;
	Mutexdef mdb_wlock;
	Mutexdef mdb_cs_l;
	Mutexdef mdb_db_statlock;
	Mutexdef mdb_db_mmaplock;
	Mutexdef mdb_db_metalock;
	Mutexdef mdb_db_rwlock;
	Mutexdef mdb_db_batch_start_m;
	Mutexdef mdb_db_batchMu;
	Mutexdef mdb_db_freelistLoad_m;
	Mutexdef db_statlock;
	Mutexdef db_mmaplock;
	Mutexdef db_metalock;
	Mutexdef db_rwlock;
	Mutexdef db_batch_start_m;
	Mutexdef db_batchMu;
	Mutexdef db_freelistLoad_m;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(db_freelistLoad_m);
	run mutexMonitor(db_batchMu);
	run mutexMonitor(db_batch_start_m);
	run mutexMonitor(db_rwlock);
	run mutexMonitor(db_metalock);
	run mutexMonitor(db_mmaplock);
	run mutexMonitor(db_statlock);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(mdb_db_freelistLoad_m);
	run mutexMonitor(mdb_db_batchMu);
	run mutexMonitor(mdb_db_batch_start_m);
	run mutexMonitor(mdb_db_rwlock);
	run mutexMonitor(mdb_db_metalock);
	run mutexMonitor(mdb_db_mmaplock);
	run mutexMonitor(mdb_db_statlock);
	run mutexMonitor(mdb_cs_l);
	run mutexMonitor(mdb_wlock);
	

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
	run mutexMonitor(md_db_freelistLoad_m);
	run mutexMonitor(md_db_batchMu);
	run mutexMonitor(md_db_batch_start_m);
	run mutexMonitor(md_db_rwlock);
	run mutexMonitor(md_db_metalock);
	run mutexMonitor(md_db_mmaplock);
	run mutexMonitor(md_db_statlock);
	

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
	run mutexMonitor(cacheStorage_db_freelistLoad_m);
	run mutexMonitor(cacheStorage_db_batchMu);
	run mutexMonitor(cacheStorage_db_batch_start_m);
	run mutexMonitor(cacheStorage_db_rwlock);
	run mutexMonitor(cacheStorage_db_metalock);
	run mutexMonitor(cacheStorage_db_mmaplock);
	run mutexMonitor(cacheStorage_db_statlock);
	

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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(wc_workers_mu);
	

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

