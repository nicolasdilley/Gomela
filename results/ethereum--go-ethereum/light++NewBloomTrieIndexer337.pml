
// https://github.com/ethereum/go-ethereum/blob/master/light/postprocess.go#L337
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewBloomTrieIndexer3370 = [1] of {int};
	run NewBloomTrieIndexer337(child_NewBloomTrieIndexer3370)
stop_process:skip
}

proctype NewBloomTrieIndexer337(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef backend_trie_db_lock;
	Mutexdef backend_triedb_lock;
	run mutexMonitor(backend_triedb_lock);
	run mutexMonitor(backend_trie_db_lock);
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

