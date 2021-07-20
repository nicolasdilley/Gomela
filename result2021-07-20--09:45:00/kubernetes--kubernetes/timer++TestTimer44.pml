// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/test/e2e/framework/timer/timer_test.go#L44
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTimer440 = [1] of {int};
	run TestTimer44(child_TestTimer440);
	run receiver(child_TestTimer440)
stop_process:skip
}

proctype TestTimer44(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_PrintHumanReadable1013 = [1] of {int};
	chan child_PrintHumanReadable1012 = [1] of {int};
	chan child_testUsageWithDefer391 = [1] of {int};
	chan child_StartPhase870 = [1] of {int};
	Mutexdef timer_lock;
	run mutexMonitor(timer_lock);
	run StartPhase87(timer_lock,child_StartPhase870);
	child_StartPhase870?0;
	run testUsageWithDefer39(timer_lock,child_testUsageWithDefer391);
	child_testUsageWithDefer391?0;
	run PrintHumanReadable101(timer_lock,child_PrintHumanReadable1012);
	child_PrintHumanReadable1012?0;
	run PrintHumanReadable101(timer_lock,child_PrintHumanReadable1013);
	child_PrintHumanReadable1013?0;
	stop_process: skip;
	child!0
}
proctype StartPhase87(Mutexdef timer_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	timer_lock.Lock!false;
	goto defer1;
		defer1: skip;
	timer_lock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype testUsageWithDefer39(Mutexdef timer_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype PrintHumanReadable101(Mutexdef timer_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_timer_phasestimer_phases = -2; // opt var_timer_phasestimer_phases
	timer_lock.Lock!false;
	goto defer1;
		defer1: skip;
	timer_lock.Unlock!false;
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

