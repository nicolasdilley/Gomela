// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vtgate/executor_test.go#L1802
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDebugVSchema18020 = [1] of {int};
	run TestDebugVSchema1802(child_TestDebugVSchema18020);
	run receiver(child_TestDebugVSchema18020)
stop_process:skip
}

proctype TestDebugVSchema1802(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ServeHTTP13010 = [1] of {int};
	Mutexdef __execMu;
	Mutexdef __sExecMu;
	Mutexdef __mapMu;
	Mutexdef __tablet_state_atomicMessageInfo_initMu;
	Mutexdef executor_vm_mu;
	Mutexdef executor_mu;
	run mutexMonitor(executor_mu);
	run mutexMonitor(executor_vm_mu);
	run mutexMonitor(__tablet_state_atomicMessageInfo_initMu);
	run mutexMonitor(__mapMu);
	run mutexMonitor(__sExecMu);
	run mutexMonitor(__execMu);
	run ServeHTTP1301(executor_mu,executor_vm_mu,child_ServeHTTP13010);
	child_ServeHTTP13010?0;
	stop_process: skip;
	child!0
}
proctype ServeHTTP1301(Mutexdef e_mu;Mutexdef e_vm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_debugCacheEntries12880 = [1] of {int};
	chan child_VSchema11641 = [1] of {int};
	chan child_WriteScatterStats1262 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run debugCacheEntries1288(e_mu,e_vm_mu,child_debugCacheEntries12880);
		child_debugCacheEntries12880?0
	:: true -> 
		run VSchema1164(e_mu,e_vm_mu,child_VSchema11641);
		child_VSchema11641?0
	:: true -> 
		run WriteScatterStats126(e_mu,e_vm_mu,child_WriteScatterStats1262);
		child_WriteScatterStats1262?0
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype debugCacheEntries1288(Mutexdef e_mu;Mutexdef e_vm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype VSchema1164(Mutexdef e_mu;Mutexdef e_vm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	e_mu.Lock!false;
	goto defer1;
		defer1: skip;
	e_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype WriteScatterStats126(Mutexdef e_mu;Mutexdef e_vm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_gatherScatterStats522 = [1] of {int};
	run gatherScatterStats52(e_mu,e_vm_mu,child_gatherScatterStats522);
	child_gatherScatterStats522?0;
	

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
	stop_process: skip;
	child!0
}
proctype gatherScatterStats52(Mutexdef e_mu;Mutexdef e_vm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_plans = -2; // opt var_plans
	

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

