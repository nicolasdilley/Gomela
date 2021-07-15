
// https://github.com/fyne-io/fyne/blob/master/internal/preferences_test.go#L148
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRemoveValue1480 = [1] of {int};
	run TestRemoveValue148(child_TestRemoveValue1480)
stop_process:skip
}

proctype TestRemoveValue148(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_String15511 = [1] of {int};
	chan child_Int12710 = [1] of {int};
	chan child_Float1039 = [1] of {int};
	chan child_Bool798 = [1] of {int};
	chan child_RemoveValue1757 = [1] of {int};
	chan child_RemoveValue1756 = [1] of {int};
	chan child_RemoveValue1755 = [1] of {int};
	chan child_RemoveValue1754 = [1] of {int};
	chan child_SetString1703 = [1] of {int};
	chan child_SetInt1502 = [1] of {int};
	chan child_SetFloat1221 = [1] of {int};
	chan child_SetBool980 = [1] of {int};
	Mutexdef p_lock;
	run mutexMonitor(p_lock);
	run SetBool98(p_lock,child_SetBool980);
	child_SetBool980?0;
	run SetFloat122(p_lock,child_SetFloat1221);
	child_SetFloat1221?0;
	run SetInt150(p_lock,child_SetInt1502);
	child_SetInt1502?0;
	run SetString170(p_lock,child_SetString1703);
	child_SetString1703?0;
	run RemoveValue175(p_lock,child_RemoveValue1754);
	child_RemoveValue1754?0;
	run RemoveValue175(p_lock,child_RemoveValue1755);
	child_RemoveValue1755?0;
	run RemoveValue175(p_lock,child_RemoveValue1756);
	child_RemoveValue1756?0;
	run RemoveValue175(p_lock,child_RemoveValue1757);
	child_RemoveValue1757?0;
	run Bool79(p_lock,child_Bool798);
	child_Bool798?0;
	run Float103(p_lock,child_Float1039);
	child_Float1039?0;
	run Int127(p_lock,child_Int12710);
	child_Int12710?0;
	run String155(p_lock,child_String15511);
	child_String15511?0;
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
proctype SetFloat122(Mutexdef p_lock;chan child) {
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
proctype SetInt150(Mutexdef p_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_set452 = [1] of {int};
	run set45(p_lock,child_set452);
	child_set452?0;
	stop_process: skip;
	child!0
}
proctype SetString170(Mutexdef p_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_set453 = [1] of {int};
	run set45(p_lock,child_set453);
	child_set453?0;
	stop_process: skip;
	child!0
}
proctype RemoveValue175(Mutexdef p_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_remove624 = [1] of {int};
	run remove62(p_lock,child_remove624);
	child_remove624?0;
	stop_process: skip;
	child!0
}
proctype remove62(Mutexdef p_lock;chan child) {
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
	chan child_BoolWithFallback848 = [1] of {int};
	run BoolWithFallback84(p_lock,child_BoolWithFallback848);
	child_BoolWithFallback848?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype BoolWithFallback84(Mutexdef p_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_get548 = [1] of {int};
	run get54(p_lock,child_get548);
	child_get548?0;
	

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
proctype Float103(Mutexdef p_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_FloatWithFallback1089 = [1] of {int};
	run FloatWithFallback108(p_lock,child_FloatWithFallback1089);
	child_FloatWithFallback1089?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype FloatWithFallback108(Mutexdef p_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_get549 = [1] of {int};
	run get54(p_lock,child_get549);
	child_get549?0;
	

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
proctype Int127(Mutexdef p_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_IntWithFallback13210 = [1] of {int};
	run IntWithFallback132(p_lock,child_IntWithFallback13210);
	child_IntWithFallback13210?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype IntWithFallback132(Mutexdef p_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_get5410 = [1] of {int};
	run get54(p_lock,child_get5410);
	child_get5410?0;
	

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
proctype String155(Mutexdef p_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_StringWithFallback16011 = [1] of {int};
	run StringWithFallback160(p_lock,child_StringWithFallback16011);
	child_StringWithFallback16011?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype StringWithFallback160(Mutexdef p_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_get5411 = [1] of {int};
	run get54(p_lock,child_get5411);
	child_get5411?0;
	

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

