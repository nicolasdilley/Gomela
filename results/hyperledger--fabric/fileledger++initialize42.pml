// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//common/ledger/blockledger/fileledger/impl_test.go#L42
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_initialize420 = [1] of {int};
	run initialize42(child_initialize420);
	run receiver(child_initialize420)
stop_process:skip
}

proctype initialize42(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetOrCreate370 = [1] of {int};
	Mutexdef flf_removeFileRepo_mu;
	Mutexdef flf_mutex;
	run mutexMonitor(flf_mutex);
	run mutexMonitor(flf_removeFileRepo_mu);
	run GetOrCreate37(flf_mutex,flf_removeFileRepo_mu,child_GetOrCreate370);
	child_GetOrCreate370?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetOrCreate37(Mutexdef f_mutex;Mutexdef f_removeFileRepo_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewFileLedger360 = [1] of {int};
	Mutexdef blockStore_fileMgr_db_db_mutex;
	f_mutex.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	run mutexMonitor(blockStore_fileMgr_db_db_mutex);
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	run NewFileLedger36(blockStore_fileMgr_db_db_mutex,child_NewFileLedger360);
	child_NewFileLedger360?0;
	goto defer1;
		defer1: skip;
	f_mutex.Unlock!false;
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

