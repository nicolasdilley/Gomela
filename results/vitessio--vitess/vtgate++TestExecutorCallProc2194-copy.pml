// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vtgate/executor_test.go#L2194
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestExecutorCallProc21940 = [1] of {int};
	run TestExecutorCallProc2194(child_TestExecutorCallProc21940);
	run receiver(child_TestExecutorCallProc21940)
stop_process:skip
}

proctype TestExecutorCallProc2194(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef sbcUnsharded_execMu;
	Mutexdef sbcUnsharded_sExecMu;
	Mutexdef sbcUnsharded_mapMu;
	Mutexdef sbcUnsharded_tablet_state_atomicMessageInfo_initMu;
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
	int var_tcs = -2; // opt var_tcs
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
	run mutexMonitor(sbcUnsharded_tablet_state_atomicMessageInfo_initMu);
	run mutexMonitor(sbcUnsharded_mapMu);
	run mutexMonitor(sbcUnsharded_sExecMu);
	run mutexMonitor(sbcUnsharded_execMu);
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

