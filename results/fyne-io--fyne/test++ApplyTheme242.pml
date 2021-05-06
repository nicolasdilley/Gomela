
// https://github.com/fyne-io/fyne/blob/master/test/test.go#L242
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_ApplyTheme2420 = [1] of {int};
	run ApplyTheme242(child_ApplyTheme2420)
stop_process:skip
}

proctype ApplyTheme242(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_lastAppliedTheme840 = [1] of {int};
	Mutexdef a_propertyLock;
	Mutexdef a_driver_windowsMutex;
	run mutexMonitor(a_driver_windowsMutex);
	run mutexMonitor(a_propertyLock);
	run lastAppliedTheme84(a_driver_windowsMutex,a_propertyLock,child_lastAppliedTheme840);
	child_lastAppliedTheme840?0;
	stop_process: skip;
	child!0
}
proctype lastAppliedTheme84(Mutexdef a_driver_windowsMutex;Mutexdef a_propertyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	a_propertyLock.Lock!false;
	goto stop_process;
	stop_process: skip;
		a_propertyLock.Unlock!false;
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

