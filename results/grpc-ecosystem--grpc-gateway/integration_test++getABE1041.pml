// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grpc-ecosystem/grpc-gateway/blob//examples/internal/integration/integration_test.go#L1041
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_getABE10410 = [1] of {int};
	run getABE1041(child_getABE10410);
	run receiver(child_getABE10410)
stop_process:skip
}

proctype getABE1041(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef getRestatuspbody_NestedAnnotation_state_atomicMessageInfo_initMu;
	Mutexdef getRestatuspbody_TimestampValue_state_atomicMessageInfo_initMu;
	Mutexdef getRestatuspbody_SingleNested_state_atomicMessageInfo_initMu;
	Mutexdef getRestatuspbody_state_atomicMessageInfo_initMu;
	run mutexMonitor(getRestatuspbody_state_atomicMessageInfo_initMu);
	run mutexMonitor(getRestatuspbody_SingleNested_state_atomicMessageInfo_initMu);
	run mutexMonitor(getRestatuspbody_TimestampValue_state_atomicMessageInfo_initMu);
	run mutexMonitor(getRestatuspbody_NestedAnnotation_state_atomicMessageInfo_initMu);
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
