
// https://github.com/moby/moby/blob/master/pkg/discovery/kv/kv_test.go#L25
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestInitialize250 = [1] of {int};
	run TestInitialize25(child_TestInitialize250)
stop_process:skip
}

proctype TestInitialize25(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef s_Options_TLS_mutex;
	Mutexdef storeMock_Options_TLS_mutex;
	run mutexMonitor(storeMock_Options_TLS_mutex);
	run mutexMonitor(s_Options_TLS_mutex);
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

