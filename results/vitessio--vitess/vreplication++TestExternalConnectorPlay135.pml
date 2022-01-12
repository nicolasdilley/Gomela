// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vttablet/tabletmanager/vreplication/external_connector_test.go#L135
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestExternalConnectorPlay1350 = [1] of {int};
	run TestExternalConnectorPlay135(child_TestExternalConnectorPlay1350);
	run receiver(child_TestExternalConnectorPlay1350)
stop_process:skip
}

proctype TestExternalConnectorPlay135(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_startExternalVReplication1960 = [1] of {int};
	Mutexdef bls1_Filter_state_atomicMessageInfo_initMu;
	Mutexdef bls1_KeyRange_state_atomicMessageInfo_initMu;
	Mutexdef bls1_state_atomicMessageInfo_initMu;
	Mutexdef filter1_state_atomicMessageInfo_initMu;
	run mutexMonitor(filter1_state_atomicMessageInfo_initMu);
	run mutexMonitor(bls1_state_atomicMessageInfo_initMu);
	run mutexMonitor(bls1_KeyRange_state_atomicMessageInfo_initMu);
	run mutexMonitor(bls1_Filter_state_atomicMessageInfo_initMu);
	run startExternalVReplication196(bls1_Filter_state_atomicMessageInfo_initMu,bls1_KeyRange_state_atomicMessageInfo_initMu,bls1_state_atomicMessageInfo_initMu,child_startExternalVReplication1960);
	child_startExternalVReplication1960?0;
	stop_process: skip;
	child!0
}
proctype startExternalVReplication196(Mutexdef bls_Filter_state_atomicMessageInfo_initMu;Mutexdef bls_KeyRange_state_atomicMessageInfo_initMu;Mutexdef bls_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_CreateVReplication6260 = [1] of {int};
	run CreateVReplication626(bls_Filter_state_atomicMessageInfo_initMu,bls_KeyRange_state_atomicMessageInfo_initMu,bls_state_atomicMessageInfo_initMu,child_CreateVReplication6260);
	child_CreateVReplication6260?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype CreateVReplication626(Mutexdef source_Filter_state_atomicMessageInfo_initMu;Mutexdef source_KeyRange_state_atomicMessageInfo_initMu;Mutexdef source_state_atomicMessageInfo_initMu;chan child) {
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

