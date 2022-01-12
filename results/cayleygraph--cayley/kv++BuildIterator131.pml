// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/cayleygraph/cayley/blob//graph/kv/iterators.go#L131
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_BuildIterator1310 = [1] of {int};
	run BuildIterator131(child_BuildIterator1310);
	run receiver(child_BuildIterator1310)
stop_process:skip
}

proctype BuildIterator131(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newQuadIterator380 = [1] of {int};
	Mutexdef kqs_exists;
	Mutexdef kqs_writer;
	Mutexdef kqs_valueLRU_mu;
	Mutexdef kqs_indexes;
	run mutexMonitor(kqs_indexes);
	run mutexMonitor(kqs_valueLRU_mu);
	run mutexMonitor(kqs_writer);
	run mutexMonitor(kqs_exists);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run newQuadIterator38(kqs_exists,kqs_indexes,kqs_valueLRU_mu,kqs_writer,child_newQuadIterator380);
	child_newQuadIterator380?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype newQuadIterator38(Mutexdef qs_exists;Mutexdef qs_indexes;Mutexdef qs_valueLRU_mu;Mutexdef qs_writer;chan child) {
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

