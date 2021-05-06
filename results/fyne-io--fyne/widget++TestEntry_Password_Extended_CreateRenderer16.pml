
// https://github.com/fyne-io/fyne/blob/master/widget/entry_password_extend_test.go#L16
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestEntry_Password_Extended_CreateRenderer160 = [1] of {int};
	run TestEntry_Password_Extended_CreateRenderer16(child_TestEntry_Password_Extended_CreateRenderer160)
stop_process:skip
}

proctype TestEntry_Password_Extended_CreateRenderer16(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef r_entry_cursorAnim_mu;
	Mutexdef r_entry_shortcut_mu;
	run mutexMonitor(r_entry_shortcut_mu);
	run mutexMonitor(r_entry_cursorAnim_mu);
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

