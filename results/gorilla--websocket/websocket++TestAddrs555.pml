
// https://github.com/gorilla/websocket/blob/master/conn_test.go#L555
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAddrs5550 = [1] of {int};
	run TestAddrs555(child_TestAddrs5550)
stop_process:skip
}

proctype TestAddrs555(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RemoteAddr3533 = [1] of {int};
	chan child_RemoteAddr3532 = [1] of {int};
	chan child_LocalAddr3481 = [1] of {int};
	chan child_LocalAddr3480 = [1] of {int};
	Mutexdef c_writeErrMu;
	run mutexMonitor(c_writeErrMu);
	run LocalAddr348(c_writeErrMu,child_LocalAddr3480);
	child_LocalAddr3480?0;
	

	if
	:: true -> 
		run LocalAddr348(c_writeErrMu,child_LocalAddr3481);
		child_LocalAddr3481?0
	:: true;
	fi;
	run RemoteAddr353(c_writeErrMu,child_RemoteAddr3532);
	child_RemoteAddr3532?0;
	

	if
	:: true -> 
		run RemoteAddr353(c_writeErrMu,child_RemoteAddr3533);
		child_RemoteAddr3533?0
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype LocalAddr348(Mutexdef c_writeErrMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype RemoteAddr353(Mutexdef c_writeErrMu;chan child) {
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

