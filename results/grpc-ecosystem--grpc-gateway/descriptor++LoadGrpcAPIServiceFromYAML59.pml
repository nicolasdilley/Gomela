// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grpc-ecosystem/grpc-gateway/blob//internal/descriptor/grpc_api_configuration.go#L59
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_LoadGrpcAPIServiceFromYAML590 = [1] of {int};
	run LoadGrpcAPIServiceFromYAML59(child_LoadGrpcAPIServiceFromYAML590);
	run receiver(child_LoadGrpcAPIServiceFromYAML590)
stop_process:skip
}

proctype LoadGrpcAPIServiceFromYAML59(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_registerHTTPRulesFromGrpcAPIService320 = [1] of {int};
	Mutexdef service_Http_state_atomicMessageInfo_initMu;
	Mutexdef service_state_atomicMessageInfo_initMu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(service_state_atomicMessageInfo_initMu);
	run mutexMonitor(service_Http_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run registerHTTPRulesFromGrpcAPIService32(service_Http_state_atomicMessageInfo_initMu,service_state_atomicMessageInfo_initMu,child_registerHTTPRulesFromGrpcAPIService320);
	child_registerHTTPRulesFromGrpcAPIService320?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype registerHTTPRulesFromGrpcAPIService32(Mutexdef service_Http_state_atomicMessageInfo_initMu;Mutexdef service_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_service_Http_GetRules = -2; // opt var_service_Http_GetRules
	

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

