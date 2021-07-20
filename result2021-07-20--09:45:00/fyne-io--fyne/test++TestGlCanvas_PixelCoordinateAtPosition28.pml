// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/fyne-io/fyne/blob/9b5a176fe1dc80beae72a3074d0d5cd2b409637c/test/testcanvas_test.go#L28
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGlCanvas_PixelCoordinateAtPosition280 = [1] of {int};
	run TestGlCanvas_PixelCoordinateAtPosition28(child_TestGlCanvas_PixelCoordinateAtPosition280);
	run receiver(child_TestGlCanvas_PixelCoordinateAtPosition280)
stop_process:skip
}

proctype TestGlCanvas_PixelCoordinateAtPosition28(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_PixelCoordinateForPosition1440 = [1] of {int};
	Mutexdef c_propertyLock;
	Mutexdef c_overlays_propertyLock;
	run mutexMonitor(c_overlays_propertyLock);
	run mutexMonitor(c_propertyLock);
	run PixelCoordinateForPosition144(c_overlays_propertyLock,c_propertyLock,child_PixelCoordinateForPosition1440);
	child_PixelCoordinateForPosition1440?0;
	stop_process: skip;
	child!0
}
proctype PixelCoordinateForPosition144(Mutexdef c_overlays_propertyLock;Mutexdef c_propertyLock;chan child) {
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
