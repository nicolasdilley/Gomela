#define not_found_885  -2

// https://github.com/hashicorp/vault/blob/master/builtin/logical/pki/cert_util_test.go#L130
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPki_MultipleOUs1300 = [1] of {int};
	run TestPki_MultipleOUs130(child_TestPki_MultipleOUs1300)
stop_process:skip
}

proctype TestPki_MultipleOUs130(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_generateCreationBundle7490 = [1] of {int};
	Mutexdef input_req_Auth_Alias_state_atomicMessageInfo_initMu;
	Mutexdef b_revokeStorageLock;
	run mutexMonitor(b_revokeStorageLock);
	run mutexMonitor(input_req_Auth_Alias_state_atomicMessageInfo_initMu);
	run generateCreationBundle749(input_req_Auth_Alias_state_atomicMessageInfo_initMu,child_generateCreationBundle7490);
	child_generateCreationBundle7490?0;
	stop_process: skip;
	child!0
}
proctype generateCreationBundle749(Mutexdef data_req_Auth_Alias_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_validateOtherSANs3690 = [1] of {int};
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run validateOtherSANs369(data_req_Auth_Alias_state_atomicMessageInfo_initMu,not_found_885,child_validateOtherSANs3690);
		child_validateOtherSANs3690?0;
		

		if
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true;
		:: true;
		:: true;
		fi
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype validateOtherSANs369(Mutexdef data_req_Auth_Alias_state_atomicMessageInfo_initMu;int requested;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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

