
// https://github.com/ethereum/go-ethereum/blob/master/trie/stacktrie_test.go#L28
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestEmptyBug280 = [1] of {int};
	run TestEmptyBug28(child_TestEmptyBug280)
stop_process:skip
}

proctype TestEmptyBug28(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Hash5013 = [1] of {int};
	chan child_Hash5012 = [1] of {int};
	chan child_TryUpdate2570 = [1] of {int};
	chan child_TryUpdate2571 = [1] of {int};
	Mutexdef nt_db_lock;
	int kvs=1;
	run mutexMonitor(nt_db_lock);
	

	if
	:: kvs-1 != -3 -> 
				for(i : 0.. kvs-1) {
			for10: skip;
			run TryUpdate257(nt_db_lock,child_TryUpdate2570);
			child_TryUpdate2570?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for13: skip;
			run TryUpdate257(nt_db_lock,child_TryUpdate2571);
			child_TryUpdate2571?0;
			for13_end: skip
		:: true -> 
			break
		od;
		for13_exit: skip
	fi;
	run Hash501(nt_db_lock,child_Hash5012);
	child_Hash5012?0;
	

	if
	:: true -> 
		run Hash501(nt_db_lock,child_Hash5013);
		child_Hash5013?0
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype TryUpdate257(Mutexdef t_db_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_insert2760 = [1] of {int};
	chan child_delete3681 = [1] of {int};
	

	if
	:: true -> 
		run insert276(t_db_lock,child_insert2760);
		child_insert2760?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		run delete368(t_db_lock,child_delete3681);
		child_delete3681?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype insert276(Mutexdef t_db_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_insert2762 = [1] of {int};
	chan child_insert2761 = [1] of {int};
	chan child_insert2760 = [1] of {int};
	chan child_newFlag704 = [1] of {int};
	chan child_insert2763 = [1] of {int};
	chan child_insert2766 = [1] of {int};
	chan child_resolveHash4915 = [1] of {int};
	

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
		

		if
		:: true -> 
			run insert276(t_db_lock,child_insert2760);
			child_insert2760?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			goto stop_process
		:: true;
		fi;
		run insert276(t_db_lock,child_insert2761);
		child_insert2761?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run insert276(t_db_lock,child_insert2762);
		child_insert2762?0;
		

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
		goto stop_process
	:: true -> 
		run insert276(t_db_lock,child_insert2763);
		child_insert2763?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run newFlag70(t_db_lock,child_newFlag704);
		child_newFlag704?0;
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		run resolveHash491(t_db_lock,child_resolveHash4915);
		child_resolveHash4915?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run insert276(t_db_lock,child_insert2766);
		child_insert2766?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype newFlag70(Mutexdef t_db_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype resolveHash491(Mutexdef t_db_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_node3725 = [1] of {int};
	run node372(t_db_lock,child_node3725);
	child_node3725?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype node372(Mutexdef db_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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
proctype delete368(Mutexdef t_db_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_delete3681 = [1] of {int};
	chan child_resolve4844 = [1] of {int};
	chan child_newFlag703 = [1] of {int};
	chan child_delete3682 = [1] of {int};
	chan child_delete3686 = [1] of {int};
	chan child_resolveHash4915 = [1] of {int};
	

	if
	:: true -> 
		

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
		run delete368(t_db_lock,child_delete3681);
		child_delete3681?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		fi
	:: true -> 
		run delete368(t_db_lock,child_delete3682);
		child_delete3682?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run newFlag70(t_db_lock,child_newFlag703);
		child_newFlag703?0;
		

		if
		:: true -> 
			

			if
			:: true -> 
				run resolve484(t_db_lock,child_resolve4844);
				child_resolve4844?0;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				

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
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		run resolveHash491(t_db_lock,child_resolveHash4915);
		child_resolveHash4915?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run delete368(t_db_lock,child_delete3686);
		child_delete3686?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype resolve484(Mutexdef t_db_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_resolveHash4914 = [1] of {int};
	

	if
	:: true -> 
		run resolveHash491(t_db_lock,child_resolveHash4914);
		child_resolveHash4914?0;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Hash501(Mutexdef t_db_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_hashRoot5562 = [1] of {int};
	run hashRoot556(t_db_lock,child_hashRoot5562);
	child_hashRoot5562?0;
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


