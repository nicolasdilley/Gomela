
// https://github.com/fyne-io/fyne/blob/master/widget/entry_test.go#L270
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestEntry_HidePopUpOnEntry2700 = [1] of {int};
	run TestEntry_HidePopUpOnEntry270(child_TestEntry_HidePopUpOnEntry2700)
stop_process:skip
}

proctype TestEntry_HidePopUpOnEntry270(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Type2291 = [1] of {int};
	chan child_TapSecondaryAt2200 = [1] of {int};
	Mutexdef entry_cursorAnim_mu;
	Mutexdef entry_shortcut_mu;
	run mutexMonitor(entry_shortcut_mu);
	run mutexMonitor(entry_cursorAnim_mu);
	run TapSecondaryAt220(entry_shortcut_mu,entry_cursorAnim_mu,child_TapSecondaryAt2200);
	child_TapSecondaryAt2200?0;
	run Type229(entry_shortcut_mu,entry_cursorAnim_mu,child_Type2291);
	child_Type2291?0;
	stop_process: skip;
	child!0
}
proctype TapSecondaryAt220(Mutexdef obj_shortcut_mu;Mutexdef obj_cursorAnim_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_handleFocusOnTap2931 = [1] of {int};
	chan child_prepareTap2770 = [1] of {int};
	run prepareTap277(obj_shortcut_mu,obj_cursorAnim_mu,child_prepareTap2770);
	child_prepareTap2770?0;
	run handleFocusOnTap293(obj_shortcut_mu,obj_cursorAnim_mu,child_handleFocusOnTap2931);
	child_handleFocusOnTap2931?0;
	stop_process: skip;
	child!0
}
proctype prepareTap277(Mutexdef obj_shortcut_mu;Mutexdef obj_cursorAnim_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype handleFocusOnTap293(Mutexdef obj_shortcut_mu;Mutexdef obj_cursorAnim_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

