
// https://github.com/fyne-io/fyne/blob/master/internal/driver/glfw/canvas_test.go#L207
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGlCanvas_Focus_BeforeVisible2070 = [1] of {int};
	run TestGlCanvas_Focus_BeforeVisible207(child_TestGlCanvas_Focus_BeforeVisible2070)
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
	run Focus76(c_overlays_propertyLock,c_shortcut_mu,c_dirtyMutex,e_shortcut_mu,e_cursorAnim_mu,child_Focus760);
	child_Focus760?0;
	stop_process: skip;
	child!0
}
proctype Focus76(Mutexdef c_overlays_propertyLock;Mutexdef c_shortcut_mu;Mutexdef c_dirtyMutex;Mutexdef obj_shortcut_mu;Mutexdef obj_cursorAnim_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Focus762 = [1] of {int};
	chan child_Focus763 = [1] of {int};
	chan child_Focus761 = [1] of {int};
	chan child_focusManager3760 = [1] of {int};
	int focusMgrs=0;
	run focusManager376(c_overlays_propertyLock,c_shortcut_mu,c_dirtyMutex,child_focusManager3760);
	child_focusManager3760?0;
	run Focus76(obj_shortcut_mu,obj_cursorAnim_mu,child_Focus761);
	child_Focus761?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: focusMgrs-1 != -3 -> 
				for(i : 0.. focusMgrs-1) {
			for10: skip;
			

			if
			:: true -> 
				goto for10_end
			:: true;
			fi;
			

			if
			:: true -> 
				run Focus76(obj_shortcut_mu,obj_cursorAnim_mu,child_Focus762);
				child_Focus762?0;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true;
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			

			if
			:: true -> 
				goto for11_end
			:: true;
			fi;
			

			if
			:: true -> 
				run Focus76(obj_shortcut_mu,obj_cursorAnim_mu,child_Focus763);
				child_Focus763?0;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true;
			fi;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype focusManager376(Mutexdef c_overlays_propertyLock;Mutexdef c_shortcut_mu;Mutexdef c_dirtyMutex;chan child) {
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
	run isMenuActive395(c_overlays_propertyLock,c_shortcut_mu,c_dirtyMutex,child_isMenuActive3950);
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
proctype isMenuActive395(Mutexdef c_overlays_propertyLock;Mutexdef c_shortcut_mu;Mutexdef c_dirtyMutex;chan child) {
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


