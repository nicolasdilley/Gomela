
// https://github.com/ethereum/go-ethereum/blob/master/rpc/websocket.go#L208
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_DialWebsocket2080 = [1] of {int};
	run DialWebsocket208(child_DialWebsocket2080)
stop_process:skip
}

proctype DialWebsocket208(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DialWebsocketWithDialer1850 = [1] of {int};
	Mutexdef dialer_TLSClientConfig_mutex;
	run mutexMonitor(dialer_TLSClientConfig_mutex);
	run DialWebsocketWithDialer185(dialer_TLSClientConfig_mutex,child_DialWebsocketWithDialer1850);
	child_DialWebsocketWithDialer1850?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype DialWebsocketWithDialer185(Mutexdef dialer_TLSClientConfig_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

