
// https://github.com/kubernetes/kubernetes/blob/master/test/e2e/framework/timer/timer_test.go#L44
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTimer440 = [1] of {int};
	run TestTimer44(child_TestTimer440)
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
	goto stop_process;
	stop_process: skip;
		timer_lock.Unlock!false;
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
	timer_lock.Lock!false;
	goto stop_process;
	stop_process: skip;
		timer_lock.Unlock!false;
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

