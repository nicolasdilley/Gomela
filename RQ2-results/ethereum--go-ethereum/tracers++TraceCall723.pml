
// https://github.com/ethereum/go-ethereum/blob/master/eth/tracers/api.go#L723
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TraceCall7230 = [1] of {int};
	run TraceCall723(child_TraceCall7230)
stop_process:skip
}

proctype TraceCall723(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_traceTx7560 = [1] of {int};
	Mutexdef statedb_snaps_lock;
	Mutexdef statedb_snaps_triedb_lock;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(statedb_snaps_triedb_lock);
	run mutexMonitor(statedb_snaps_lock);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run traceTx756(statedb_snaps_triedb_lock,statedb_snaps_lock,child_traceTx7560);
	child_traceTx7560?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype traceTx756(Mutexdef statedb_snaps_triedb_lock;Mutexdef statedb_snaps_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewEVM1461 = [1] of {int};
	chan child_AnonymoustraceTx77800 = [1] of {int};
	

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
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run AnonymoustraceTx7780(statedb_snaps_triedb_lock,statedb_snaps_lock,child_AnonymoustraceTx77800)
	:: true;
	:: true;
	fi;
	run NewEVM146(statedb_snaps_triedb_lock,statedb_snaps_lock,child_NewEVM1461);
	child_NewEVM1461?0;
	

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
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymoustraceTx7780(Mutexdef statedb_snaps_triedb_lock;Mutexdef statedb_snaps_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype NewEVM146(Mutexdef statedb_snaps_triedb_lock;Mutexdef statedb_snaps_lock;chan child) {
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

