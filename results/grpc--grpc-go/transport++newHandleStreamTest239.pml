
// https://github.com/grpc/grpc-go/blob/master/internal/transport/handler_server_test.go#L239
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_newHandleStreamTest2390 = [1] of {int};
	run newHandleStreamTest239(child_newHandleStreamTest2390)
stop_process:skip
}

proctype newHandleStreamTest239(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef bodyw_p_once_m;
	Mutexdef bodyw_p_wrMu;
	Mutexdef bodyr_p_once_m;
	Mutexdef bodyr_p_wrMu;
	run mutexMonitor(bodyr_p_wrMu);
	run mutexMonitor(bodyr_p_once_m);
	run mutexMonitor(bodyw_p_wrMu);
	run mutexMonitor(bodyw_p_once_m);
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

