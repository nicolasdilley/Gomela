
// https://github.com/grpc/grpc-go/blob/master/benchmark/benchmark.go#L80
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_StreamingCall800 = [1] of {int};
	run StreamingCall80(child_StreamingCall800)
stop_process:skip
}

proctype StreamingCall80(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_setPayload440 = [1] of {int};
	Mutexdef in_ExpectCompressed_state_atomicMessageInfo_initMu;
	Mutexdef in_ResponseStatus_state_atomicMessageInfo_initMu;
	Mutexdef in_ResponseCompressed_state_atomicMessageInfo_initMu;
	Mutexdef in_Payload_state_atomicMessageInfo_initMu;
	Mutexdef in_state_atomicMessageInfo_initMu;
	Mutexdef response_Payload_state_atomicMessageInfo_initMu;
	Mutexdef response_state_atomicMessageInfo_initMu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(response_state_atomicMessageInfo_initMu);
	run mutexMonitor(response_Payload_state_atomicMessageInfo_initMu);
	run mutexMonitor(in_state_atomicMessageInfo_initMu);
	run mutexMonitor(in_Payload_state_atomicMessageInfo_initMu);
	run mutexMonitor(in_ResponseCompressed_state_atomicMessageInfo_initMu);
	run mutexMonitor(in_ResponseStatus_state_atomicMessageInfo_initMu);
	run mutexMonitor(in_ExpectCompressed_state_atomicMessageInfo_initMu);
	do
	:: true -> 
		for10: skip;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run setPayload44(response_Payload_state_atomicMessageInfo_initMu,child_setPayload440);
		child_setPayload440?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		for10_end: skip
	od;
	for10_exit: skip;
	stop_process: skip;
	child!0
}
proctype setPayload44(Mutexdef p_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true;
	fi;
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

