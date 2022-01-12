// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/orchestrator/inst/durability.go#L95
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_ReplicaSemiSync950 = [1] of {int};
	run ReplicaSemiSync95(child_ReplicaSemiSync950);
	run receiver(child_ReplicaSemiSync950)
stop_process:skip
}

proctype ReplicaSemiSync95(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef replica_PrimaryTermStartTime_state_atomicMessageInfo_initMu;
	Mutexdef replica_KeyRange_state_atomicMessageInfo_initMu;
	Mutexdef replica_Alias_state_atomicMessageInfo_initMu;
	Mutexdef replica_state_atomicMessageInfo_initMu;
	Mutexdef primary_PrimaryTermStartTime_state_atomicMessageInfo_initMu;
	Mutexdef primary_KeyRange_state_atomicMessageInfo_initMu;
	Mutexdef primary_Alias_state_atomicMessageInfo_initMu;
	Mutexdef primary_state_atomicMessageInfo_initMu;
	run mutexMonitor(primary_state_atomicMessageInfo_initMu);
	run mutexMonitor(primary_Alias_state_atomicMessageInfo_initMu);
	run mutexMonitor(primary_KeyRange_state_atomicMessageInfo_initMu);
	run mutexMonitor(primary_PrimaryTermStartTime_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(replica_state_atomicMessageInfo_initMu);
	run mutexMonitor(replica_Alias_state_atomicMessageInfo_initMu);
	run mutexMonitor(replica_KeyRange_state_atomicMessageInfo_initMu);
	run mutexMonitor(replica_PrimaryTermStartTime_state_atomicMessageInfo_initMu);
	

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

