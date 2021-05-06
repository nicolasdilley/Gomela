
// https://github.com/fyne-io/fyne/blob/master/dialog/form_test.go#L112
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_controlFormDialog1120 = [1] of {int};
	run controlFormDialog112(child_controlFormDialog1120)
stop_process:skip
}

proctype controlFormDialog112(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef controlEntry2_cursorAnim_mu;
	Mutexdef controlEntry2_shortcut_mu;
	Mutexdef controlEntry_cursorAnim_mu;
	Mutexdef controlEntry_shortcut_mu;
	run mutexMonitor(controlEntry_shortcut_mu);
	run mutexMonitor(controlEntry_cursorAnim_mu);
	run mutexMonitor(controlEntry2_shortcut_mu);
	run mutexMonitor(controlEntry2_cursorAnim_mu);
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

