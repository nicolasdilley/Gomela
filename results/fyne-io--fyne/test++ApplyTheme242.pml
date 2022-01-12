// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/fyne-io/fyne/blob//test/test.go#L242
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_ApplyTheme2420 = [1] of {int};
	run ApplyTheme242(child_ApplyTheme2420);
	run receiver(child_ApplyTheme2420)
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
	goto defer1;
		defer1: skip;
	a_propertyLock.Unlock!false;
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

