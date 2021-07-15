
// https://github.com/syncthing/syncthing/blob/master/lib/rand/securesource_test.go#L11
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSecureSource110 = [1] of {int};
	run TestSecureSource11(child_TestSecureSource110)
stop_process:skip
}

proctype TestSecureSource11(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Int63392 = [1] of {int};
	chan child_Int63393 = [1] of {int};
	chan child_Int63390 = [1] of {int};
	chan child_Int63391 = [1] of {int};
	Mutexdef s_mut;
	int res0 = -2;
	int res1 = -2;
	run mutexMonitor(s_mut);
	

	if
	:: res0-1 != -3 -> 
				for(i : 0.. res0-1) {
			for10: skip;
			run Int6339(s_mut,child_Int63390);
			child_Int63390?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run Int6339(s_mut,child_Int63391);
			child_Int63391?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	

	if
	:: res1-1 != -3 -> 
				for(i : 0.. res1-1) {
			for20: skip;
			run Int6339(s_mut,child_Int63392);
			child_Int63392?0;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for21: skip;
			run Int6339(s_mut,child_Int63393);
			child_Int63393?0;
			for21_end: skip
		:: true -> 
			break
		od;
		for21_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype Int6339(Mutexdef s_mut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Uint64490 = [1] of {int};
	run Uint6449(s_mut,child_Uint64490);
	child_Uint64490?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Uint6449(Mutexdef s_mut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mut.Lock!false;
	s_mut.Unlock!false;
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

