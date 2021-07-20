// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/fyne-io/fyne/blob/9b5a176fe1dc80beae72a3074d0d5cd2b409637c/dialog/form_test.go#L43
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFormDialog_ValidCanSubmit430 = [1] of {int};
	run TestFormDialog_ValidCanSubmit43(child_TestFormDialog_ValidCanSubmit430);
	run receiver(child_TestFormDialog_ValidCanSubmit430)
stop_process:skip
}

proctype TestFormDialog_ValidCanSubmit43(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetText210 = [1] of {int};
	Mutexdef validatingEntry_cursorAnim_mu;
	Mutexdef validatingEntry_shortcut_mu;
	run mutexMonitor(validatingEntry_shortcut_mu);
	run mutexMonitor(validatingEntry_cursorAnim_mu);
	

	if
	:: true -> 
		run SetText21(validatingEntry_cursorAnim_mu,validatingEntry_shortcut_mu,child_SetText210);
		child_SetText210?0
	fi;
	stop_process: skip;
	child!0
}
proctype SetText21(Mutexdef i_cursorAnim_mu;Mutexdef i_shortcut_mu;chan child) {
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

