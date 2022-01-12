// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vtgate/executor_test.go#L398
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestExecutorShowColumns3980 = [1] of {int};
	run TestExecutorShowColumns398(child_TestExecutorShowColumns3980);
	run receiver(child_TestExecutorShowColumns3980)
stop_process:skip
}

proctype TestExecutorShowColumns398(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef session_mu;
	Mutexdef sbclookup_execMu;
	Mutexdef sbclookup_sExecMu;
	Mutexdef sbclookup_mapMu;
	Mutexdef sbclookup_tablet_state_atomicMessageInfo_initMu;
	Mutexdef sbc2_execMu;
	Mutexdef sbc2_sExecMu;
	Mutexdef sbc2_mapMu;
	Mutexdef sbc2_tablet_state_atomicMessageInfo_initMu;
	Mutexdef sbc1_execMu;
	Mutexdef sbc1_sExecMu;
	Mutexdef sbc1_mapMu;
	Mutexdef sbc1_tablet_state_atomicMessageInfo_initMu;
	Mutexdef executor_vm_mu;
	Mutexdef executor_mu;
	int var_queries = -2; // opt var_queries
	run mutexMonitor(executor_mu);
	run mutexMonitor(executor_vm_mu);
	run mutexMonitor(sbc1_tablet_state_atomicMessageInfo_initMu);
	run mutexMonitor(sbc1_mapMu);
	run mutexMonitor(sbc1_sExecMu);
	run mutexMonitor(sbc1_execMu);
	run mutexMonitor(sbc2_tablet_state_atomicMessageInfo_initMu);
	run mutexMonitor(sbc2_mapMu);
	run mutexMonitor(sbc2_sExecMu);
	run mutexMonitor(sbc2_execMu);
	run mutexMonitor(sbclookup_tablet_state_atomicMessageInfo_initMu);
	run mutexMonitor(sbclookup_mapMu);
	run mutexMonitor(sbclookup_sExecMu);
	run mutexMonitor(sbclookup_execMu);
	run mutexMonitor(session_mu);
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

