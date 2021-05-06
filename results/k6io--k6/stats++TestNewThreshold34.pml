
// https://github.com/k6io/k6/blob/master/stats/thresholds_test.go#L34
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNewThreshold340 = [1] of {int};
	run TestNewThreshold34(child_TestNewThreshold340)
stop_process:skip
}

proctype TestNewThreshold34(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newThreshold650 = [1] of {int};
	Mutexdef th_rt_vm_interruptLock;
	Mutexdef th_rt_vm_prg_src_mu;
	Mutexdef th_pgm_src_mu;
	Mutexdef rt_vm_interruptLock;
	Mutexdef rt_vm_prg_src_mu;
	run mutexMonitor(rt_vm_prg_src_mu);
	run mutexMonitor(rt_vm_interruptLock);
	run mutexMonitor(th_pgm_src_mu);
	run mutexMonitor(th_rt_vm_prg_src_mu);
	run mutexMonitor(th_rt_vm_interruptLock);
	run newThreshold65(rt_vm_prg_src_mu,rt_vm_interruptLock,child_newThreshold650);
	child_newThreshold650?0;
	stop_process: skip;
	child!0
}
proctype newThreshold65(Mutexdef newThreshold_vm_prg_src_mu;Mutexdef newThreshold_vm_interruptLock;chan child) {
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

