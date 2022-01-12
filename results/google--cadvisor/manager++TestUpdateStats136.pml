// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/google/cadvisor/blob//manager/container_test.go#L136
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestUpdateStats1360 = [1] of {int};
	run TestUpdateStats136(child_TestUpdateStats1360);
	run receiver(child_TestUpdateStats1360)
stop_process:skip
}

proctype TestUpdateStats136(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_checkNumStats1291 = [1] of {int};
	chan child_updateStats6400 = [1] of {int};
	Mutexdef memoryCache_lock;
	Mutexdef cd_summaryReader_dataLock;
	Mutexdef cd_lock;
	Mutexdef cd_memoryCache_lock;
	run mutexMonitor(cd_memoryCache_lock);
	run mutexMonitor(cd_lock);
	run mutexMonitor(cd_summaryReader_dataLock);
	run mutexMonitor(memoryCache_lock);
	run updateStats640(cd_lock,cd_memoryCache_lock,cd_summaryReader_dataLock,child_updateStats6400);
	child_updateStats6400?0;
	run checkNumStats129(memoryCache_lock,child_checkNumStats1291);
	child_checkNumStats1291?0;
	stop_process: skip;
	child!0
}
proctype updateStats640(Mutexdef cd_lock;Mutexdef cd_memoryCache_lock;Mutexdef cd_summaryReader_dataLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_updateCustomStats7371 = [1] of {int};
	chan child_updateLoad6320 = [1] of {int};
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			run updateLoad632(cd_lock,cd_memoryCache_lock,cd_summaryReader_dataLock,child_updateLoad6320);
			child_updateLoad6320?0
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			run updateCustomStats737(cd_lock,cd_memoryCache_lock,cd_summaryReader_dataLock,child_updateCustomStats7371);
			child_updateCustomStats7371?0
		:: true;
		fi
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
proctype updateLoad632(Mutexdef cd_lock;Mutexdef cd_memoryCache_lock;Mutexdef cd_summaryReader_dataLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype updateCustomStats737(Mutexdef cd_lock;Mutexdef cd_memoryCache_lock;Mutexdef cd_summaryReader_dataLock;chan child) {
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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype checkNumStats129(Mutexdef memoryCache_lock;chan child) {
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

proctype receiver(chan c) {
c?0
}

