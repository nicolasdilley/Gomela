// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/fyne-io/fyne/blob/9b5a176fe1dc80beae72a3074d0d5cd2b409637c/dialog/file_test.go#L290
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestShowFileSave2900 = [1] of {int};
	run TestShowFileSave290(child_TestShowFileSave2900);
	run receiver(child_TestShowFileSave2900)
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
	int files_Objects = -2; // opt files_Objects
	run mutexMonitor(nameEntry_shortcut_mu);
	run mutexMonitor(nameEntry_cursorAnim_mu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Type229(nameEntry_cursorAnim_mu,nameEntry_shortcut_mu,child_Type2290);
	child_Type2290?0;
		stop_process: skip;
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

