
// https://github.com/hashicorp/vault/blob/master/builtin/logical/transit/backend_test.go#L982
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_testConvergentEncryptionCommon9820 = [1] of {int};
	run testConvergentEncryptionCommon982(child_testConvergentEncryptionCommon9820)
stop_process:skip
}

proctype testConvergentEncryptionCommon982(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef curr_versionPrefixCache_mu;
	Mutexdef curr_l;
	Mutexdef p_versionPrefixCache_mu;
	Mutexdef p_l;
	Mutexdef resp_Auth_Alias_state_atomicMessageInfo_initMu;
	Mutexdef req_Auth_Alias_state_atomicMessageInfo_initMu;
	run mutexMonitor(req_Auth_Alias_state_atomicMessageInfo_initMu);
	run mutexMonitor(resp_Auth_Alias_state_atomicMessageInfo_initMu);
	run mutexMonitor(p_l);
	run mutexMonitor(p_versionPrefixCache_mu);
	

	if
	:: true -> 
		run mutexMonitor(curr_l);
		run mutexMonitor(curr_versionPrefixCache_mu)
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

