// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vttablet/tabletmanager/vreplication/vcopier_test.go#L1284
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPlayerCopyTablesWithGeneratedColumn12840 = [1] of {int};
	run TestPlayerCopyTablesWithGeneratedColumn1284(child_TestPlayerCopyTablesWithGeneratedColumn12840);
	run receiver(child_TestPlayerCopyTablesWithGeneratedColumn12840)
stop_process:skip
}

proctype TestPlayerCopyTablesWithGeneratedColumn1284(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_CreateVReplicationState6340 = [1] of {int};
	Mutexdef bls_Filter_state_atomicMessageInfo_initMu;
	Mutexdef bls_KeyRange_state_atomicMessageInfo_initMu;
	Mutexdef bls_state_atomicMessageInfo_initMu;
	Mutexdef filter_state_atomicMessageInfo_initMu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(filter_state_atomicMessageInfo_initMu);
	run mutexMonitor(bls_state_atomicMessageInfo_initMu);
	run mutexMonitor(bls_KeyRange_state_atomicMessageInfo_initMu);
	run mutexMonitor(bls_Filter_state_atomicMessageInfo_initMu);
	run CreateVReplicationState634(bls_Filter_state_atomicMessageInfo_initMu,bls_KeyRange_state_atomicMessageInfo_initMu,bls_state_atomicMessageInfo_initMu,child_CreateVReplicationState6340);
	child_CreateVReplicationState6340?0;
	stop_process: skip;
	child!0
}
proctype CreateVReplicationState634(Mutexdef source_Filter_state_atomicMessageInfo_initMu;Mutexdef source_KeyRange_state_atomicMessageInfo_initMu;Mutexdef source_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_String10200 = [1] of {int};
	run String1020(source_Filter_state_atomicMessageInfo_initMu,source_KeyRange_state_atomicMessageInfo_initMu,source_state_atomicMessageInfo_initMu,child_String10200);
	child_String10200?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype String1020(Mutexdef x_Filter_state_atomicMessageInfo_initMu;Mutexdef x_KeyRange_state_atomicMessageInfo_initMu;Mutexdef x_state_atomicMessageInfo_initMu;chan child) {
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

