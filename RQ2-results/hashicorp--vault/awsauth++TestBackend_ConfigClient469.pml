
// https://github.com/hashicorp/vault/blob/master/builtin/credential/aws/backend_test.go#L469
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBackend_ConfigClient4690 = [1] of {int};
	run TestBackend_ConfigClient469(child_TestBackend_ConfigClient4690)
stop_process:skip
}

proctype TestBackend_ConfigClient469(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef resp_Auth_Alias_state_atomicMessageInfo_initMu;
	Mutexdef endpointReq_Auth_Alias_state_atomicMessageInfo_initMu;
	Mutexdef configClientCreateRequest_Auth_Alias_state_atomicMessageInfo_initMu;
	Mutexdef b_deprecatedTerms_once_m;
	Mutexdef b_denyListMutex;
	Mutexdef b_roleMutex;
	Mutexdef b_configMutex;
	Mutexdef storage_once_m;
	run mutexMonitor(storage_once_m);
	run mutexMonitor(b_configMutex);
	run mutexMonitor(b_roleMutex);
	run mutexMonitor(b_denyListMutex);
	run mutexMonitor(b_deprecatedTerms_once_m);
	run mutexMonitor(configClientCreateRequest_Auth_Alias_state_atomicMessageInfo_initMu);
	run mutexMonitor(endpointReq_Auth_Alias_state_atomicMessageInfo_initMu);
	run mutexMonitor(resp_Auth_Alias_state_atomicMessageInfo_initMu);
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

