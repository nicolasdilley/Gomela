
// https://github.com/go-gitea/gitea/blob/master/modules/indexer/issues/elastic_search.go#L38
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewElasticSearchIndexer380 = [1] of {int};
	run NewElasticSearchIndexer38(child_NewElasticSearchIndexer380)
stop_process:skip
}

proctype NewElasticSearchIndexer38(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef client_mu;
	Mutexdef client_connsMu;
	run mutexMonitor(client_connsMu);
	run mutexMonitor(client_mu);
	

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

