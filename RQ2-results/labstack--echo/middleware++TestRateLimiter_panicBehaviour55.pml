
// https://github.com/labstack/echo/blob/master/middleware/rate_limiter_test.go#L55
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRateLimiter_panicBehaviour550 = [1] of {int};
	run TestRateLimiter_panicBehaviour55(child_TestRateLimiter_panicBehaviour550)
stop_process:skip
}

proctype TestRateLimiter_panicBehaviour55(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef inMemoryStore_mutex;
	run mutexMonitor(inMemoryStore_mutex);
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

