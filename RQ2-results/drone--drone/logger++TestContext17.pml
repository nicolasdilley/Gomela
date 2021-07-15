
// https://github.com/drone/drone/blob/master/logger/logger_test.go#L17
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContext170 = [1] of {int};
	run TestContext17(child_TestContext170)
stop_process:skip
}

proctype TestContext17(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef got_Logger_mu_lock;
	chan child_WithContext320 = [1] of {int};
	Mutexdef entry_Logger_mu_lock;
	run mutexMonitor(entry_Logger_mu_lock);
	run WithContext32(entry_Logger_mu_lock,child_WithContext320);
	child_WithContext320?0;
	run mutexMonitor(got_Logger_mu_lock);
	stop_process: skip;
	child!0
}
proctype WithContext32(Mutexdef logger_Logger_mu_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

