
// https://github.com/hashicorp/vault/blob/master/vault/seal.go#L473
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_readStoredKeys4730 = [1] of {int};
	run readStoredKeys473(child_readStoredKeys4730)
stop_process:skip
}

proctype readStoredKeys473(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Decrypt220 = [1] of {int};
	Mutexdef blobInfo_KeyInfo_state_atomicMessageInfo_initMu;
	Mutexdef blobInfo_state_atomicMessageInfo_initMu;
	

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
	run mutexMonitor(blobInfo_state_atomicMessageInfo_initMu);
	run mutexMonitor(blobInfo_KeyInfo_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Decrypt22(blobInfo_state_atomicMessageInfo_initMu,blobInfo_KeyInfo_state_atomicMessageInfo_initMu,child_Decrypt220);
	child_Decrypt220?0;
	

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
proctype Decrypt22(Mutexdef key_state_atomicMessageInfo_initMu;Mutexdef key_KeyInfo_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Decrypt220 = [1] of {int};
	run Decrypt22(key_state_atomicMessageInfo_initMu,key_KeyInfo_state_atomicMessageInfo_initMu,child_Decrypt220);
	child_Decrypt220?0;
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

