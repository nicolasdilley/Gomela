
// https://github.com/fyne-io/fyne/blob/master/canvas/base_internal_test.go#L11
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBase_MinSize110 = [1] of {int};
	run TestBase_MinSize11(child_TestBase_MinSize110)
stop_process:skip
}

proctype TestBase_MinSize11(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_MinSize590 = [1] of {int};
	Mutexdef base_propertyLock;
	run mutexMonitor(base_propertyLock);
	run MinSize59(base_propertyLock,child_MinSize590);
	child_MinSize590?0;
	stop_process: skip;
	child!0
}
proctype MinSize59(Mutexdef r_propertyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_propertyLock.RLock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		r_propertyLock.RUnlock!false;
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

