
// https://github.com/fyne-io/fyne/blob/master/internal/preferences_test.go#L97
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPrefs_Int_Zero970 = [1] of {int};
	run TestPrefs_Int_Zero97(child_TestPrefs_Int_Zero970)
stop_process:skip
}

proctype TestPrefs_Int_Zero97(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Int1270 = [1] of {int};
	Mutexdef p_lock;
	run mutexMonitor(p_lock);
	run Int127(p_lock,child_Int1270);
	child_Int1270?0;
	stop_process: skip;
	child!0
}
proctype Int127(Mutexdef p_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_IntWithFallback1320 = [1] of {int};
	run IntWithFallback132(p_lock,child_IntWithFallback1320);
	child_IntWithFallback1320?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype IntWithFallback132(Mutexdef p_lock;chan child) {
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

