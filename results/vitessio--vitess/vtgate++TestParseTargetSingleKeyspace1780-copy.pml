// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vtgate/executor_test.go#L1780
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestParseTargetSingleKeyspace17800 = [1] of {int};
	run TestParseTargetSingleKeyspace1780(child_TestParseTargetSingleKeyspace17800);
	run receiver(child_TestParseTargetSingleKeyspace17800)
stop_process:skip
}

proctype TestParseTargetSingleKeyspace1780(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ParseDestinationTarget11870 = [1] of {int};
	Mutexdef __execMu;
	Mutexdef __sExecMu;
	Mutexdef __mapMu;
	Mutexdef __tablet_state_atomicMessageInfo_initMu;
	Mutexdef r_vm_mu;
	Mutexdef r_mu;
	run mutexMonitor(r_mu);
	run mutexMonitor(r_vm_mu);
	run mutexMonitor(__tablet_state_atomicMessageInfo_initMu);
	run mutexMonitor(__mapMu);
	run mutexMonitor(__sExecMu);
	run mutexMonitor(__execMu);
	run ParseDestinationTarget1187(r_mu,r_vm_mu,child_ParseDestinationTarget11870);
	child_ParseDestinationTarget11870?0;
	stop_process: skip;
	child!0
}
proctype ParseDestinationTarget1187(Mutexdef e_mu;Mutexdef e_vm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_e_VSchema_Keyspaces = -2; // opt var_e_VSchema_Keyspaces
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

