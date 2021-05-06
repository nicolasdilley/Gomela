
// https://github.com/grpc/grpc-go/blob/master/xds/internal/client/lds_test.go#L51
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestUnmarshalListener_ClientSide510 = [1] of {int};
	run TestUnmarshalListener_ClientSide51(child_TestUnmarshalListener_ClientSide510)
stop_process:skip
}

proctype TestUnmarshalListener_ClientSide51(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef unknownOptionalFilter_state_atomicMessageInfo_initMu;
	Mutexdef unknownFilter_state_atomicMessageInfo_initMu;
	Mutexdef serverOnlyOptionalCustomFilter_state_atomicMessageInfo_initMu;
	Mutexdef serverOnlyCustomFilter_state_atomicMessageInfo_initMu;
	Mutexdef clientOnlyCustomFilter_state_atomicMessageInfo_initMu;
	Mutexdef errOptionalFilter_state_atomicMessageInfo_initMu;
	Mutexdef errFilter_state_atomicMessageInfo_initMu;
	Mutexdef customFilter2_state_atomicMessageInfo_initMu;
	Mutexdef customOptionalFilter_state_atomicMessageInfo_initMu;
	Mutexdef typedStructFilter_state_atomicMessageInfo_initMu;
	Mutexdef customFilter_state_atomicMessageInfo_initMu;
	Mutexdef v2Lis_state_atomicMessageInfo_initMu;
	run mutexMonitor(v2Lis_state_atomicMessageInfo_initMu);
	run mutexMonitor(customFilter_state_atomicMessageInfo_initMu);
	run mutexMonitor(typedStructFilter_state_atomicMessageInfo_initMu);
	run mutexMonitor(customOptionalFilter_state_atomicMessageInfo_initMu);
	run mutexMonitor(customFilter2_state_atomicMessageInfo_initMu);
	run mutexMonitor(errFilter_state_atomicMessageInfo_initMu);
	run mutexMonitor(errOptionalFilter_state_atomicMessageInfo_initMu);
	run mutexMonitor(clientOnlyCustomFilter_state_atomicMessageInfo_initMu);
	run mutexMonitor(serverOnlyCustomFilter_state_atomicMessageInfo_initMu);
	run mutexMonitor(serverOnlyOptionalCustomFilter_state_atomicMessageInfo_initMu);
	run mutexMonitor(unknownFilter_state_atomicMessageInfo_initMu);
	run mutexMonitor(unknownOptionalFilter_state_atomicMessageInfo_initMu);
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

