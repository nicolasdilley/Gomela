
// https://github.com/fyne-io/fyne/blob/master/internal/driver/glfw/window_test.go#L65
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
	chan child_TestGLDriver_CreateWindow_EmptyTitle650 = [1] of {int};
	run TestGLDriver_CreateWindow_EmptyTitle65(child_TestGLDriver_CreateWindow_EmptyTitle650)
stop_process:skip
}

proctype TestGLDriver_CreateWindow_EmptyTitle65(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Title1000 = [1] of {int};
	Wgdef w_eventWait;
	Mutexdef w_eventLock;
	Mutexdef w_driver_animation_animationMutex;
	Mutexdef w_driver_windowLock;
	Mutexdef w_canvas_dirtyMutex;
	Mutexdef w_canvas_shortcut_mu;
	Mutexdef w_canvas_overlays_propertyLock;
	Mutexdef w_createLock_m;
	Mutexdef w_viewLock;
	run mutexMonitor(w_viewLock);
	run mutexMonitor(w_createLock_m);
	run mutexMonitor(w_canvas_overlays_propertyLock);
	run mutexMonitor(w_canvas_shortcut_mu);
	run mutexMonitor(w_canvas_dirtyMutex);
	run mutexMonitor(w_driver_windowLock);
	run mutexMonitor(w_driver_animation_animationMutex);
	run mutexMonitor(w_eventLock);
	run wgMonitor(w_eventWait);
	run Title100(w_eventWait,w_viewLock,w_createLock_m,w_canvas_overlays_propertyLock,w_canvas_shortcut_mu,w_canvas_dirtyMutex,w_driver_windowLock,w_driver_animation_animationMutex,w_eventLock,child_Title1000);
	child_Title1000?0;
	stop_process: skip;
	child!0
}
proctype Title100(Wgdef w_eventWait;Mutexdef w_viewLock;Mutexdef w_createLock_m;Mutexdef w_canvas_overlays_propertyLock;Mutexdef w_canvas_shortcut_mu;Mutexdef w_canvas_dirtyMutex;Mutexdef w_driver_windowLock;Mutexdef w_driver_animation_animationMutex;Mutexdef w_eventLock;chan child) {
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

