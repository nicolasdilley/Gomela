// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grpc/grpc-go/blob//encoding/proto/proto_test.go#L95
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestStaggeredMarshalAndUnmarshalUsingSamePool950 = [1] of {int};
	run TestStaggeredMarshalAndUnmarshalUsingSamePool95(child_TestStaggeredMarshalAndUnmarshalUsingSamePool950);
	run receiver(child_TestStaggeredMarshalAndUnmarshalUsingSamePool950)
stop_process:skip
}

proctype TestStaggeredMarshalAndUnmarshalUsingSamePool95(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetBody871 = [1] of {int};
	chan child_GetBody870 = [1] of {int};
	Mutexdef proto2_state_atomicMessageInfo_initMu;
	Mutexdef proto1_state_atomicMessageInfo_initMu;
	int var_b2 = -2; // opt var_b2
	int var_b1 = -2; // opt var_b1
	run mutexMonitor(proto1_state_atomicMessageInfo_initMu);
	run mutexMonitor(proto2_state_atomicMessageInfo_initMu);
	run GetBody87(proto1_state_atomicMessageInfo_initMu,child_GetBody870);
	child_GetBody870?0;
	run GetBody87(proto2_state_atomicMessageInfo_initMu,child_GetBody871);
	child_GetBody871?0;
	stop_process: skip;
	child!0
}
proctype GetBody87(Mutexdef x_state_atomicMessageInfo_initMu;chan child) {
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

