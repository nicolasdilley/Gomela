// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/ethereum/go-ethereum/blob/b8040a430e34117f121c67e8deee4a5e889e8372/eth/tracers/api.go#L700
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TraceTransaction7000 = [1] of {int};
	run TraceTransaction700(child_TraceTransaction7000);
	run receiver(child_TraceTransaction7000)
stop_process:skip
}

proctype TraceTransaction700(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_traceTx7830 = [1] of {int};
	Mutexdef statedb_snaps_lock;
	

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
	run mutexMonitor(statedb_snaps_lock);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run traceTx783(statedb_snaps_lock,child_traceTx7830);
	child_traceTx7830?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype traceTx783(Mutexdef statedb_snaps_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewEVM1461 = [1] of {int};
	chan child_AnonymoustraceTx80500 = [1] of {int};
	

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
		run AnonymoustraceTx8050(statedb_snaps_lock,child_AnonymoustraceTx80500);
		run receiver(child_AnonymoustraceTx80500)
	:: true;
	:: true;
	fi;
	run NewEVM146(statedb_snaps_lock,child_NewEVM1461);
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
proctype AnonymoustraceTx8050(Mutexdef statedb_snaps_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

