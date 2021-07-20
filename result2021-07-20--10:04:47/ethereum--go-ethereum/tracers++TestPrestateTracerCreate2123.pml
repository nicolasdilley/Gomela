// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/ethereum/go-ethereum/blob/b8040a430e34117f121c67e8deee4a5e889e8372/eth/tracers/tracers_test.go#L123
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPrestateTracerCreate21230 = [1] of {int};
	run TestPrestateTracerCreate2123(child_TestPrestateTracerCreate21230);
	run receiver(child_TestPrestateTracerCreate21230)
stop_process:skip
}

proctype TestPrestateTracerCreate2123(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewEVM1460 = [1] of {int};
	Mutexdef statedb_snaps_lock;
	Mutexdef __lock;
	Mutexdef __triedb_lock;
	run mutexMonitor(__triedb_lock);
	run mutexMonitor(__lock);
	run mutexMonitor(statedb_snaps_lock);
	run NewEVM146(statedb_snaps_lock,child_NewEVM1460);
	child_NewEVM1460?0;
	stop_process: skip;
	child!0
}
proctype NewEVM146(Mutexdef statedb_snaps_lock;chan child) {
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

