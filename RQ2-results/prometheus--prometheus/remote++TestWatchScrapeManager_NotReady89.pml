
// https://github.com/prometheus/prometheus/blob/master/storage/remote/metadata_watcher_test.go#L89
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestWatchScrapeManager_NotReady890 = [1] of {int};
	run TestWatchScrapeManager_NotReady89(child_TestWatchScrapeManager_NotReady890)
stop_process:skip
}

proctype TestWatchScrapeManager_NotReady89(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewMetadataWatcher640 = [1] of {int};
	Mutexdef smm_manager_mtxScrape;
	run mutexMonitor(smm_manager_mtxScrape);
	run NewMetadataWatcher64(smm_manager_mtxScrape,child_NewMetadataWatcher640);
	child_NewMetadataWatcher640?0;
	stop_process: skip;
	child!0
}
proctype NewMetadataWatcher64(Mutexdef mg_manager_mtxScrape;chan child) {
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

