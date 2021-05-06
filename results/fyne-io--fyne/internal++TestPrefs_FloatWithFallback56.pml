
// https://github.com/fyne-io/fyne/blob/master/internal/preferences_test.go#L56
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPrefs_FloatWithFallback560 = [1] of {int};
	run TestPrefs_FloatWithFallback56(child_TestPrefs_FloatWithFallback560)
stop_process:skip
}

proctype TestPrefs_FloatWithFallback56(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_FloatWithFallback1082 = [1] of {int};
	chan child_WriteValues371 = [1] of {int};
	chan child_FloatWithFallback1080 = [1] of {int};
	Mutexdef p_lock;
	run mutexMonitor(p_lock);
	run FloatWithFallback108(p_lock,child_FloatWithFallback1080);
	child_FloatWithFallback1080?0;
	run WriteValues37(p_lock,child_WriteValues371);
	child_WriteValues371?0;
	run FloatWithFallback108(p_lock,child_FloatWithFallback1082);
	child_FloatWithFallback1082?0;
	stop_process: skip;
	child!0
}
proctype FloatWithFallback108(Mutexdef p_lock;chan child) {
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
proctype WriteValues37(Mutexdef p_lock;chan child) {
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

