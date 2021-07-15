
// https://github.com/pingcap/tidb/blob/master/store/tikv/test_probe.go#L45
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
	chan child_Begin450 = [1] of {int};
	run Begin45(child_Begin450)
stop_process:skip
}

proctype Begin45(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef txn_committer_mu;
	Wgdef txn_committer_cleanWg;
	Mutexdef txn_committer_store_spMutex;
	Mutexdef txn_committer_store_lockResolver_mu;
	Mutexdef txn_committer_store_regionCache_storeMu;
	Mutexdef txn_committer_store_regionCache_mu_sorted_cow_freelist_mu;
	Mutexdef txn_committer_store_regionCache_mu_sorted_root_cow_freelist_mu;
	Mutexdef txn_mu;
	Mutexdef txn_store_spMutex;
	Mutexdef txn_store_lockResolver_mu;
	Mutexdef txn_store_regionCache_storeMu;
	Mutexdef txn_store_regionCache_mu_sorted_cow_freelist_mu;
	Mutexdef txn_store_regionCache_mu_sorted_root_cow_freelist_mu;
	Mutexdef txn_snapshot_mu;
	Mutexdef txn_snapshot_store_spMutex;
	Mutexdef txn_snapshot_store_lockResolver_mu;
	Mutexdef txn_snapshot_store_regionCache_storeMu;
	Mutexdef txn_snapshot_store_regionCache_mu_sorted_cow_freelist_mu;
	Mutexdef txn_snapshot_store_regionCache_mu_sorted_root_cow_freelist_mu;
	run mutexMonitor(txn_snapshot_store_regionCache_mu_sorted_root_cow_freelist_mu);
	run mutexMonitor(txn_snapshot_store_regionCache_mu_sorted_cow_freelist_mu);
	run mutexMonitor(txn_snapshot_store_regionCache_storeMu);
	run mutexMonitor(txn_snapshot_store_lockResolver_mu);
	run mutexMonitor(txn_snapshot_store_spMutex);
	run mutexMonitor(txn_snapshot_mu);
	run mutexMonitor(txn_store_regionCache_mu_sorted_root_cow_freelist_mu);
	run mutexMonitor(txn_store_regionCache_mu_sorted_cow_freelist_mu);
	run mutexMonitor(txn_store_regionCache_storeMu);
	run mutexMonitor(txn_store_lockResolver_mu);
	run mutexMonitor(txn_store_spMutex);
	run mutexMonitor(txn_mu);
	run mutexMonitor(txn_committer_store_regionCache_mu_sorted_root_cow_freelist_mu);
	run mutexMonitor(txn_committer_store_regionCache_mu_sorted_cow_freelist_mu);
	run mutexMonitor(txn_committer_store_regionCache_storeMu);
	run mutexMonitor(txn_committer_store_lockResolver_mu);
	run mutexMonitor(txn_committer_store_spMutex);
	run wgMonitor(txn_committer_cleanWg);
	run mutexMonitor(txn_committer_mu);
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

