
// https://github.com/fyne-io/fyne/blob/master/canvas/base_internal_test.go#L37
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBase_HideShow370 = [1] of {int};
	run TestBase_HideShow37(child_TestBase_HideShow370)
stop_process:skip
}

proctype TestBase_HideShow37(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Visible794 = [1] of {int};
	chan child_Show873 = [1] of {int};
	chan child_Visible792 = [1] of {int};
	chan child_Hide951 = [1] of {int};
	chan child_Visible790 = [1] of {int};
	Mutexdef base_propertyLock;
	run mutexMonitor(base_propertyLock);
	run Visible79(base_propertyLock,child_Visible790);
	child_Visible790?0;
	run Hide95(base_propertyLock,child_Hide951);
	child_Hide951?0;
	run Visible79(base_propertyLock,child_Visible792);
	child_Visible792?0;
	run Show87(base_propertyLock,child_Show873);
	child_Show873?0;
	run Visible79(base_propertyLock,child_Visible794);
	child_Visible794?0;
	stop_process: skip;
	child!0
}
proctype Visible79(Mutexdef r_propertyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_propertyLock.RLock!false;
	goto stop_process;
	stop_process: skip;
		r_propertyLock.RUnlock!false;
	child!0
}
proctype Hide95(Mutexdef r_propertyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_propertyLock.Lock!false;
	stop_process: skip;
		r_propertyLock.Unlock!false;
	child!0
}
proctype Show87(Mutexdef r_propertyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_propertyLock.Lock!false;
	stop_process: skip;
		r_propertyLock.Unlock!false;
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

