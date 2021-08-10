// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/fyne-io/fyne/blob/9b5a176fe1dc80beae72a3074d0d5cd2b409637c/internal/driver/glfw/canvas_test.go#L207
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGlCanvas_Focus_BeforeVisible2070 = [1] of {int};
	run TestGlCanvas_Focus_BeforeVisible207(child_TestGlCanvas_Focus_BeforeVisible2070);
	run receiver(child_TestGlCanvas_Focus_BeforeVisible2070)
stop_process:skip
}

proctype TestGlCanvas_Focus_BeforeVisible207(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Focus760 = [1] of {int};
	Mutexdef c_dirtyMutex;
	Mutexdef c_shortcut_mu;
	Mutexdef c_overlays_propertyLock;
	Mutexdef e_cursorAnim_mu;
	Mutexdef e_shortcut_mu;
	run mutexMonitor(e_shortcut_mu);
	run mutexMonitor(e_cursorAnim_mu);
	run mutexMonitor(c_overlays_propertyLock);
	run mutexMonitor(c_shortcut_mu);
	run mutexMonitor(c_dirtyMutex);
	run Focus76(c_dirtyMutex,c_overlays_propertyLock,c_shortcut_mu,e_cursorAnim_mu,e_shortcut_mu,child_Focus760);
	child_Focus760?0;
	stop_process: skip;
	child!0
}
proctype Focus76(Mutexdef c_dirtyMutex;Mutexdef c_overlays_propertyLock;Mutexdef c_shortcut_mu;Mutexdef obj_cursorAnim_mu;Mutexdef obj_shortcut_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_focusManager3760 = [1] of {int};
	int var_focusMgrs = -2; // opt var_focusMgrs
	run focusManager376(c_dirtyMutex,c_overlays_propertyLock,c_shortcut_mu,child_focusManager3760);
	child_focusManager3760?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype focusManager376(Mutexdef c_dirtyMutex;Mutexdef c_overlays_propertyLock;Mutexdef c_shortcut_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_isMenuActive3950 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run isMenuActive395(c_dirtyMutex,c_overlays_propertyLock,c_shortcut_mu,child_isMenuActive3950);
	child_isMenuActive3950?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype isMenuActive395(Mutexdef c_dirtyMutex;Mutexdef c_overlays_propertyLock;Mutexdef c_shortcut_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

proctype receiver(chan c) {
c?0
}

