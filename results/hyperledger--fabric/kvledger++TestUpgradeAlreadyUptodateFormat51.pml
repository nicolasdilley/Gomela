// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//core/ledger/kvledger/upgrade_dbs_test.go#L51
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
	chan child_TestUpgradeAlreadyUptodateFormat510 = [1] of {int};
	run TestUpgradeAlreadyUptodateFormat51(child_TestUpgradeAlreadyUptodateFormat510);
	run receiver(child_TestUpgradeAlreadyUptodateFormat510)
stop_process:skip
}

proctype TestUpgradeAlreadyUptodateFormat51(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close3960 = [1] of {int};
	Wgdef provider_fileLock_db_closeW;
	Mutexdef provider_fileLock_db_compStats_lk;
	Mutexdef provider_fileLock_db_compCommitLk;
	Mutexdef provider_fileLock_db_tr_lk;
	Mutexdef provider_fileLock_db_snapsMu;
	Mutexdef provider_fileLock_db_memMu;
	Mutexdef provider_fileLock_db_s_vmu;
	Wgdef provider_fileLock_db_s_closeW;
	Mutexdef provider_bookkeepingProvider_dbProvider_mux;
	Mutexdef provider_bookkeepingProvider_dbProvider_db_mutex;
	Mutexdef provider_historydbProvider_leveldbProvider_mux;
	Mutexdef provider_historydbProvider_leveldbProvider_db_mutex;
	Mutexdef provider_dbProvider_bookkeepingProvider_dbProvider_mux;
	Mutexdef provider_pvtdataStoreProvider_dbProvider_mux;
	Mutexdef provider_pvtdataStoreProvider_dbProvider_db_mutex;
	Mutexdef provider_blkStoreProvider_leveldbProvider_mux;
	Mutexdef provider_blkStoreProvider_leveldbProvider_db_mutex;
	Mutexdef provider_idStore_db_mutex;
	Wgdef provider_idStore_db_db_closeW;
	Mutexdef provider_idStore_db_db_compCommitLk;
	Mutexdef provider_idStore_db_db_snapsMu;
	Mutexdef provider_idStore_db_db_memMu;
	run mutexMonitor(provider_idStore_db_db_memMu);
	run mutexMonitor(provider_idStore_db_db_snapsMu);
	run mutexMonitor(provider_idStore_db_db_compCommitLk);
	run wgMonitor(provider_idStore_db_db_closeW);
	run mutexMonitor(provider_idStore_db_mutex);
	run mutexMonitor(provider_blkStoreProvider_leveldbProvider_db_mutex);
	run mutexMonitor(provider_blkStoreProvider_leveldbProvider_mux);
	run mutexMonitor(provider_pvtdataStoreProvider_dbProvider_db_mutex);
	run mutexMonitor(provider_pvtdataStoreProvider_dbProvider_mux);
	run mutexMonitor(provider_dbProvider_bookkeepingProvider_dbProvider_mux);
	run mutexMonitor(provider_historydbProvider_leveldbProvider_db_mutex);
	run mutexMonitor(provider_historydbProvider_leveldbProvider_mux);
	run mutexMonitor(provider_bookkeepingProvider_dbProvider_db_mutex);
	run mutexMonitor(provider_bookkeepingProvider_dbProvider_mux);
	run wgMonitor(provider_fileLock_db_s_closeW);
	run mutexMonitor(provider_fileLock_db_s_vmu);
	run mutexMonitor(provider_fileLock_db_memMu);
	run mutexMonitor(provider_fileLock_db_snapsMu);
	run mutexMonitor(provider_fileLock_db_tr_lk);
	run mutexMonitor(provider_fileLock_db_compCommitLk);
	run mutexMonitor(provider_fileLock_db_compStats_lk);
	run wgMonitor(provider_fileLock_db_closeW);
	run Close396(provider_fileLock_db_closeW,provider_fileLock_db_s_closeW,provider_idStore_db_db_closeW,provider_blkStoreProvider_leveldbProvider_db_mutex,provider_blkStoreProvider_leveldbProvider_mux,provider_bookkeepingProvider_dbProvider_db_mutex,provider_bookkeepingProvider_dbProvider_mux,provider_dbProvider_bookkeepingProvider_dbProvider_mux,provider_fileLock_db_compCommitLk,provider_fileLock_db_compStats_lk,provider_fileLock_db_memMu,provider_fileLock_db_s_vmu,provider_fileLock_db_snapsMu,provider_fileLock_db_tr_lk,provider_historydbProvider_leveldbProvider_db_mutex,provider_historydbProvider_leveldbProvider_mux,provider_idStore_db_db_compCommitLk,provider_idStore_db_db_memMu,provider_idStore_db_db_snapsMu,provider_idStore_db_mutex,provider_pvtdataStoreProvider_dbProvider_db_mutex,provider_pvtdataStoreProvider_dbProvider_mux,child_Close3960);
	child_Close3960?0;
	stop_process: skip;
	child!0
}
proctype Close396(Wgdef p_fileLock_db_closeW;Wgdef p_fileLock_db_s_closeW;Wgdef p_idStore_db_db_closeW;Mutexdef p_blkStoreProvider_leveldbProvider_db_mutex;Mutexdef p_blkStoreProvider_leveldbProvider_mux;Mutexdef p_bookkeepingProvider_dbProvider_db_mutex;Mutexdef p_bookkeepingProvider_dbProvider_mux;Mutexdef p_dbProvider_bookkeepingProvider_dbProvider_mux;Mutexdef p_fileLock_db_compCommitLk;Mutexdef p_fileLock_db_compStats_lk;Mutexdef p_fileLock_db_memMu;Mutexdef p_fileLock_db_s_vmu;Mutexdef p_fileLock_db_snapsMu;Mutexdef p_fileLock_db_tr_lk;Mutexdef p_historydbProvider_leveldbProvider_db_mutex;Mutexdef p_historydbProvider_leveldbProvider_mux;Mutexdef p_idStore_db_db_compCommitLk;Mutexdef p_idStore_db_db_memMu;Mutexdef p_idStore_db_db_snapsMu;Mutexdef p_idStore_db_mutex;Mutexdef p_pvtdataStoreProvider_dbProvider_db_mutex;Mutexdef p_pvtdataStoreProvider_dbProvider_mux;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_close6990 = [1] of {int};
	

	if
	:: true -> 
		run close699(p_idStore_db_db_closeW,p_idStore_db_db_compCommitLk,p_idStore_db_db_memMu,p_idStore_db_db_snapsMu,p_idStore_db_mutex,child_close6990);
		child_close6990?0
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype close699(Wgdef s_db_db_closeW;Mutexdef s_db_db_compCommitLk;Mutexdef s_db_db_memMu;Mutexdef s_db_db_snapsMu;Mutexdef s_db_mutex;chan child) {
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

proctype receiver(chan c) {
c?0
}

