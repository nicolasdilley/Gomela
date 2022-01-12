// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grpc-ecosystem/grpc-gateway/blob//examples/internal/integration/integration_test.go#L403
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_testABECreate4030 = [1] of {int};
	run testABECreate403(child_testABECreate4030);
	run receiver(child_testABECreate4030)
stop_process:skip
}

proctype testABECreate403(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef msg_NestedAnnotation_state_atomicMessageInfo_initMu;
	Mutexdef msg_TimestampValue_state_atomicMessageInfo_initMu;
	Mutexdef msg_SingleNested_state_atomicMessageInfo_initMu;
	Mutexdef msg_state_atomicMessageInfo_initMu;
	Mutexdef want_NestedAnnotation_state_atomicMessageInfo_initMu;
	Mutexdef want_TimestampValue_state_atomicMessageInfo_initMu;
	Mutexdef want_SingleNested_state_atomicMessageInfo_initMu;
	Mutexdef want_state_atomicMessageInfo_initMu;
	run mutexMonitor(want_state_atomicMessageInfo_initMu);
	run mutexMonitor(want_SingleNested_state_atomicMessageInfo_initMu);
	run mutexMonitor(want_TimestampValue_state_atomicMessageInfo_initMu);
	run mutexMonitor(want_NestedAnnotation_state_atomicMessageInfo_initMu);
	

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
	run mutexMonitor(msg_state_atomicMessageInfo_initMu);
	run mutexMonitor(msg_SingleNested_state_atomicMessageInfo_initMu);
	run mutexMonitor(msg_TimestampValue_state_atomicMessageInfo_initMu);
	run mutexMonitor(msg_NestedAnnotation_state_atomicMessageInfo_initMu);
	

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

