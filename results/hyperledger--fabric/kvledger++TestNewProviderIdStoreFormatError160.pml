// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//core/ledger/kvledger/kv_ledger_provider_test.go#L160
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
	chan child_TestNewProviderIdStoreFormatError1600 = [1] of {int};
	run TestNewProviderIdStoreFormatError160(child_TestNewProviderIdStoreFormatError1600);
	run receiver(child_TestNewProviderIdStoreFormatError1600)
stop_process:skip
}

proctype TestNewProviderIdStoreFormatError160(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Wgdef __fileLock_db_closeW;
	Mutexdef __fileLock_db_compStats_lk;
	Mutexdef __fileLock_db_compCommitLk;
	Mutexdef __fileLock_db_tr_lk;
	Mutexdef __fileLock_db_snapsMu;
	Mutexdef __fileLock_db_memMu;
	Mutexdef __fileLock_db_s_vmu;
	Wgdef __fileLock_db_s_closeW;
	Mutexdef __bookkeepingProvider_dbProvider_mux;
	Mutexdef __bookkeepingProvider_dbProvider_db_mutex;
	Mutexdef __historydbProvider_leveldbProvider_mux;
	Mutexdef __historydbProvider_leveldbProvider_db_mutex;
	Mutexdef __dbProvider_bookkeepingProvider_dbProvider_mux;
	Mutexdef __pvtdataStoreProvider_dbProvider_mux;
	Mutexdef __pvtdataStoreProvider_dbProvider_db_mutex;
	Mutexdef __blkStoreProvider_leveldbProvider_mux;
	Mutexdef __blkStoreProvider_leveldbProvider_db_mutex;
	Mutexdef __idStore_db_mutex;
	Wgdef __idStore_db_db_closeW;
	Mutexdef __idStore_db_db_compCommitLk;
	Mutexdef __idStore_db_db_snapsMu;
	Mutexdef __idStore_db_db_memMu;
	run mutexMonitor(__idStore_db_db_memMu);
	run mutexMonitor(__idStore_db_db_snapsMu);
	run mutexMonitor(__idStore_db_db_compCommitLk);
	run wgMonitor(__idStore_db_db_closeW);
	run mutexMonitor(__idStore_db_mutex);
	run mutexMonitor(__blkStoreProvider_leveldbProvider_db_mutex);
	run mutexMonitor(__blkStoreProvider_leveldbProvider_mux);
	run mutexMonitor(__pvtdataStoreProvider_dbProvider_db_mutex);
	run mutexMonitor(__pvtdataStoreProvider_dbProvider_mux);
	run mutexMonitor(__dbProvider_bookkeepingProvider_dbProvider_mux);
	run mutexMonitor(__historydbProvider_leveldbProvider_db_mutex);
	run mutexMonitor(__historydbProvider_leveldbProvider_mux);
	run mutexMonitor(__bookkeepingProvider_dbProvider_db_mutex);
	run mutexMonitor(__bookkeepingProvider_dbProvider_mux);
	run wgMonitor(__fileLock_db_s_closeW);
	run mutexMonitor(__fileLock_db_s_vmu);
	run mutexMonitor(__fileLock_db_memMu);
	run mutexMonitor(__fileLock_db_snapsMu);
	run mutexMonitor(__fileLock_db_tr_lk);
	run mutexMonitor(__fileLock_db_compCommitLk);
	run mutexMonitor(__fileLock_db_compStats_lk);
	run wgMonitor(__fileLock_db_closeW);
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

proctype receiver(chan c) {
c?0
}

