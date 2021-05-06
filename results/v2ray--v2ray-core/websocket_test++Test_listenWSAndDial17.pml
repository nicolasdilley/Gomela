
// https://github.com/v2ray/v2ray-core/blob/master/transport/internet/websocket/ws_test.go#L17
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Test_listenWSAndDial170 = [1] of {int};
	run Test_listenWSAndDial17(child_Test_listenWSAndDial170)
stop_process:skip
}

proctype Test_listenWSAndDial17(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef streamSettings_SocketSettings_state_atomicMessageInfo_initMu;
	run mutexMonitor(streamSettings_SocketSettings_state_atomicMessageInfo_initMu);
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

