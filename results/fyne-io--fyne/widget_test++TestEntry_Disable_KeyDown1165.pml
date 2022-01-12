// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/fyne-io/fyne/blob//widget/entry_test.go#L1165
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestEntry_Disable_KeyDown11650 = [1] of {int};
	run TestEntry_Disable_KeyDown1165(child_TestEntry_Disable_KeyDown11650);
	run receiver(child_TestEntry_Disable_KeyDown11650)
stop_process:skip
}

proctype TestEntry_Disable_KeyDown1165(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Type2294 = [1] of {int};
	chan child_Enable2743 = [1] of {int};
	chan child_Type2292 = [1] of {int};
	chan child_Disable2041 = [1] of {int};
	chan child_Type2290 = [1] of {int};
	Mutexdef entry_cursorAnim_mu;
	Mutexdef entry_shortcut_mu;
	run mutexMonitor(entry_shortcut_mu);
	run mutexMonitor(entry_cursorAnim_mu);
	run Type229(entry_cursorAnim_mu,entry_shortcut_mu,child_Type2290);
	child_Type2290?0;
	run Disable204(entry_cursorAnim_mu,entry_shortcut_mu,child_Disable2041);
	child_Disable2041?0;
	run Type229(entry_cursorAnim_mu,entry_shortcut_mu,child_Type2292);
	child_Type2292?0;
	run Enable274(entry_cursorAnim_mu,entry_shortcut_mu,child_Enable2743);
	child_Enable2743?0;
	run Type229(entry_cursorAnim_mu,entry_shortcut_mu,child_Type2294);
	child_Type2294?0;
	stop_process: skip;
	child!0
}
proctype Type229(Mutexdef obj_cursorAnim_mu;Mutexdef obj_shortcut_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Disable204(Mutexdef e_cursorAnim_mu;Mutexdef e_shortcut_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Enable274(Mutexdef e_cursorAnim_mu;Mutexdef e_shortcut_mu;chan child) {
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

proctype receiver(chan c) {
c?0
}

