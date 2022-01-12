// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/dapr/dapr/blob//pkg/messaging/v1/invoke_method_request_test.go#L18
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestInvokeRequest180 = [1] of {int};
	run TestInvokeRequest18(child_TestInvokeRequest180);
	run receiver(child_TestInvokeRequest180)
stop_process:skip
}

proctype TestInvokeRequest18(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetVer1420 = [1] of {int};
	Mutexdef req_r_state_atomicMessageInfo_initMu;
	run mutexMonitor(req_r_state_atomicMessageInfo_initMu);
	run GetVer142(req_r_state_atomicMessageInfo_initMu,child_GetVer1420);
	child_GetVer1420?0;
	stop_process: skip;
	child!0
}
proctype GetVer142(Mutexdef x_state_atomicMessageInfo_initMu;chan child) {
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

proctype receiver(chan c) {
c?0
}

