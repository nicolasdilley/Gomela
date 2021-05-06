
// https://github.com/fyne-io/fyne/blob/master/internal/preferences_test.go#L10
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPrefs_SetBool100 = [1] of {int};
	run TestPrefs_SetBool10(child_TestPrefs_SetBool100)
stop_process:skip
}

proctype TestPrefs_SetBool10(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Bool791 = [1] of {int};
	chan child_SetBool980 = [1] of {int};
	Mutexdef p_lock;
	run mutexMonitor(p_lock);
	run SetBool98(p_lock,child_SetBool980);
	child_SetBool980?0;
	run Bool79(p_lock,child_Bool791);
	child_Bool791?0;
	stop_process: skip;
	child!0
}
proctype SetBool98(Mutexdef p_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_set450 = [1] of {int};
	run set45(p_lock,child_set450);
	child_set450?0;
	stop_process: skip;
	child!0
}
proctype set45(Mutexdef p_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fireChange690 = [1] of {int};
	p_lock.Lock!false;
	p_lock.Unlock!false;
	run fireChange69(p_lock,child_fireChange690);
	child_fireChange690?0;
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
proctype Bool79(Mutexdef p_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_BoolWithFallback841 = [1] of {int};
	run BoolWithFallback84(p_lock,child_BoolWithFallback841);
	child_BoolWithFallback841?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype BoolWithFallback84(Mutexdef p_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_get541 = [1] of {int};
	run get54(p_lock,child_get541);
	child_get541?0;
	

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

