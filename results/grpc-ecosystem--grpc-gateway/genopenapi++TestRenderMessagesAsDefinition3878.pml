// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grpc-ecosystem/grpc-gateway/blob//protoc-gen-openapiv2/internal/genopenapi/template_test.go#L3878
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRenderMessagesAsDefinition38780 = [1] of {int};
	run TestRenderMessagesAsDefinition3878(child_TestRenderMessagesAsDefinition38780);
	run receiver(child_TestRenderMessagesAsDefinition38780)
stop_process:skip
}

proctype TestRenderMessagesAsDefinition3878(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef fieldBehaviorOutputOnlyOptions_state_atomicMessageInfo_initMu;
	Mutexdef requiredFieldOptions_state_atomicMessageInfo_initMu;
	Mutexdef requiredField_state_atomicMessageInfo_initMu;
	Mutexdef jsonSchema_state_atomicMessageInfo_initMu;
	int var_test_msgDescs = -2; // opt var_test_msgDescs
	int var_tests = -2; // opt var_tests
	run mutexMonitor(jsonSchema_state_atomicMessageInfo_initMu);
	run mutexMonitor(requiredField_state_atomicMessageInfo_initMu);
	run mutexMonitor(requiredFieldOptions_state_atomicMessageInfo_initMu);
	run mutexMonitor(fieldBehaviorOutputOnlyOptions_state_atomicMessageInfo_initMu);
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

