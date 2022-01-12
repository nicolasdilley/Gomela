// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob//pkg/test/util/structpath/instance_test.go#L25
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContainSubstring250 = [1] of {int};
	run TestContainSubstring25(child_TestContainSubstring250);
	run receiver(child_TestContainSubstring250)
stop_process:skip
}

proctype TestContainSubstring25(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ForProto530 = [1] of {int};
	Mutexdef testResponse_ControlPlane_state_atomicMessageInfo_initMu;
	Mutexdef testResponse_state_atomicMessageInfo_initMu;
	int var_tt_substrs = -2; // opt var_tt_substrs
	int var_tests = -2; // opt var_tests
	run mutexMonitor(testResponse_state_atomicMessageInfo_initMu);
	run mutexMonitor(testResponse_ControlPlane_state_atomicMessageInfo_initMu);
	run ForProto53(testResponse_ControlPlane_state_atomicMessageInfo_initMu,testResponse_state_atomicMessageInfo_initMu,child_ForProto530);
	child_ForProto530?0;
	stop_process: skip;
	child!0
}
proctype ForProto53(Mutexdef proto_ControlPlane_state_atomicMessageInfo_initMu;Mutexdef proto_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_protoToParsedJSON780 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run protoToParsedJSON78(proto_ControlPlane_state_atomicMessageInfo_initMu,proto_state_atomicMessageInfo_initMu,child_protoToParsedJSON780);
	child_protoToParsedJSON780?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype protoToParsedJSON78(Mutexdef message_ControlPlane_state_atomicMessageInfo_initMu;Mutexdef message_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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

