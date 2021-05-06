
// https://github.com/grpc/grpc-go/blob/master/interop/test_utils.go#L83
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_DoLargeUnaryCall830 = [1] of {int};
	run DoLargeUnaryCall83(child_DoLargeUnaryCall830)
stop_process:skip
}

proctype DoLargeUnaryCall83(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef reply_Payload_state_atomicMessageInfo_initMu;
	Mutexdef reply_state_atomicMessageInfo_initMu;
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
	run mutexMonitor(reply_state_atomicMessageInfo_initMu);
	run mutexMonitor(reply_Payload_state_atomicMessageInfo_initMu);
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

