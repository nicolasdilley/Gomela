
// https://github.com/traefik/traefik/blob/master/pkg/safe/safe_test.go#L5
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSafe50 = [1] of {int};
	run TestSafe5(child_TestSafe50)
stop_process:skip
}

proctype TestSafe5(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get194 = [1] of {int};
	chan child_Get193 = [1] of {int};
	chan child_Set262 = [1] of {int};
	chan child_Get191 = [1] of {int};
	chan child_Get190 = [1] of {int};
	Mutexdef s_lock;
	run mutexMonitor(s_lock);
	run Get19(s_lock,child_Get190);
	child_Get190?0;
	

	if
	:: true -> 
		run Get19(s_lock,child_Get191);
		child_Get191?0
	:: true;
	fi;
	run Set26(s_lock,child_Set262);
	child_Set262?0;
	run Get19(s_lock,child_Get193);
	child_Get193?0;
	

	if
	:: true -> 
		run Get19(s_lock,child_Get194);
		child_Get194?0
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype Get19(Mutexdef s_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_lock.RLock!false;
	goto stop_process;
	stop_process: skip;
		s_lock.RUnlock!false;
	child!0
}
proctype Set26(Mutexdef s_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_lock.Lock!false;
	stop_process: skip;
		s_lock.Unlock!false;
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

