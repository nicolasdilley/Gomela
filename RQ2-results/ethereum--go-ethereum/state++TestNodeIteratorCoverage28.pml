
// https://github.com/ethereum/go-ethereum/blob/master/core/state/iterator_test.go#L28
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNodeIteratorCoverage280 = [1] of {int};
	run TestNodeIteratorCoverage28(child_TestNodeIteratorCoverage280)
stop_process:skip
}

proctype TestNodeIteratorCoverage28(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Next561 = [1] of {int};
	chan child_NewNodeIterator470 = [1] of {int};
	Mutexdef it_state_snaps_lock;
	Mutexdef it_state_snaps_triedb_lock;
	Mutexdef state_snaps_lock;
	Mutexdef state_snaps_triedb_lock;
	run mutexMonitor(state_snaps_triedb_lock);
	run mutexMonitor(state_snaps_lock);
	run mutexMonitor(it_state_snaps_triedb_lock);
	run mutexMonitor(it_state_snaps_lock);
	run NewNodeIterator47(state_snaps_triedb_lock,state_snaps_lock,child_NewNodeIterator470);
	child_NewNodeIterator470?0;
	run Next56(it_state_snaps_triedb_lock,it_state_snaps_lock,child_Next561);
	child_Next561?0;
	stop_process: skip;
	child!0
}
proctype NewNodeIterator47(Mutexdef state_snaps_triedb_lock;Mutexdef state_snaps_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Next56(Mutexdef it_state_snaps_triedb_lock;Mutexdef it_state_snaps_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_retrieve1332 = [1] of {int};
	chan child_step701 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run step70(it_state_snaps_triedb_lock,it_state_snaps_lock,child_step701);
	child_step701?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run retrieve133(it_state_snaps_triedb_lock,it_state_snaps_lock,child_retrieve1332);
	child_retrieve1332?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype step70(Mutexdef it_state_snaps_triedb_lock;Mutexdef it_state_snaps_lock;chan child) {
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
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	

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
		fi;
		goto stop_process
	:: true;
	fi;
	

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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype retrieve133(Mutexdef it_state_snaps_triedb_lock;Mutexdef it_state_snaps_lock;chan child) {
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
	:: true;
	:: true;
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

