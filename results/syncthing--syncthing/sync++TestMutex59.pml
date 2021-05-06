
// https://github.com/syncthing/syncthing/blob/master/lib/sync/sync_test.go#L59
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestMutex590 = [1] of {int};
	run TestMutex59(child_TestMutex590)
stop_process:skip
}

proctype TestMutex59(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_wind3451 = [1] of {int};
	chan child_wind3450 = [1] of {int};
	Mutexdef msgmut;
	Mutexdef clock_mut;
	run mutexMonitor(clock_mut);
	run mutexMonitor(msgmut);
	run wind345(clock_mut,child_wind3450);
	child_wind3450?0;
	run wind345(clock_mut,child_wind3451);
	child_wind3451?0;
	stop_process: skip;
	child!0
}
proctype wind345(Mutexdef t_mut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	t_mut.Lock!false;
	t_mut.Unlock!false;
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

