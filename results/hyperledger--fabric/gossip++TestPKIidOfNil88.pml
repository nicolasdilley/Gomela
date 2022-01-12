// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//internal/peer/gossip/mcs_test.go#L88
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPKIidOfNil880 = [1] of {int};
	run TestPKIidOfNil88(child_TestPKIidOfNil880);
	run receiver(child_TestPKIidOfNil880)
stop_process:skip
}

proctype TestPKIidOfNil88(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewMCS560 = [1] of {int};
	Mutexdef signer_invocationsMutex;
	Mutexdef signer_signMutex;
	Mutexdef signer_serializeMutex;
	run mutexMonitor(signer_serializeMutex);
	run mutexMonitor(signer_signMutex);
	run mutexMonitor(signer_invocationsMutex);
	run NewMCS56(signer_invocationsMutex,signer_serializeMutex,signer_signMutex,child_NewMCS560);
	child_NewMCS560?0;
	stop_process: skip;
	child!0
}
proctype NewMCS56(Mutexdef localSigner_invocationsMutex;Mutexdef localSigner_serializeMutex;Mutexdef localSigner_signMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

