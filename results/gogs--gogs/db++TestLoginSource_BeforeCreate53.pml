
// https://github.com/gogs/gogs/blob/master/internal/db/login_sources_test.go#L53
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLoginSource_BeforeCreate530 = [1] of {int};
	run TestLoginSource_BeforeCreate53(child_TestLoginSource_BeforeCreate530)
stop_process:skip
}

proctype TestLoginSource_BeforeCreate53(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef db_Statement_Schema_cacheStore_mu;
	Mutexdef db_Statement_Settings_mu;
	run mutexMonitor(db_Statement_Settings_mu);
	run mutexMonitor(db_Statement_Schema_cacheStore_mu);
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

