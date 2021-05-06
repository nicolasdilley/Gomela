
// https://github.com/k6io/k6/blob/master/js/modules/k6/grpc/client.go#L77
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_XClient770 = [1] of {int};
	run XClient77(child_XClient770)
stop_process:skip
}

proctype XClient77(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Bind1370 = [1] of {int};
	Mutexdef rt_vm_interruptLock;
	Mutexdef rt_vm_prg_src_mu;
	run mutexMonitor(rt_vm_prg_src_mu);
	run mutexMonitor(rt_vm_interruptLock);
	run Bind137(rt_vm_prg_src_mu,rt_vm_interruptLock,child_Bind1370);
	child_Bind1370?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Bind137(Mutexdef rt_vm_prg_src_mu;Mutexdef rt_vm_interruptLock;chan child) {
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

