
// https://github.com/grpc/grpc-go/blob/master/benchmark/benchmark.go#L223
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_DoUnaryCall2230 = [1] of {int};
	run DoUnaryCall223(child_DoUnaryCall2230)
stop_process:skip
}

proctype DoUnaryCall223(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_UnaryCall690 = [1] of {int};
	Mutexdef __Payload_state_atomicMessageInfo_initMu;
	Mutexdef __state_atomicMessageInfo_initMu;
	Mutexdef req_ExpectCompressed_state_atomicMessageInfo_initMu;
	Mutexdef req_ResponseStatus_state_atomicMessageInfo_initMu;
	Mutexdef req_ResponseCompressed_state_atomicMessageInfo_initMu;
	Mutexdef req_Payload_state_atomicMessageInfo_initMu;
	Mutexdef req_state_atomicMessageInfo_initMu;
	Mutexdef pl_state_atomicMessageInfo_initMu;
	run mutexMonitor(pl_state_atomicMessageInfo_initMu);
	run mutexMonitor(req_state_atomicMessageInfo_initMu);
	run mutexMonitor(req_Payload_state_atomicMessageInfo_initMu);
	run mutexMonitor(req_ResponseCompressed_state_atomicMessageInfo_initMu);
	run mutexMonitor(req_ResponseStatus_state_atomicMessageInfo_initMu);
	run mutexMonitor(req_ExpectCompressed_state_atomicMessageInfo_initMu);
	run mutexMonitor(__state_atomicMessageInfo_initMu);
	run mutexMonitor(__Payload_state_atomicMessageInfo_initMu);
	run UnaryCall69(req_state_atomicMessageInfo_initMu,req_Payload_state_atomicMessageInfo_initMu,req_ResponseCompressed_state_atomicMessageInfo_initMu,req_ResponseStatus_state_atomicMessageInfo_initMu,req_ExpectCompressed_state_atomicMessageInfo_initMu,child_UnaryCall690);
	child_UnaryCall690?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype UnaryCall69(Mutexdef in_state_atomicMessageInfo_initMu;Mutexdef in_Payload_state_atomicMessageInfo_initMu;Mutexdef in_ResponseCompressed_state_atomicMessageInfo_initMu;Mutexdef in_ResponseStatus_state_atomicMessageInfo_initMu;Mutexdef in_ExpectCompressed_state_atomicMessageInfo_initMu;chan child) {
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

