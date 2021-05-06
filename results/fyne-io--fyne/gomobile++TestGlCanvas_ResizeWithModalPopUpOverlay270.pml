
// https://github.com/fyne-io/fyne/blob/master/internal/driver/gomobile/canvas_test.go#L270
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGlCanvas_ResizeWithModalPopUpOverlay2700 = [1] of {int};
	run TestGlCanvas_ResizeWithModalPopUpOverlay270(child_TestGlCanvas_ResizeWithModalPopUpOverlay2700)
stop_process:skip
}

proctype TestGlCanvas_ResizeWithModalPopUpOverlay270(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_resize3002 = [1] of {int};
	chan child_NewModalPopUp1421 = [1] of {int};
	chan child_SetContent1730 = [1] of {int};
	Mutexdef c_shortcut_mu;
	Mutexdef c_overlays_propertyLock;
	run mutexMonitor(c_overlays_propertyLock);
	run mutexMonitor(c_shortcut_mu);
	run SetContent173(c_overlays_propertyLock,c_shortcut_mu,child_SetContent1730);
	child_SetContent1730?0;
	run NewModalPopUp142(c_overlays_propertyLock,c_shortcut_mu,child_NewModalPopUp1421);
	child_NewModalPopUp1421?0;
	run resize300(c_overlays_propertyLock,c_shortcut_mu,child_resize3002);
	child_resize3002?0;
	stop_process: skip;
	child!0
}
proctype SetContent173(Mutexdef c_overlays_propertyLock;Mutexdef c_shortcut_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_sizeContent3330 = [1] of {int};
	run sizeContent333(c_overlays_propertyLock,c_shortcut_mu,child_sizeContent3330);
	child_sizeContent3330?0;
	stop_process: skip;
	child!0
}
proctype sizeContent333(Mutexdef c_overlays_propertyLock;Mutexdef c_shortcut_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_InteractiveArea1280 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run InteractiveArea128(c_overlays_propertyLock,c_shortcut_mu,child_InteractiveArea1280);
	child_InteractiveArea1280?0;
	stop_process: skip;
	child!0
}
proctype InteractiveArea128(Mutexdef c_overlays_propertyLock;Mutexdef c_shortcut_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Size1870 = [1] of {int};
	

	if
	:: true -> 
		run Size187(c_overlays_propertyLock,c_shortcut_mu,child_Size1870);
		child_Size1870?0;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Size187(Mutexdef c_overlays_propertyLock;Mutexdef c_shortcut_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewModalPopUp142(Mutexdef canvas_overlays_propertyLock;Mutexdef canvas_shortcut_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newModalPopUp1341 = [1] of {int};
	run newModalPopUp134(canvas_overlays_propertyLock,canvas_shortcut_mu,child_newModalPopUp1341);
	child_newModalPopUp1341?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype newModalPopUp134(Mutexdef canvas_overlays_propertyLock;Mutexdef canvas_shortcut_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype resize300(Mutexdef c_overlays_propertyLock;Mutexdef c_shortcut_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_sizeContent3332 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sizeContent333(c_overlays_propertyLock,c_shortcut_mu,child_sizeContent3332);
	child_sizeContent3332?0;
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

