// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grafana/k6/blob//stats/thresholds_test.go#L34
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNewThreshold340 = [1] of {int};
	run TestNewThreshold34(child_TestNewThreshold340);
	run receiver(child_TestNewThreshold340)
stop_process:skip
}

proctype TestNewThreshold34(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newThreshold660 = [1] of {int};
	Mutexdef th_rt_vm_interruptLock;
	Mutexdef th_pgm_src_mu;
	Mutexdef rt_vm_interruptLock;
	Mutexdef rt_vm_prg_src_mu;
	run mutexMonitor(rt_vm_prg_src_mu);
	run mutexMonitor(rt_vm_interruptLock);
	run mutexMonitor(th_pgm_src_mu);
	run mutexMonitor(th_rt_vm_interruptLock);
	run newThreshold66(rt_vm_interruptLock,rt_vm_prg_src_mu,child_newThreshold660);
	child_newThreshold660?0;
	stop_process: skip;
	child!0
}
proctype newThreshold66(Mutexdef newThreshold_vm_interruptLock;Mutexdef newThreshold_vm_prg_src_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef pgm_src_mu;
	run mutexMonitor(pgm_src_mu);
	

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

