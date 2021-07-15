
// https://github.com/go-gitea/gitea/blob/master/modules/indexer/code/elastic_search_test.go#L16
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestESIndexAndSearch160 = [1] of {int};
	run TestESIndexAndSearch16(child_TestESIndexAndSearch160)
stop_process:skip
}

proctype TestESIndexAndSearch16(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close4451 = [1] of {int};
	chan child_testIndexer202 = [1] of {int};
	chan child_Close4450 = [1] of {int};
	Mutexdef indexer_client_mu;
	Mutexdef indexer_client_connsMu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(indexer_client_connsMu);
	run mutexMonitor(indexer_client_mu);
	

	if
	:: true -> 
		

		if
		:: true -> 
			run Close445(indexer_client_connsMu,indexer_client_mu,child_Close4450);
			child_Close4450?0
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	run testIndexer20(indexer_client_connsMu,indexer_client_mu,child_testIndexer202);
	child_testIndexer202?0;
	stop_process: skip;
		run Close445(indexer_client_connsMu,indexer_client_mu,child_Close4451);
	child_Close4451?0;
	child!0
}
proctype Close445(Mutexdef b_client_connsMu;Mutexdef b_client_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype testIndexer20(Mutexdef indexer_client_connsMu;Mutexdef indexer_client_mu;chan child) {
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

