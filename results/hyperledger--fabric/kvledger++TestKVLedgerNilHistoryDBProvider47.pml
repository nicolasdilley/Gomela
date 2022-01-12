// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//core/ledger/kvledger/kv_ledger_test.go#L47
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestKVLedgerNilHistoryDBProvider470 = [1] of {int};
	run TestKVLedgerNilHistoryDBProvider47(child_TestKVLedgerNilHistoryDBProvider470);
	run receiver(child_TestKVLedgerNilHistoryDBProvider470)
stop_process:skip
}

proctype TestKVLedgerNilHistoryDBProvider47(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewHistoryQueryExecutor5810 = [1] of {int};
	Mutexdef kvl_commitNotifierLock;
	Mutexdef kvl_blockAPIsRWLock;
	Mutexdef kvl_snapshotMgr_shutdownLock;
	Mutexdef kvl_historyDB_levelDB_db_mutex;
	Mutexdef kvl_txmgr_oldBlockCommit;
	Mutexdef kvl_txmgr_commitRWLock;
	Mutexdef kvl_pvtdataStore_purgerLock;
	Mutexdef kvl_pvtdataStore_db_db_mutex;
	run mutexMonitor(kvl_pvtdataStore_db_db_mutex);
	run mutexMonitor(kvl_pvtdataStore_purgerLock);
	run mutexMonitor(kvl_txmgr_commitRWLock);
	run mutexMonitor(kvl_txmgr_oldBlockCommit);
	run mutexMonitor(kvl_historyDB_levelDB_db_mutex);
	run mutexMonitor(kvl_snapshotMgr_shutdownLock);
	run mutexMonitor(kvl_blockAPIsRWLock);
	run mutexMonitor(kvl_commitNotifierLock);
	run NewHistoryQueryExecutor581(kvl_blockAPIsRWLock,kvl_commitNotifierLock,kvl_historyDB_levelDB_db_mutex,kvl_pvtdataStore_db_db_mutex,kvl_pvtdataStore_purgerLock,kvl_snapshotMgr_shutdownLock,kvl_txmgr_commitRWLock,kvl_txmgr_oldBlockCommit,child_NewHistoryQueryExecutor5810);
	child_NewHistoryQueryExecutor5810?0;
	stop_process: skip;
	child!0
}
proctype NewHistoryQueryExecutor581(Mutexdef l_blockAPIsRWLock;Mutexdef l_commitNotifierLock;Mutexdef l_historyDB_levelDB_db_mutex;Mutexdef l_pvtdataStore_db_db_mutex;Mutexdef l_pvtdataStore_purgerLock;Mutexdef l_snapshotMgr_shutdownLock;Mutexdef l_txmgr_commitRWLock;Mutexdef l_txmgr_oldBlockCommit;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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

proctype receiver(chan c) {
c?0
}

