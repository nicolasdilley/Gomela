// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grpc-ecosystem/grpc-gateway/blob//internal/descriptor/grpc_api_configuration_test.go#L8
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLoadGrpcAPIServiceFromYAMLInvalidType80 = [1] of {int};
	run TestLoadGrpcAPIServiceFromYAMLInvalidType8(child_TestLoadGrpcAPIServiceFromYAMLInvalidType80);
	run receiver(child_TestLoadGrpcAPIServiceFromYAMLInvalidType80)
stop_process:skip
}

proctype TestLoadGrpcAPIServiceFromYAMLInvalidType8(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef service_Http_state_atomicMessageInfo_initMu;
	Mutexdef service_state_atomicMessageInfo_initMu;
	run mutexMonitor(service_state_atomicMessageInfo_initMu);
	run mutexMonitor(service_Http_state_atomicMessageInfo_initMu);
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
