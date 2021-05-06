
// https://github.com/dapr/dapr/blob/master/pkg/messaging/v1/invoke_method_request_test.go#L25
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFromInvokeRequestMessage250 = [1] of {int};
	run TestFromInvokeRequestMessage25(child_TestFromInvokeRequestMessage250)
stop_process:skip
}

proctype TestFromInvokeRequestMessage25(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_FromInvokeRequestMessage420 = [1] of {int};
	Mutexdef req_r_Actor_state_atomicMessageInfo_initMu;
	Mutexdef req_r_Message_HttpExtension_state_atomicMessageInfo_initMu;
	Mutexdef req_r_Message_Data_state_atomicMessageInfo_initMu;
	Mutexdef req_r_Message_state_atomicMessageInfo_initMu;
	Mutexdef req_r_state_atomicMessageInfo_initMu;
	Mutexdef pb_HttpExtension_state_atomicMessageInfo_initMu;
	Mutexdef pb_Data_state_atomicMessageInfo_initMu;
	Mutexdef pb_state_atomicMessageInfo_initMu;
	run mutexMonitor(pb_state_atomicMessageInfo_initMu);
	run mutexMonitor(pb_Data_state_atomicMessageInfo_initMu);
	run mutexMonitor(pb_HttpExtension_state_atomicMessageInfo_initMu);
	run mutexMonitor(req_r_state_atomicMessageInfo_initMu);
	run mutexMonitor(req_r_Message_state_atomicMessageInfo_initMu);
	run mutexMonitor(req_r_Message_Data_state_atomicMessageInfo_initMu);
	run mutexMonitor(req_r_Message_HttpExtension_state_atomicMessageInfo_initMu);
	run mutexMonitor(req_r_Actor_state_atomicMessageInfo_initMu);
	run FromInvokeRequestMessage42(pb_state_atomicMessageInfo_initMu,pb_Data_state_atomicMessageInfo_initMu,pb_HttpExtension_state_atomicMessageInfo_initMu,child_FromInvokeRequestMessage420);
	child_FromInvokeRequestMessage420?0;
	stop_process: skip;
	child!0
}
proctype FromInvokeRequestMessage42(Mutexdef pb_state_atomicMessageInfo_initMu;Mutexdef pb_Data_state_atomicMessageInfo_initMu;Mutexdef pb_HttpExtension_state_atomicMessageInfo_initMu;chan child) {
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

