// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grpc-ecosystem/grpc-gateway/blob//protoc-gen-grpc-gateway/internal/gengateway/template_test.go#L673
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestIdentifierCapitalization6730 = [1] of {int};
	run TestIdentifierCapitalization673(child_TestIdentifierCapitalization6730);
	run receiver(child_TestIdentifierCapitalization6730)
stop_process:skip
}

proctype TestIdentifierCapitalization673(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef svc_Options_state_atomicMessageInfo_initMu;
	Mutexdef svc_state_atomicMessageInfo_initMu;
	Mutexdef meth2_Options_state_atomicMessageInfo_initMu;
	Mutexdef meth2_state_atomicMessageInfo_initMu;
	Mutexdef meth1_Options_state_atomicMessageInfo_initMu;
	Mutexdef meth1_state_atomicMessageInfo_initMu;
	Mutexdef msgdesc2_Options_state_atomicMessageInfo_initMu;
	Mutexdef msgdesc2_state_atomicMessageInfo_initMu;
	Mutexdef msgdesc1_Options_state_atomicMessageInfo_initMu;
	Mutexdef msgdesc1_state_atomicMessageInfo_initMu;
	run mutexMonitor(msgdesc1_state_atomicMessageInfo_initMu);
	run mutexMonitor(msgdesc1_Options_state_atomicMessageInfo_initMu);
	run mutexMonitor(msgdesc2_state_atomicMessageInfo_initMu);
	run mutexMonitor(msgdesc2_Options_state_atomicMessageInfo_initMu);
	run mutexMonitor(meth1_state_atomicMessageInfo_initMu);
	run mutexMonitor(meth1_Options_state_atomicMessageInfo_initMu);
	run mutexMonitor(meth2_state_atomicMessageInfo_initMu);
	run mutexMonitor(meth2_Options_state_atomicMessageInfo_initMu);
	run mutexMonitor(svc_state_atomicMessageInfo_initMu);
	run mutexMonitor(svc_Options_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		goto stop_process
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

proctype receiver(chan c) {
c?0
}

