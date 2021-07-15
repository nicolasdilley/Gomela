
// https://github.com/pingcap/tidb/blob/master/store/tikv/test_probe.go#L51
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_GetSnapshot510 = [1] of {int};
	run GetSnapshot51(child_GetSnapshot510)
stop_process:skip
}

proctype GetSnapshot51(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef snap_mu;
	Mutexdef snap_store_spMutex;
	Mutexdef snap_store_lockResolver_mu;
	Mutexdef snap_store_regionCache_storeMu;
	Mutexdef snap_store_regionCache_mu_sorted_cow_freelist_mu;
	Mutexdef snap_store_regionCache_mu_sorted_root_cow_freelist_mu;
	run mutexMonitor(snap_store_regionCache_mu_sorted_root_cow_freelist_mu);
	run mutexMonitor(snap_store_regionCache_mu_sorted_cow_freelist_mu);
	run mutexMonitor(snap_store_regionCache_storeMu);
	run mutexMonitor(snap_store_lockResolver_mu);
	run mutexMonitor(snap_store_spMutex);
	run mutexMonitor(snap_mu);
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

