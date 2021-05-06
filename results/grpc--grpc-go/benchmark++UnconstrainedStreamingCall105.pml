
// https://github.com/grpc/grpc-go/blob/master/benchmark/benchmark.go#L105
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_UnconstrainedStreamingCall1050 = [1] of {int};
	run UnconstrainedStreamingCall105(child_UnconstrainedStreamingCall1050)
stop_process:skip
}

proctype UnconstrainedStreamingCall105(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousUnconstrainedStreamingCall1361062 = [1] of {int};
	chan child_AnonymousUnconstrainedStreamingCall1221061 = [1] of {int};
	chan child_setPayload440 = [1] of {int};
	Mutexdef response_Payload_state_atomicMessageInfo_initMu;
	Mutexdef response_state_atomicMessageInfo_initMu;
	Mutexdef in_ExpectCompressed_state_atomicMessageInfo_initMu;
	Mutexdef in_ResponseStatus_state_atomicMessageInfo_initMu;
	Mutexdef in_ResponseCompressed_state_atomicMessageInfo_initMu;
	Mutexdef in_Payload_state_atomicMessageInfo_initMu;
	Mutexdef in_state_atomicMessageInfo_initMu;
	run mutexMonitor(in_state_atomicMessageInfo_initMu);
	run mutexMonitor(in_Payload_state_atomicMessageInfo_initMu);
	run mutexMonitor(in_ResponseCompressed_state_atomicMessageInfo_initMu);
	run mutexMonitor(in_ResponseStatus_state_atomicMessageInfo_initMu);
	run mutexMonitor(in_ExpectCompressed_state_atomicMessageInfo_initMu);
	

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
	run mutexMonitor(response_state_atomicMessageInfo_initMu);
	run mutexMonitor(response_Payload_state_atomicMessageInfo_initMu);
	run setPayload44(response_Payload_state_atomicMessageInfo_initMu,child_setPayload440);
	child_setPayload440?0;
	run AnonymousUnconstrainedStreamingCall122106(in_state_atomicMessageInfo_initMu,in_Payload_state_atomicMessageInfo_initMu,in_ResponseCompressed_state_atomicMessageInfo_initMu,in_ResponseStatus_state_atomicMessageInfo_initMu,in_ExpectCompressed_state_atomicMessageInfo_initMu,response_state_atomicMessageInfo_initMu,response_Payload_state_atomicMessageInfo_initMu,child_AnonymousUnconstrainedStreamingCall1221061);
	run AnonymousUnconstrainedStreamingCall136106(in_state_atomicMessageInfo_initMu,in_Payload_state_atomicMessageInfo_initMu,in_ResponseCompressed_state_atomicMessageInfo_initMu,in_ResponseStatus_state_atomicMessageInfo_initMu,in_ExpectCompressed_state_atomicMessageInfo_initMu,response_state_atomicMessageInfo_initMu,response_Payload_state_atomicMessageInfo_initMu,child_AnonymousUnconstrainedStreamingCall1361062);
	goto stop_process;
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
proctype AnonymousUnconstrainedStreamingCall122106(Mutexdef in_state_atomicMessageInfo_initMu;Mutexdef in_Payload_state_atomicMessageInfo_initMu;Mutexdef in_ResponseCompressed_state_atomicMessageInfo_initMu;Mutexdef in_ResponseStatus_state_atomicMessageInfo_initMu;Mutexdef in_ExpectCompressed_state_atomicMessageInfo_initMu;Mutexdef response_state_atomicMessageInfo_initMu;Mutexdef response_Payload_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype AnonymousUnconstrainedStreamingCall136106(Mutexdef in_state_atomicMessageInfo_initMu;Mutexdef in_Payload_state_atomicMessageInfo_initMu;Mutexdef in_ResponseCompressed_state_atomicMessageInfo_initMu;Mutexdef in_ResponseStatus_state_atomicMessageInfo_initMu;Mutexdef in_ExpectCompressed_state_atomicMessageInfo_initMu;Mutexdef response_state_atomicMessageInfo_initMu;Mutexdef response_Payload_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

