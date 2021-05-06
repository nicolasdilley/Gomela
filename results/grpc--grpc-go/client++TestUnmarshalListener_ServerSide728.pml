
// https://github.com/grpc/grpc-go/blob/master/xds/internal/client/lds_test.go#L728
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestUnmarshalListener_ServerSide7280 = [1] of {int};
	run TestUnmarshalListener_ServerSide728(child_TestUnmarshalListener_ServerSide7280)
stop_process:skip
}

proctype TestUnmarshalListener_ServerSide728(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef listenerWithValidationContext_state_atomicMessageInfo_initMu;
	Mutexdef listenerNoValidationContext_state_atomicMessageInfo_initMu;
	Mutexdef listenerEmptyTransportSocket_state_atomicMessageInfo_initMu;
	run mutexMonitor(listenerEmptyTransportSocket_state_atomicMessageInfo_initMu);
	run mutexMonitor(listenerNoValidationContext_state_atomicMessageInfo_initMu);
	run mutexMonitor(listenerWithValidationContext_state_atomicMessageInfo_initMu);
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

