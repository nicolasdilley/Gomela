// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grpc-ecosystem/grpc-gateway/blob//protoc-gen-openapiv2/internal/genopenapi/template_test.go#L2915
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_generateMsgsForJSONReservedName29150 = [1] of {int};
	run generateMsgsForJSONReservedName2915(child_generateMsgsForJSONReservedName29150);
	run receiver(child_generateMsgsForJSONReservedName29150)
stop_process:skip
}

proctype generateMsgsForJSONReservedName2915(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef pfd2_Options_state_atomicMessageInfo_initMu;
	Mutexdef pfd2_state_atomicMessageInfo_initMu;
	Mutexdef pfd_Options_state_atomicMessageInfo_initMu;
	Mutexdef pfd_state_atomicMessageInfo_initMu;
	run mutexMonitor(pfd_state_atomicMessageInfo_initMu);
	run mutexMonitor(pfd_Options_state_atomicMessageInfo_initMu);
	run mutexMonitor(pfd2_state_atomicMessageInfo_initMu);
	run mutexMonitor(pfd2_Options_state_atomicMessageInfo_initMu);
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

