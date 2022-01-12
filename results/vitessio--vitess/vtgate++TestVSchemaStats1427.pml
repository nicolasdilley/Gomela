// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vtgate/executor_test.go#L1427
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestVSchemaStats14270 = [1] of {int};
	run TestVSchemaStats1427(child_TestVSchemaStats14270);
	run receiver(child_TestVSchemaStats14270)
stop_process:skip
}

proctype TestVSchemaStats1427(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_VSchemaStats13460 = [1] of {int};
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
	run VSchemaStats1346(r_mu,r_vm_mu,child_VSchemaStats13460);
	child_VSchemaStats13460?0;
	stop_process: skip;
	child!0
}
proctype VSchemaStats1346(Mutexdef e_mu;Mutexdef e_vm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	e_mu.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	e_mu.Unlock!false;
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

