
// https://github.com/fyne-io/fyne/blob/master/widget/entry_test.go#L442
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestEntry_OnKeyDown4420 = [1] of {int};
	run TestEntry_OnKeyDown442(child_TestEntry_OnKeyDown4420)
stop_process:skip
}

proctype TestEntry_OnKeyDown442(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Type2290 = [1] of {int};
	Mutexdef entry_cursorAnim_mu;
	Mutexdef entry_shortcut_mu;
	run mutexMonitor(entry_shortcut_mu);
	run mutexMonitor(entry_cursorAnim_mu);
	run Type229(entry_shortcut_mu,entry_cursorAnim_mu,child_Type2290);
	child_Type2290?0;
	stop_process: skip;
	child!0
}
proctype Type229(Mutexdef obj_shortcut_mu;Mutexdef obj_cursorAnim_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

