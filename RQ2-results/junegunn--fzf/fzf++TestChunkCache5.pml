
// https://github.com/junegunn/fzf/blob/master/src/cache_test.go#L5
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestChunkCache50 = [1] of {int};
	run TestChunkCache5(child_TestChunkCache50)
stop_process:skip
}

proctype TestChunkCache5(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Add202 = [1] of {int};
	chan child_Add201 = [1] of {int};
	chan child_Add200 = [1] of {int};
	Mutexdef cache_mutex;
	run mutexMonitor(cache_mutex);
	run Add20(cache_mutex,child_Add200);
	child_Add200?0;
	run Add20(cache_mutex,child_Add201);
	child_Add201?0;
	run Add20(cache_mutex,child_Add202);
	child_Add202?0;
	stop_process: skip;
	child!0
}
proctype Add20(Mutexdef cc_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	cc_mutex.Lock!false;
	stop_process: skip;
		cc_mutex.Unlock!false;
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

