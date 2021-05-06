
// https://github.com/jaegertracing/jaeger/blob/master/plugin/storage/integration/badgerstore_test.go#L82
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
	chan child_TestBadgerStorage820 = [1] of {int};
	run TestBadgerStorage82(child_TestBadgerStorage820)
stop_process:skip
}

proctype TestBadgerStorage82(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_clear662 = [1] of {int};
	chan child_IntegrationTestAll3801 = [1] of {int};
	chan child_initialize350 = [1] of {int};
	Wgdef s_factory_cache_store_orc_closer_waiting;
	Mutexdef s_factory_cache_store_orc_writeChLock;
	Mutexdef s_factory_cache_store_closeOnce_m;
	Wgdef s_factory_cache_store_vlog_lfDiscardStats_closer_waiting;
	Mutexdef s_factory_cache_store_vlog_filesLock;
	Mutexdef s_factory_cache_store_manifest_appendLock;
	Wgdef s_factory_cache_store_closers_pub_waiting;
	Wgdef s_factory_cache_store_closers_valueGC_waiting;
	Wgdef s_factory_cache_store_closers_writes_waiting;
	Wgdef s_factory_cache_store_closers_memtable_waiting;
	Wgdef s_factory_cache_store_closers_compactors_waiting;
	Wgdef s_factory_cache_store_closers_updateSize_waiting;
	Mutexdef s_factory_cache_cacheLock;
	Wgdef s_factory_store_orc_closer_waiting;
	Mutexdef s_factory_store_orc_writeChLock;
	Mutexdef s_factory_store_closeOnce_m;
	Wgdef s_factory_store_vlog_lfDiscardStats_closer_waiting;
	Mutexdef s_factory_store_vlog_filesLock;
	Mutexdef s_factory_store_manifest_appendLock;
	Wgdef s_factory_store_closers_pub_waiting;
	Wgdef s_factory_store_closers_valueGC_waiting;
	Wgdef s_factory_store_closers_writes_waiting;
	Wgdef s_factory_store_closers_memtable_waiting;
	Wgdef s_factory_store_closers_compactors_waiting;
	Wgdef s_factory_store_closers_updateSize_waiting;
	run wgMonitor(s_factory_store_closers_updateSize_waiting);
	run wgMonitor(s_factory_store_closers_compactors_waiting);
	run wgMonitor(s_factory_store_closers_memtable_waiting);
	run wgMonitor(s_factory_store_closers_writes_waiting);
	run wgMonitor(s_factory_store_closers_valueGC_waiting);
	run wgMonitor(s_factory_store_closers_pub_waiting);
	run mutexMonitor(s_factory_store_manifest_appendLock);
	run mutexMonitor(s_factory_store_vlog_filesLock);
	run wgMonitor(s_factory_store_vlog_lfDiscardStats_closer_waiting);
	run mutexMonitor(s_factory_store_closeOnce_m);
	run mutexMonitor(s_factory_store_orc_writeChLock);
	run wgMonitor(s_factory_store_orc_closer_waiting);
	run mutexMonitor(s_factory_cache_cacheLock);
	run wgMonitor(s_factory_cache_store_closers_updateSize_waiting);
	run wgMonitor(s_factory_cache_store_closers_compactors_waiting);
	run wgMonitor(s_factory_cache_store_closers_memtable_waiting);
	run wgMonitor(s_factory_cache_store_closers_writes_waiting);
	run wgMonitor(s_factory_cache_store_closers_valueGC_waiting);
	run wgMonitor(s_factory_cache_store_closers_pub_waiting);
	run mutexMonitor(s_factory_cache_store_manifest_appendLock);
	run mutexMonitor(s_factory_cache_store_vlog_filesLock);
	run wgMonitor(s_factory_cache_store_vlog_lfDiscardStats_closer_waiting);
	run mutexMonitor(s_factory_cache_store_closeOnce_m);
	run mutexMonitor(s_factory_cache_store_orc_writeChLock);
	run wgMonitor(s_factory_cache_store_orc_closer_waiting);
	run initialize35(s_factory_store_orc_closer_waiting,s_factory_cache_store_closers_compactors_waiting,s_factory_cache_store_closers_writes_waiting,s_factory_cache_store_closers_valueGC_waiting,s_factory_cache_store_closers_pub_waiting,s_factory_store_closers_memtable_waiting,s_factory_cache_store_closers_memtable_waiting,s_factory_cache_store_vlog_lfDiscardStats_closer_waiting,s_factory_cache_store_orc_closer_waiting,s_factory_store_closers_updateSize_waiting,s_factory_store_closers_compactors_waiting,s_factory_store_closers_writes_waiting,s_factory_store_closers_valueGC_waiting,s_factory_store_closers_pub_waiting,s_factory_store_vlog_lfDiscardStats_closer_waiting,s_factory_cache_store_closers_updateSize_waiting,s_factory_store_manifest_appendLock,s_factory_store_vlog_filesLock,s_factory_store_closeOnce_m,s_factory_store_orc_writeChLock,s_factory_cache_cacheLock,s_factory_cache_store_manifest_appendLock,s_factory_cache_store_vlog_filesLock,s_factory_cache_store_closeOnce_m,s_factory_cache_store_orc_writeChLock,child_initialize350);
	child_initialize350?0;
	run IntegrationTestAll380(s_factory_store_closers_updateSize_waiting,s_factory_store_closers_compactors_waiting,s_factory_store_vlog_lfDiscardStats_closer_waiting,s_factory_cache_store_closers_updateSize_waiting,s_factory_store_closers_writes_waiting,s_factory_store_closers_valueGC_waiting,s_factory_store_closers_pub_waiting,s_factory_cache_store_closers_valueGC_waiting,s_factory_cache_store_closers_pub_waiting,s_factory_store_orc_closer_waiting,s_factory_cache_store_closers_compactors_waiting,s_factory_cache_store_closers_writes_waiting,s_factory_cache_store_orc_closer_waiting,s_factory_store_closers_memtable_waiting,s_factory_cache_store_closers_memtable_waiting,s_factory_cache_store_vlog_lfDiscardStats_closer_waiting,s_factory_store_manifest_appendLock,s_factory_store_vlog_filesLock,s_factory_store_closeOnce_m,s_factory_store_orc_writeChLock,s_factory_cache_cacheLock,s_factory_cache_store_manifest_appendLock,s_factory_cache_store_vlog_filesLock,s_factory_cache_store_closeOnce_m,s_factory_cache_store_orc_writeChLock,child_IntegrationTestAll3801);
	child_IntegrationTestAll3801?0;
	stop_process: skip;
		run clear66(s_factory_cache_store_closers_memtable_waiting,s_factory_cache_store_vlog_lfDiscardStats_closer_waiting,s_factory_cache_store_orc_closer_waiting,s_factory_store_closers_memtable_waiting,s_factory_store_closers_compactors_waiting,s_factory_store_closers_updateSize_waiting,s_factory_store_closers_valueGC_waiting,s_factory_store_closers_pub_waiting,s_factory_store_vlog_lfDiscardStats_closer_waiting,s_factory_cache_store_closers_updateSize_waiting,s_factory_store_closers_writes_waiting,s_factory_cache_store_closers_compactors_waiting,s_factory_cache_store_closers_writes_waiting,s_factory_cache_store_closers_valueGC_waiting,s_factory_cache_store_closers_pub_waiting,s_factory_store_orc_closer_waiting,s_factory_store_manifest_appendLock,s_factory_store_vlog_filesLock,s_factory_store_closeOnce_m,s_factory_store_orc_writeChLock,s_factory_cache_cacheLock,s_factory_cache_store_manifest_appendLock,s_factory_cache_store_vlog_filesLock,s_factory_cache_store_closeOnce_m,s_factory_cache_store_orc_writeChLock,child_clear662);
	child_clear662?0;
	child!0
}
proctype initialize35(Wgdef s_factory_store_orc_closer_waiting;Wgdef s_factory_cache_store_closers_compactors_waiting;Wgdef s_factory_cache_store_closers_writes_waiting;Wgdef s_factory_cache_store_closers_valueGC_waiting;Wgdef s_factory_cache_store_closers_pub_waiting;Wgdef s_factory_store_closers_memtable_waiting;Wgdef s_factory_cache_store_closers_memtable_waiting;Wgdef s_factory_cache_store_vlog_lfDiscardStats_closer_waiting;Wgdef s_factory_cache_store_orc_closer_waiting;Wgdef s_factory_store_closers_updateSize_waiting;Wgdef s_factory_store_closers_compactors_waiting;Wgdef s_factory_store_closers_writes_waiting;Wgdef s_factory_store_closers_valueGC_waiting;Wgdef s_factory_store_closers_pub_waiting;Wgdef s_factory_store_vlog_lfDiscardStats_closer_waiting;Wgdef s_factory_cache_store_closers_updateSize_waiting;Mutexdef s_factory_store_manifest_appendLock;Mutexdef s_factory_store_vlog_filesLock;Mutexdef s_factory_store_closeOnce_m;Mutexdef s_factory_store_orc_writeChLock;Mutexdef s_factory_cache_cacheLock;Mutexdef s_factory_cache_store_manifest_appendLock;Mutexdef s_factory_cache_store_vlog_filesLock;Mutexdef s_factory_cache_store_closeOnce_m;Mutexdef s_factory_cache_store_orc_writeChLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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
proctype IntegrationTestAll380(Wgdef s_factory_store_closers_updateSize_waiting;Wgdef s_factory_store_closers_compactors_waiting;Wgdef s_factory_store_vlog_lfDiscardStats_closer_waiting;Wgdef s_factory_cache_store_closers_updateSize_waiting;Wgdef s_factory_store_closers_writes_waiting;Wgdef s_factory_store_closers_valueGC_waiting;Wgdef s_factory_store_closers_pub_waiting;Wgdef s_factory_cache_store_closers_valueGC_waiting;Wgdef s_factory_cache_store_closers_pub_waiting;Wgdef s_factory_store_orc_closer_waiting;Wgdef s_factory_cache_store_closers_compactors_waiting;Wgdef s_factory_cache_store_closers_writes_waiting;Wgdef s_factory_cache_store_orc_closer_waiting;Wgdef s_factory_store_closers_memtable_waiting;Wgdef s_factory_cache_store_closers_memtable_waiting;Wgdef s_factory_cache_store_vlog_lfDiscardStats_closer_waiting;Mutexdef s_factory_store_manifest_appendLock;Mutexdef s_factory_store_vlog_filesLock;Mutexdef s_factory_store_closeOnce_m;Mutexdef s_factory_store_orc_writeChLock;Mutexdef s_factory_cache_cacheLock;Mutexdef s_factory_cache_store_manifest_appendLock;Mutexdef s_factory_cache_store_vlog_filesLock;Mutexdef s_factory_cache_store_closeOnce_m;Mutexdef s_factory_cache_store_orc_writeChLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype clear66(Wgdef s_factory_cache_store_closers_memtable_waiting;Wgdef s_factory_cache_store_vlog_lfDiscardStats_closer_waiting;Wgdef s_factory_cache_store_orc_closer_waiting;Wgdef s_factory_store_closers_memtable_waiting;Wgdef s_factory_store_closers_compactors_waiting;Wgdef s_factory_store_closers_updateSize_waiting;Wgdef s_factory_store_closers_valueGC_waiting;Wgdef s_factory_store_closers_pub_waiting;Wgdef s_factory_store_vlog_lfDiscardStats_closer_waiting;Wgdef s_factory_cache_store_closers_updateSize_waiting;Wgdef s_factory_store_closers_writes_waiting;Wgdef s_factory_cache_store_closers_compactors_waiting;Wgdef s_factory_cache_store_closers_writes_waiting;Wgdef s_factory_cache_store_closers_valueGC_waiting;Wgdef s_factory_cache_store_closers_pub_waiting;Wgdef s_factory_store_orc_closer_waiting;Mutexdef s_factory_store_manifest_appendLock;Mutexdef s_factory_store_vlog_filesLock;Mutexdef s_factory_store_closeOnce_m;Mutexdef s_factory_store_orc_writeChLock;Mutexdef s_factory_cache_cacheLock;Mutexdef s_factory_cache_store_manifest_appendLock;Mutexdef s_factory_cache_store_vlog_filesLock;Mutexdef s_factory_cache_store_closeOnce_m;Mutexdef s_factory_cache_store_orc_writeChLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

