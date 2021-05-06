
// https://github.com/fyne-io/fyne/blob/master/internal/preferences_test.go#L66
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPrefs_Float_Zero660 = [1] of {int};
	run TestPrefs_Float_Zero66(child_TestPrefs_Float_Zero660)
stop_process:skip
}

proctype TestPrefs_Float_Zero66(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Float1030 = [1] of {int};
	Mutexdef p_lock;
	run mutexMonitor(p_lock);
	run Float103(p_lock,child_Float1030);
	child_Float1030?0;
	stop_process: skip;
	child!0
}
proctype Float103(Mutexdef p_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_FloatWithFallback1080 = [1] of {int};
	run FloatWithFallback108(p_lock,child_FloatWithFallback1080);
	child_FloatWithFallback1080?0;
	goto stop_process;
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

