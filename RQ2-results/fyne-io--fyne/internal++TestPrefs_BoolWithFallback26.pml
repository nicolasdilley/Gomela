
// https://github.com/fyne-io/fyne/blob/master/internal/preferences_test.go#L26
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPrefs_BoolWithFallback260 = [1] of {int};
	run TestPrefs_BoolWithFallback26(child_TestPrefs_BoolWithFallback260)
stop_process:skip
}

proctype TestPrefs_BoolWithFallback26(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_BoolWithFallback842 = [1] of {int};
	chan child_SetBool981 = [1] of {int};
	chan child_BoolWithFallback840 = [1] of {int};
	Mutexdef p_lock;
	run mutexMonitor(p_lock);
	run BoolWithFallback84(p_lock,child_BoolWithFallback840);
	child_BoolWithFallback840?0;
	run SetBool98(p_lock,child_SetBool981);
	child_SetBool981?0;
	run BoolWithFallback84(p_lock,child_BoolWithFallback842);
	child_BoolWithFallback842?0;
	stop_process: skip;
	child!0
}
proctype BoolWithFallback84(Mutexdef p_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_get540 = [1] of {int};
	run get54(p_lock,child_get540);
	child_get540?0;
	

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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype get54(Mutexdef p_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	p_lock.RLock!false;
	goto stop_process;
	stop_process: skip;
		p_lock.RUnlock!false;
	child!0
}
proctype SetBool98(Mutexdef p_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_set451 = [1] of {int};
	run set45(p_lock,child_set451);
	child_set451?0;
	stop_process: skip;
	child!0
}
proctype set45(Mutexdef p_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fireChange691 = [1] of {int};
	p_lock.Lock!false;
	p_lock.Unlock!false;
	run fireChange69(p_lock,child_fireChange691);
	child_fireChange691?0;
	stop_process: skip;
	child!0
}
proctype fireChange69(Mutexdef p_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	p_lock.Lock!false;
	stop_process: skip;
		p_lock.Unlock!false;
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

