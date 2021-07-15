
// https://github.com/k6io/k6/blob/master/js/common/context_test.go#L31
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContextRuntime310 = [1] of {int};
	run TestContextRuntime31(child_TestContextRuntime310)
stop_process:skip
}

proctype TestContextRuntime31(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_WithRuntime370 = [1] of {int};
	Mutexdef rt_vm_interruptLock;
	Mutexdef rt_vm_prg_src_mu;
	run mutexMonitor(rt_vm_prg_src_mu);
	run mutexMonitor(rt_vm_interruptLock);
	run WithRuntime37(rt_vm_prg_src_mu,rt_vm_interruptLock,child_WithRuntime370);
	child_WithRuntime370?0;
	stop_process: skip;
	child!0
}
proctype WithRuntime37(Mutexdef rt_vm_prg_src_mu;Mutexdef rt_vm_interruptLock;chan child) {
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

