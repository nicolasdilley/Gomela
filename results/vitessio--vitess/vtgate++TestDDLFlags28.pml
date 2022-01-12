// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vtgate/executor_ddl_test.go#L28
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDDLFlags280 = [1] of {int};
	run TestDDLFlags28(child_TestDDLFlags280);
	run receiver(child_TestDDLFlags280)
stop_process:skip
}

proctype TestDDLFlags28(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef session_mu;
	Mutexdef __execMu;
	Mutexdef __sExecMu;
	Mutexdef __mapMu;
	Mutexdef __tablet_state_atomicMessageInfo_initMu;
	Mutexdef executor_vm_mu;
	Mutexdef executor_mu;
	int var_testcases = -2; // opt var_testcases
	run mutexMonitor(executor_mu);
	run mutexMonitor(executor_vm_mu);
	run mutexMonitor(__tablet_state_atomicMessageInfo_initMu);
	run mutexMonitor(__mapMu);
	run mutexMonitor(__sExecMu);
	run mutexMonitor(__execMu);
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

