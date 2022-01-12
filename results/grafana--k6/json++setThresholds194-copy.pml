// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/grafana/k6/blob//output/json/json_test.go#L194
#define not_found_203  -2 // opt thresholds line 126
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_setThresholds1940 = [1] of {int};
	run setThresholds194(child_setThresholds1940);
	run receiver(child_setThresholds1940)
stop_process:skip
}

proctype setThresholds194(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetThresholds1260 = [1] of {int};
	Mutexdef ts_Runtime_vm_interruptLock;
	Mutexdef jout_periodicFlusher_once_m;
	run mutexMonitor(jout_periodicFlusher_once_m);
	run mutexMonitor(ts_Runtime_vm_interruptLock);
	run SetThresholds126(jout_periodicFlusher_once_m,not_found_203,child_SetThresholds1260);
	child_SetThresholds1260?0;
	stop_process: skip;
	child!0
}
proctype SetThresholds126(Mutexdef o_periodicFlusher_once_m;int var_thresholds;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

