
// https://github.com/moby/moby/blob/master/daemon/logger/adapter_test.go#L26
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_newMockLoggingPlugin260 = [1] of {int};
	run newMockLoggingPlugin26(child_newMockLoggingPlugin260)
stop_process:skip
}

proctype newMockLoggingPlugin26(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef w_p_once_m;
	Mutexdef w_p_wrMu;
	Mutexdef r_p_once_m;
	Mutexdef r_p_wrMu;
	run mutexMonitor(r_p_wrMu);
	run mutexMonitor(r_p_once_m);
	run mutexMonitor(w_p_wrMu);
	run mutexMonitor(w_p_once_m);
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

