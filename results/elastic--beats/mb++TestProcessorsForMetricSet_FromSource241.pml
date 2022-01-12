// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/elastic/beats/blob//metricbeat/mb/registry_test.go#L241
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestProcessorsForMetricSet_FromSource2410 = [1] of {int};
	run TestProcessorsForMetricSet_FromSource241(child_TestProcessorsForMetricSet_FromSource2410);
	run receiver(child_TestProcessorsForMetricSet_FromSource2410)
stop_process:skip
}

proctype TestProcessorsForMetricSet_FromSource241(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ProcessorsForMetricSet3831 = [1] of {int};
	chan child_SetSecondarySource4050 = [1] of {int};
	Mutexdef registry_lock;
	run mutexMonitor(registry_lock);
	run SetSecondarySource405(registry_lock,child_SetSecondarySource4050);
	child_SetSecondarySource4050?0;
	run ProcessorsForMetricSet383(registry_lock,child_ProcessorsForMetricSet3831);
	child_ProcessorsForMetricSet3831?0;
	stop_process: skip;
	child!0
}
proctype SetSecondarySource405(Mutexdef r_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_lock.Lock!false;
		defer1: skip;
	r_lock.Unlock!false;
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

