// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//common/ledger/blockledger/fileledger/impl_test.go#L262
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBlockRetrievalWithSnapshot2620 = [1] of {int};
	run TestBlockRetrievalWithSnapshot262(child_TestBlockRetrievalWithSnapshot2620);
	run receiver(child_TestBlockRetrievalWithSnapshot2620)
stop_process:skip
}

proctype TestBlockRetrievalWithSnapshot262(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewFileLedger360 = [1] of {int};
	Mutexdef blockStore_fileMgr_db_db_mutex;
	run mutexMonitor(blockStore_fileMgr_db_db_mutex);
	run NewFileLedger36(blockStore_fileMgr_db_db_mutex,child_NewFileLedger360);
	child_NewFileLedger360?0;
	stop_process: skip;
	child!0
}
proctype NewFileLedger36(Mutexdef blockStore_fileMgr_db_db_mutex;chan child) {
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

proctype receiver(chan c) {
c?0
}

