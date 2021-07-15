
// https://github.com/k6io/k6/blob/master/core/engine_test.go#L171
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestEngineAtTime1710 = [1] of {int};
	run TestEngineAtTime171(child_TestEngineAtTime1710)
stop_process:skip
}

proctype TestEngineAtTime171(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef __MetricsLock;
	Mutexdef __stopOnce_m;
	Mutexdef __logger_Logger_mu_lock;
	Mutexdef __executionState_pauseStateLock;
	run mutexMonitor(__executionState_pauseStateLock);
	run mutexMonitor(__logger_Logger_mu_lock);
	run mutexMonitor(__stopOnce_m);
	run mutexMonitor(__MetricsLock);
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

