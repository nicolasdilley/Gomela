// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vtadmin/http/keyspaces.go#L32
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_CreateKeyspace320 = [1] of {int};
	run CreateKeyspace32(child_CreateKeyspace320);
	run receiver(child_CreateKeyspace320)
stop_process:skip
}

proctype CreateKeyspace32(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewJSONResponse450 = [1] of {int};
	Mutexdef resp_Keyspace_state_atomicMessageInfo_initMu;
	Mutexdef resp_state_atomicMessageInfo_initMu;
	Mutexdef req_SnapshotTime_state_atomicMessageInfo_initMu;
	Mutexdef req_state_atomicMessageInfo_initMu;
	run mutexMonitor(req_state_atomicMessageInfo_initMu);
	run mutexMonitor(req_SnapshotTime_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(resp_state_atomicMessageInfo_initMu);
	run mutexMonitor(resp_Keyspace_state_atomicMessageInfo_initMu);
	run NewJSONResponse45(resp_Keyspace_state_atomicMessageInfo_initMu,resp_state_atomicMessageInfo_initMu,child_NewJSONResponse450);
	child_NewJSONResponse450?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewJSONResponse45(Mutexdef value_Keyspace_state_atomicMessageInfo_initMu;Mutexdef value_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		fi
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

