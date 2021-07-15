
// https://github.com/labstack/echo/blob/master/middleware/rate_limiter_test.go#L351
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRateLimiterMemoryStore_cleanupStaleVisitors3510 = [1] of {int};
	run TestRateLimiterMemoryStore_cleanupStaleVisitors351(child_TestRateLimiterMemoryStore_cleanupStaleVisitors3510)
stop_process:skip
}

proctype TestRateLimiterMemoryStore_cleanupStaleVisitors351(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_cleanupStaleVisitors2541 = [1] of {int};
	chan child_Allow2340 = [1] of {int};
	Mutexdef inMemoryStore_mutex;
	run mutexMonitor(inMemoryStore_mutex);
	run Allow234(inMemoryStore_mutex,child_Allow2340);
	child_Allow2340?0;
	run cleanupStaleVisitors254(inMemoryStore_mutex,child_cleanupStaleVisitors2541);
	child_cleanupStaleVisitors2541?0;
	stop_process: skip;
	child!0
}
proctype Allow234(Mutexdef store_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_cleanupStaleVisitors2540 = [1] of {int};
	store_mutex.Lock!false;
	

	if
	:: true -> 
		run cleanupStaleVisitors254(store_mutex,child_cleanupStaleVisitors2540);
		child_cleanupStaleVisitors2540?0
	:: true;
	fi;
	store_mutex.Unlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype cleanupStaleVisitors254(Mutexdef store_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

