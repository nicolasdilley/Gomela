// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grpc-ecosystem/grpc-gateway/blob//protoc-gen-grpc-gateway/internal/gengateway/template_test.go#L263
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestApplyTemplateRequestWithClientStreaming2630 = [1] of {int};
	run TestApplyTemplateRequestWithClientStreaming263(child_TestApplyTemplateRequestWithClientStreaming2630);
	run receiver(child_TestApplyTemplateRequestWithClientStreaming2630)
stop_process:skip
}

proctype TestApplyTemplateRequestWithClientStreaming263(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef svc_Options_state_atomicMessageInfo_initMu;
	Mutexdef svc_state_atomicMessageInfo_initMu;
	Mutexdef meth_Options_state_atomicMessageInfo_initMu;
	Mutexdef meth_state_atomicMessageInfo_initMu;
	Mutexdef nesteddesc_Options_state_atomicMessageInfo_initMu;
	Mutexdef nesteddesc_state_atomicMessageInfo_initMu;
	Mutexdef msgdesc_Options_state_atomicMessageInfo_initMu;
	Mutexdef msgdesc_state_atomicMessageInfo_initMu;
	run mutexMonitor(msgdesc_state_atomicMessageInfo_initMu);
	run mutexMonitor(msgdesc_Options_state_atomicMessageInfo_initMu);
	run mutexMonitor(nesteddesc_state_atomicMessageInfo_initMu);
	run mutexMonitor(nesteddesc_Options_state_atomicMessageInfo_initMu);
	run mutexMonitor(meth_state_atomicMessageInfo_initMu);
	run mutexMonitor(meth_Options_state_atomicMessageInfo_initMu);
	run mutexMonitor(svc_state_atomicMessageInfo_initMu);
	run mutexMonitor(svc_Options_state_atomicMessageInfo_initMu);
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

proctype receiver(chan c) {
c?0
}

