// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grpc-ecosystem/grpc-gateway/blob//internal/descriptor/openapi_configuration_test.go#L40
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLoadOpenAPIConfigFromYAML400 = [1] of {int};
	run TestLoadOpenAPIConfigFromYAML40(child_TestLoadOpenAPIConfigFromYAML400);
	run receiver(child_TestLoadOpenAPIConfigFromYAML400)
stop_process:skip
}

proctype TestLoadOpenAPIConfigFromYAML40(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef secOpt_Scopes_state_atomicMessageInfo_initMu;
	Mutexdef secOpt_state_atomicMessageInfo_initMu;
	Mutexdef swaggerOpt_ExternalDocs_state_atomicMessageInfo_initMu;
	Mutexdef swaggerOpt_SecurityDefinitions_state_atomicMessageInfo_initMu;
	Mutexdef swaggerOpt_Info_state_atomicMessageInfo_initMu;
	Mutexdef swaggerOpt_state_atomicMessageInfo_initMu;
	Mutexdef fileOpt_Option_state_atomicMessageInfo_initMu;
	Mutexdef fileOpt_state_atomicMessageInfo_initMu;
	Mutexdef opts_state_atomicMessageInfo_initMu;
	Mutexdef config_OpenapiOptions_state_atomicMessageInfo_initMu;
	Mutexdef config_state_atomicMessageInfo_initMu;
	run mutexMonitor(config_state_atomicMessageInfo_initMu);
	run mutexMonitor(config_OpenapiOptions_state_atomicMessageInfo_initMu);
	run mutexMonitor(opts_state_atomicMessageInfo_initMu);
	run mutexMonitor(fileOpt_state_atomicMessageInfo_initMu);
	run mutexMonitor(fileOpt_Option_state_atomicMessageInfo_initMu);
	run mutexMonitor(swaggerOpt_state_atomicMessageInfo_initMu);
	run mutexMonitor(swaggerOpt_Info_state_atomicMessageInfo_initMu);
	run mutexMonitor(swaggerOpt_SecurityDefinitions_state_atomicMessageInfo_initMu);
	run mutexMonitor(swaggerOpt_ExternalDocs_state_atomicMessageInfo_initMu);
	run mutexMonitor(secOpt_state_atomicMessageInfo_initMu);
	run mutexMonitor(secOpt_Scopes_state_atomicMessageInfo_initMu);
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

