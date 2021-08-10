// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/fyne-io/fyne/blob/9b5a176fe1dc80beae72a3074d0d5cd2b409637c/internal/driver/glfw/menu_test.go#L14
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Test_Menu_Empty140 = [1] of {int};
	run Test_Menu_Empty14(child_Test_Menu_Empty140);
	run receiver(child_Test_Menu_Empty140)
stop_process:skip
}

proctype Test_Menu_Empty14(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_buildMenuOverlay70 = [1] of {int};
	Wgdef w_eventWait;
	Mutexdef w_eventLock;
	Mutexdef w_driver_windowLock;
	Mutexdef w_canvas_dirtyMutex;
	Mutexdef w_createLock_m;
	Mutexdef w_viewLock;
	run mutexMonitor(w_viewLock);
	run mutexMonitor(w_createLock_m);
	run mutexMonitor(w_canvas_dirtyMutex);
	run mutexMonitor(w_driver_windowLock);
	run mutexMonitor(w_eventLock);
	run wgMonitor(w_eventWait);
	run buildMenuOverlay7(w_canvas_dirtyMutex,child_buildMenuOverlay70);
	child_buildMenuOverlay70?0;
	stop_process: skip;
	child!0
}
proctype buildMenuOverlay7(Mutexdef c_dirtyMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewMenuBar250 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run NewMenuBar25(c_dirtyMutex,child_NewMenuBar250);
	child_NewMenuBar250?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewMenuBar25(Mutexdef canvas_dirtyMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_mainMenu_Items = -2; // opt var_mainMenu_Items
	goto stop_process;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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
