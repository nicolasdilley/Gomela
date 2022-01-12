// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/elastic/beats/blob//metricbeat/mb/registry_test.go#L234
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestProcessorsForMetricSet_UndefinedSecondarySource2340 = [1] of {int};
	run TestProcessorsForMetricSet_UndefinedSecondarySource234(child_TestProcessorsForMetricSet_UndefinedSecondarySource2340);
	run receiver(child_TestProcessorsForMetricSet_UndefinedSecondarySource2340)
stop_process:skip
}

proctype TestProcessorsForMetricSet_UndefinedSecondarySource234(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ProcessorsForMetricSet3830 = [1] of {int};
	Mutexdef registry_lock;
	run mutexMonitor(registry_lock);
	run ProcessorsForMetricSet383(registry_lock,child_ProcessorsForMetricSet3830);
	child_ProcessorsForMetricSet3830?0;
	stop_process: skip;
	child!0
}
proctype ProcessorsForMetricSet383(Mutexdef r_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_lock.RLock!false;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	r_lock.RUnlock!false;
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

