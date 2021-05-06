
// https://github.com/jaegertracing/jaeger/blob/master/plugin/storage/badger/factory_test.go#L192
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
	chan child_TestInitFromOptions1920 = [1] of {int};
	run TestInitFromOptions192(child_TestInitFromOptions1920)
stop_process:skip
}

proctype TestInitFromOptions192(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_InitFromOptions890 = [1] of {int};
	Wgdef f_cache_store_orc_closer_waiting;
	Mutexdef f_cache_store_orc_writeChLock;
	Mutexdef f_cache_store_closeOnce_m;
	Wgdef f_cache_store_vlog_lfDiscardStats_closer_waiting;
	Mutexdef f_cache_store_vlog_filesLock;
	Mutexdef f_cache_store_manifest_appendLock;
	Wgdef f_cache_store_closers_pub_waiting;
	Wgdef f_cache_store_closers_valueGC_waiting;
	Wgdef f_cache_store_closers_writes_waiting;
	Wgdef f_cache_store_closers_memtable_waiting;
	Wgdef f_cache_store_closers_compactors_waiting;
	Wgdef f_cache_store_closers_updateSize_waiting;
	Mutexdef f_cache_cacheLock;
	Wgdef f_store_orc_closer_waiting;
	Mutexdef f_store_orc_writeChLock;
	Mutexdef f_store_closeOnce_m;
	Wgdef f_store_vlog_lfDiscardStats_closer_waiting;
	Mutexdef f_store_vlog_filesLock;
	Mutexdef f_store_manifest_appendLock;
	Wgdef f_store_closers_pub_waiting;
	Wgdef f_store_closers_valueGC_waiting;
	Wgdef f_store_closers_writes_waiting;
	Wgdef f_store_closers_memtable_waiting;
	Wgdef f_store_closers_compactors_waiting;
	Wgdef f_store_closers_updateSize_waiting;
	run wgMonitor(f_store_closers_updateSize_waiting);
	run wgMonitor(f_store_closers_compactors_waiting);
	run wgMonitor(f_store_closers_memtable_waiting);
	run wgMonitor(f_store_closers_writes_waiting);
	run wgMonitor(f_store_closers_valueGC_waiting);
	run wgMonitor(f_store_closers_pub_waiting);
	run mutexMonitor(f_store_manifest_appendLock);
	run mutexMonitor(f_store_vlog_filesLock);
	run wgMonitor(f_store_vlog_lfDiscardStats_closer_waiting);
	run mutexMonitor(f_store_closeOnce_m);
	run mutexMonitor(f_store_orc_writeChLock);
	run wgMonitor(f_store_orc_closer_waiting);
	run mutexMonitor(f_cache_cacheLock);
	run wgMonitor(f_cache_store_closers_updateSize_waiting);
	run wgMonitor(f_cache_store_closers_compactors_waiting);
	run wgMonitor(f_cache_store_closers_memtable_waiting);
	run wgMonitor(f_cache_store_closers_writes_waiting);
	run wgMonitor(f_cache_store_closers_valueGC_waiting);
	run wgMonitor(f_cache_store_closers_pub_waiting);
	run mutexMonitor(f_cache_store_manifest_appendLock);
	run mutexMonitor(f_cache_store_vlog_filesLock);
	run wgMonitor(f_cache_store_vlog_lfDiscardStats_closer_waiting);
	run mutexMonitor(f_cache_store_closeOnce_m);
	run mutexMonitor(f_cache_store_orc_writeChLock);
	run wgMonitor(f_cache_store_orc_closer_waiting);
	run InitFromOptions89(f_store_closers_writes_waiting,f_store_closers_pub_waiting,f_cache_store_closers_writes_waiting,f_cache_store_closers_updateSize_waiting,f_cache_store_closers_valueGC_waiting,f_cache_store_orc_closer_waiting,f_store_closers_updateSize_waiting,f_store_closers_compactors_waiting,f_store_closers_memtable_waiting,f_cache_store_closers_compactors_waiting,f_cache_store_closers_memtable_waiting,f_store_closers_valueGC_waiting,f_store_vlog_lfDiscardStats_closer_waiting,f_store_orc_closer_waiting,f_cache_store_closers_pub_waiting,f_cache_store_vlog_lfDiscardStats_closer_waiting,f_store_manifest_appendLock,f_store_vlog_filesLock,f_store_closeOnce_m,f_store_orc_writeChLock,f_cache_cacheLock,f_cache_store_manifest_appendLock,f_cache_store_vlog_filesLock,f_cache_store_closeOnce_m,f_cache_store_orc_writeChLock,child_InitFromOptions890);
	child_InitFromOptions890?0;
	stop_process: skip;
	child!0
}
proctype InitFromOptions89(Wgdef f_store_closers_writes_waiting;Wgdef f_store_closers_pub_waiting;Wgdef f_cache_store_closers_writes_waiting;Wgdef f_cache_store_closers_updateSize_waiting;Wgdef f_cache_store_closers_valueGC_waiting;Wgdef f_cache_store_orc_closer_waiting;Wgdef f_store_closers_updateSize_waiting;Wgdef f_store_closers_compactors_waiting;Wgdef f_store_closers_memtable_waiting;Wgdef f_cache_store_closers_compactors_waiting;Wgdef f_cache_store_closers_memtable_waiting;Wgdef f_store_closers_valueGC_waiting;Wgdef f_store_vlog_lfDiscardStats_closer_waiting;Wgdef f_store_orc_closer_waiting;Wgdef f_cache_store_closers_pub_waiting;Wgdef f_cache_store_vlog_lfDiscardStats_closer_waiting;Mutexdef f_store_manifest_appendLock;Mutexdef f_store_vlog_filesLock;Mutexdef f_store_closeOnce_m;Mutexdef f_store_orc_writeChLock;Mutexdef f_cache_cacheLock;Mutexdef f_cache_store_manifest_appendLock;Mutexdef f_cache_store_vlog_filesLock;Mutexdef f_cache_store_closeOnce_m;Mutexdef f_cache_store_orc_writeChLock;chan child) {
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

