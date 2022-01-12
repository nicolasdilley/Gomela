// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grpc-ecosystem/grpc-gateway/blob//protoc-gen-openapiv2/internal/genopenapi/template_test.go#L4837
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestParseIncompleteSecurityRequirement48370 = [1] of {int};
	run TestParseIncompleteSecurityRequirement4837(child_TestParseIncompleteSecurityRequirement48370);
	run receiver(child_TestParseIncompleteSecurityRequirement48370)
stop_process:skip
}

proctype TestParseIncompleteSecurityRequirement4837(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef swagger_ExternalDocs_state_atomicMessageInfo_initMu;
	Mutexdef swagger_SecurityDefinitions_state_atomicMessageInfo_initMu;
	Mutexdef swagger_Info_state_atomicMessageInfo_initMu;
	Mutexdef swagger_state_atomicMessageInfo_initMu;
	run mutexMonitor(swagger_state_atomicMessageInfo_initMu);
	run mutexMonitor(swagger_Info_state_atomicMessageInfo_initMu);
	run mutexMonitor(swagger_SecurityDefinitions_state_atomicMessageInfo_initMu);
	run mutexMonitor(swagger_ExternalDocs_state_atomicMessageInfo_initMu);
	

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

