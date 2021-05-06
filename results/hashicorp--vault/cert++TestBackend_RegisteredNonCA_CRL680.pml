
// https://github.com/hashicorp/vault/blob/master/builtin/credential/cert/backend_test.go#L680
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBackend_RegisteredNonCA_CRL6800 = [1] of {int};
	run TestBackend_RegisteredNonCA_CRL680(child_TestBackend_RegisteredNonCA_CRL6800)
stop_process:skip
}

proctype TestBackend_RegisteredNonCA_CRL680(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef crlReq_Auth_Alias_state_atomicMessageInfo_initMu;
	Mutexdef loginReq_Auth_Alias_state_atomicMessageInfo_initMu;
	Mutexdef resp_Auth_Alias_state_atomicMessageInfo_initMu;
	Mutexdef certReq_Auth_Alias_state_atomicMessageInfo_initMu;
	Mutexdef storage_once_m;
	run mutexMonitor(storage_once_m);
	run mutexMonitor(certReq_Auth_Alias_state_atomicMessageInfo_initMu);
	run mutexMonitor(resp_Auth_Alias_state_atomicMessageInfo_initMu);
	run mutexMonitor(loginReq_Auth_Alias_state_atomicMessageInfo_initMu);
	run mutexMonitor(crlReq_Auth_Alias_state_atomicMessageInfo_initMu);
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

