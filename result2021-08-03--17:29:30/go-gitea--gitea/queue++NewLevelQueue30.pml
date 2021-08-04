// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/go-gitea/gitea/blob/ed393779004335a0afcca0dfac48937db41fabd6/modules/queue/queue_disk.go#L30
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewLevelQueue300 = [1] of {int};
	run NewLevelQueue30(child_NewLevelQueue300);
	run receiver(child_NewLevelQueue300)
stop_process:skip
}

proctype NewLevelQueue30(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewByteFIFOQueue400 = [1] of {int};
	Mutexdef byteFIFOQueue_lock;
	Mutexdef byteFIFO_internal_lowLock;
	Mutexdef byteFIFO_internal_highLock;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(byteFIFO_internal_highLock);
	run mutexMonitor(byteFIFO_internal_lowLock);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(byteFIFOQueue_lock);
	run NewByteFIFOQueue40(byteFIFO_internal_highLock,byteFIFO_internal_lowLock,child_NewByteFIFOQueue400);
	child_NewByteFIFOQueue400?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewByteFIFOQueue40(Mutexdef byteFIFO_internal_highLock;Mutexdef byteFIFO_internal_lowLock;chan child) {
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

proctype receiver(chan c) {
c?0
}

