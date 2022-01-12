// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grpc-ecosystem/grpc-gateway/blob//runtime/marshal_json_test.go#L20
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestJSONBuiltinMarshal200 = [1] of {int};
	run TestJSONBuiltinMarshal20(child_TestJSONBuiltinMarshal200);
	run receiver(child_TestJSONBuiltinMarshal200)
stop_process:skip
}

proctype TestJSONBuiltinMarshal20(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef got_state_atomicMessageInfo_initMu;
	chan child_Marshal230 = [1] of {int};
	Mutexdef msg_state_atomicMessageInfo_initMu;
	run mutexMonitor(msg_state_atomicMessageInfo_initMu);
	run Marshal23(msg_state_atomicMessageInfo_initMu,child_Marshal230);
	child_Marshal230?0;
	run mutexMonitor(got_state_atomicMessageInfo_initMu);
	stop_process: skip;
	child!0
}
proctype Marshal23(Mutexdef v_state_atomicMessageInfo_initMu;chan child) {
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

proctype receiver(chan c) {
c?0
}

