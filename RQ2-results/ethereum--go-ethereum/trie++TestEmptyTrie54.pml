
// https://github.com/ethereum/go-ethereum/blob/master/trie/trie_test.go#L54
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestEmptyTrie540 = [1] of {int};
	run TestEmptyTrie54(child_TestEmptyTrie540)
stop_process:skip
}

proctype TestEmptyTrie54(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Hash5010 = [1] of {int};
	Mutexdef trie_db_lock;
	run mutexMonitor(trie_db_lock);
	run Hash501(trie_db_lock,child_Hash5010);
	child_Hash5010?0;
	stop_process: skip;
	child!0
}
proctype Hash501(Mutexdef t_db_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_hashRoot5560 = [1] of {int};
	run hashRoot556(t_db_lock,child_hashRoot5560);
	child_hashRoot5560?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype hashRoot556(Mutexdef t_db_lock;chan child) {
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

