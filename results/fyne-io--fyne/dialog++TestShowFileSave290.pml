
// https://github.com/fyne-io/fyne/blob/master/dialog/file_test.go#L290
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestShowFileSave2900 = [1] of {int};
	run TestShowFileSave290(child_TestShowFileSave2900)
stop_process:skip
}

proctype TestShowFileSave290(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Type2290 = [1] of {int};
	Mutexdef nameEntry_cursorAnim_mu;
	Mutexdef nameEntry_shortcut_mu;
	run mutexMonitor(nameEntry_shortcut_mu);
	run mutexMonitor(nameEntry_cursorAnim_mu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Type229(nameEntry_shortcut_mu,nameEntry_cursorAnim_mu,child_Type2290);
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

