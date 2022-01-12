// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/ethereum/go-ethereum/blob//core/state/iterator_test.go#L28
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNodeIteratorCoverage280 = [1] of {int};
	run TestNodeIteratorCoverage28(child_TestNodeIteratorCoverage280);
	run receiver(child_TestNodeIteratorCoverage280)
stop_process:skip
}

proctype TestNodeIteratorCoverage28(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewNodeIterator470 = [1] of {int};
	Mutexdef it_state_snaps_lock;
	Mutexdef it_state_snaps_triedb_lock;
	Mutexdef state_snaps_lock;
	Mutexdef state_snaps_triedb_lock;
	int var_db_TrieDB_Nodes = -2; // opt var_db_TrieDB_Nodes
	int var_hashes = -2; // opt var_hashes
	run mutexMonitor(state_snaps_triedb_lock);
	run mutexMonitor(state_snaps_lock);
	run mutexMonitor(it_state_snaps_triedb_lock);
	run mutexMonitor(it_state_snaps_lock);
	run NewNodeIterator47(state_snaps_lock,state_snaps_triedb_lock,child_NewNodeIterator470);
	child_NewNodeIterator470?0;
	stop_process: skip;
	child!0
}
proctype NewNodeIterator47(Mutexdef state_snaps_lock;Mutexdef state_snaps_triedb_lock;chan child) {
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

