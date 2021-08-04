// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/go-kit/kit/blob/60e8424101af501c525efaf67c0a2edf08667f80/metrics/pcp/pcp.go#L18
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewReporter180 = [1] of {int};
	run NewReporter18(child_NewReporter180);
	run receiver(child_NewReporter180)
stop_process:skip
}

proctype NewReporter18(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef c_r_metricslock;
	Mutexdef c_r_indomlock;
	Mutexdef c_mutex;
	run mutexMonitor(c_mutex);
	run mutexMonitor(c_r_indomlock);
	run mutexMonitor(c_r_metricslock);
	

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

