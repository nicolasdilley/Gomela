// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grafana/k6/blob//stats/thresholds_test.go#L135
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestThresholdsUpdateVM1350 = [1] of {int};
	run TestThresholdsUpdateVM135(child_TestThresholdsUpdateVM1350);
	run receiver(child_TestThresholdsUpdateVM1350)
stop_process:skip
}

proctype TestThresholdsUpdateVM135(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_updateVM1580 = [1] of {int};
	Mutexdef ts_Runtime_vm_interruptLock;
	run mutexMonitor(ts_Runtime_vm_interruptLock);
	run updateVM158(ts_Runtime_vm_interruptLock,child_updateVM1580);
	child_updateVM1580?0;
	stop_process: skip;
	child!0
}
proctype updateVM158(Mutexdef ts_Runtime_vm_interruptLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_f = -2; // opt var_f
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

