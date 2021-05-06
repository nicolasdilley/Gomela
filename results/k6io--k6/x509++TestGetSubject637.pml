
// https://github.com/k6io/k6/blob/master/js/modules/k6/crypto/x509/x509_test.go#L637
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGetSubject6370 = [1] of {int};
	run TestGetSubject637(child_TestGetSubject6370)
stop_process:skip
}

proctype TestGetSubject637(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef rt_vm_interruptLock;
	Mutexdef rt_vm_prg_src_mu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(rt_vm_prg_src_mu);
	run mutexMonitor(rt_vm_interruptLock);
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

