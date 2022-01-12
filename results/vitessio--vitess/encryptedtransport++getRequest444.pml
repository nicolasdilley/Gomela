// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/test/endtoend/encryption/encryptedtransport/encrypted_transport_test.go#L444
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_getRequest4440 = [1] of {int};
	run getRequest444(child_getRequest4440);
	run receiver(child_getRequest4440)
stop_process:skip
}

proctype getRequest444(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef session_ReadAfterWrite_state_atomicMessageInfo_initMu;
	Mutexdef session_LockSession_state_atomicMessageInfo_initMu;
	Mutexdef session_Options_state_atomicMessageInfo_initMu;
	Mutexdef session_state_atomicMessageInfo_initMu;
	run mutexMonitor(session_state_atomicMessageInfo_initMu);
	run mutexMonitor(session_Options_state_atomicMessageInfo_initMu);
	run mutexMonitor(session_LockSession_state_atomicMessageInfo_initMu);
	run mutexMonitor(session_ReadAfterWrite_state_atomicMessageInfo_initMu);
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

