// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/ethereum/go-ethereum/blob/b8040a430e34117f121c67e8deee4a5e889e8372/trie/iterator_test.go#L99
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNodeIteratorCoverage990 = [1] of {int};
	run TestNodeIteratorCoverage99(child_TestNodeIteratorCoverage990);
	run receiver(child_TestNodeIteratorCoverage990)
stop_process:skip
}

proctype TestNodeIteratorCoverage99(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Node4080 = [1] of {int};
	chan child_Node4081 = [1] of {int};
	Mutexdef db_lock;
	int db_dirties = -2; // opt db_dirties
	int hashes = -2; // opt hashes
	run mutexMonitor(db_lock);
	

	if
	:: hashes-1 != -3 -> 
				for(i : 0.. hashes-1) {
			for20: skip;
			run Node408(db_lock,child_Node4080);
			child_Node4080?0;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for21: skip;
			run Node408(db_lock,child_Node4081);
			child_Node4081?0;
			for21_end: skip
		:: true -> 
			break
		od;
		for21_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype Node408(Mutexdef db_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	db_lock.RLock!false;
	db_lock.RUnlock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

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

