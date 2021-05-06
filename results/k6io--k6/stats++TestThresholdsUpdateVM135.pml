
// https://github.com/k6io/k6/blob/master/stats/thresholds_test.go#L135
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestThresholdsUpdateVM1350 = [1] of {int};
	run TestThresholdsUpdateVM135(child_TestThresholdsUpdateVM1350)
stop_process:skip
}

proctype TestThresholdsUpdateVM135(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_updateVM1550 = [1] of {int};
	Mutexdef ts_Runtime_vm_interruptLock;
	Mutexdef ts_Runtime_vm_prg_src_mu;
	run mutexMonitor(ts_Runtime_vm_prg_src_mu);
	run mutexMonitor(ts_Runtime_vm_interruptLock);
	run updateVM155(ts_Runtime_vm_prg_src_mu,ts_Runtime_vm_interruptLock,child_updateVM1550);
	child_updateVM1550?0;
	stop_process: skip;
	child!0
}
proctype updateVM155(Mutexdef ts_Runtime_vm_prg_src_mu;Mutexdef ts_Runtime_vm_interruptLock;chan child) {
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

