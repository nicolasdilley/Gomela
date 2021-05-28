// num_comm_params=4
// num_mand_comm_params=0
// num_opt_comm_params=4

// git_link=https://github.com/k6io/k6/blob/af1e032ebf949cde092d4a2eddb78528ea0a5864/js/modules/k6/metrics/metrics.go#L52
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_newMetric520 = [1] of {int};
	run newMetric52(child_newMetric520);
	run receiver(child_newMetric520)
stop_process:skip
}

proctype newMetric52(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Bind1370 = [1] of {int};
	Mutexdef rt_vm_interruptLock;
	

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
	run mutexMonitor(rt_vm_interruptLock);
	run Bind137(rt_vm_interruptLock,child_Bind1370);
	child_Bind1370?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Bind137(Mutexdef rt_vm_interruptLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int typ_NumField__ = -2; // opt typ_NumField__
	int varArgsLen = -2; // opt varArgsLen
	int numIn = -2; // opt numIn
	int typ_NumMethod__ = -2; // opt typ_NumMethod__
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

