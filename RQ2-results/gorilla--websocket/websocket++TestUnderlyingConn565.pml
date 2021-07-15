
// https://github.com/gorilla/websocket/blob/master/conn_test.go#L565
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestUnderlyingConn5650 = [1] of {int};
	run TestUnderlyingConn565(child_TestUnderlyingConn5650)
stop_process:skip
}

proctype TestUnderlyingConn565(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_UnderlyingConn11650 = [1] of {int};
	Mutexdef c_writeErrMu;
	run mutexMonitor(c_writeErrMu);
	run UnderlyingConn1165(c_writeErrMu,child_UnderlyingConn11650);
	child_UnderlyingConn11650?0;
	stop_process: skip;
	child!0
}
proctype UnderlyingConn1165(Mutexdef c_writeErrMu;chan child) {
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

