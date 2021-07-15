
// https://github.com/pingcap/tidb/blob/master/store/tikv/test_probe.go#L108
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
	chan child_NewCommitter1080 = [1] of {int};
	run NewCommitter108(child_NewCommitter1080)
stop_process:skip
}

proctype NewCommitter108(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef committer_mu;
	Wgdef committer_cleanWg;
	Mutexdef committer_txn_mu;
	Mutexdef committer_txn_store_spMutex;
	Mutexdef committer_txn_store_lockResolver_mu;
	Mutexdef committer_txn_store_regionCache_storeMu;
	Mutexdef committer_txn_store_regionCache_mu_sorted_cow_freelist_mu;
	Mutexdef committer_txn_store_regionCache_mu_sorted_root_cow_freelist_mu;
	Mutexdef committer_txn_snapshot_mu;
	Mutexdef committer_txn_snapshot_store_spMutex;
	Mutexdef committer_txn_snapshot_store_lockResolver_mu;
	Mutexdef committer_txn_snapshot_store_regionCache_storeMu;
	Mutexdef committer_txn_snapshot_store_regionCache_mu_sorted_cow_freelist_mu;
	Mutexdef committer_txn_snapshot_store_regionCache_mu_sorted_root_cow_freelist_mu;
	Mutexdef committer_store_spMutex;
	Mutexdef committer_store_lockResolver_mu;
	Mutexdef committer_store_regionCache_storeMu;
	Mutexdef committer_store_regionCache_mu_sorted_cow_freelist_mu;
	Mutexdef committer_store_regionCache_mu_sorted_root_cow_freelist_mu;
	run mutexMonitor(committer_store_regionCache_mu_sorted_root_cow_freelist_mu);
	run mutexMonitor(committer_store_regionCache_mu_sorted_cow_freelist_mu);
	run mutexMonitor(committer_store_regionCache_storeMu);
	run mutexMonitor(committer_store_lockResolver_mu);
	run mutexMonitor(committer_store_spMutex);
	run mutexMonitor(committer_txn_snapshot_store_regionCache_mu_sorted_root_cow_freelist_mu);
	run mutexMonitor(committer_txn_snapshot_store_regionCache_mu_sorted_cow_freelist_mu);
	run mutexMonitor(committer_txn_snapshot_store_regionCache_storeMu);
	run mutexMonitor(committer_txn_snapshot_store_lockResolver_mu);
	run mutexMonitor(committer_txn_snapshot_store_spMutex);
	run mutexMonitor(committer_txn_snapshot_mu);
	run mutexMonitor(committer_txn_store_regionCache_mu_sorted_root_cow_freelist_mu);
	run mutexMonitor(committer_txn_store_regionCache_mu_sorted_cow_freelist_mu);
	run mutexMonitor(committer_txn_store_regionCache_storeMu);
	run mutexMonitor(committer_txn_store_lockResolver_mu);
	run mutexMonitor(committer_txn_store_spMutex);
	run mutexMonitor(committer_txn_mu);
	run wgMonitor(committer_cleanWg);
	run mutexMonitor(committer_mu);
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

