// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//protoutil/txutils_test.go#L321
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCreateSignedEnvelope3210 = [1] of {int};
	run TestCreateSignedEnvelope321(child_TestCreateSignedEnvelope3210);
	run receiver(child_TestCreateSignedEnvelope3210)
stop_process:skip
}

proctype TestCreateSignedEnvelope321(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_CreateSignedEnvelope613 = [1] of {int};
	chan child_CreateSignedEnvelope612 = [1] of {int};
	chan child_SignReturnsOnCall1451 = [1] of {int};
	chan child_SignReturnsOnCall1450 = [1] of {int};
	Mutexdef id_invocationsMutex;
	Mutexdef id_signMutex;
	Mutexdef id_serializeMutex;
	run mutexMonitor(id_serializeMutex);
	run mutexMonitor(id_signMutex);
	run mutexMonitor(id_invocationsMutex);
	run SignReturnsOnCall145(id_invocationsMutex,id_serializeMutex,id_signMutex,child_SignReturnsOnCall1450);
	child_SignReturnsOnCall1450?0;
	run SignReturnsOnCall145(id_invocationsMutex,id_serializeMutex,id_signMutex,child_SignReturnsOnCall1451);
	child_SignReturnsOnCall1451?0;
	run CreateSignedEnvelope61(id_invocationsMutex,id_serializeMutex,id_signMutex,child_CreateSignedEnvelope612);
	child_CreateSignedEnvelope612?0;
	run CreateSignedEnvelope61(id_invocationsMutex,id_serializeMutex,id_signMutex,child_CreateSignedEnvelope613);
	child_CreateSignedEnvelope613?0;
	stop_process: skip;
	child!0
}
proctype SignReturnsOnCall145(Mutexdef fake_invocationsMutex;Mutexdef fake_serializeMutex;Mutexdef fake_signMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	fake_signMutex.Lock!false;
		defer1: skip;
	fake_signMutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype CreateSignedEnvelope61(Mutexdef signer_invocationsMutex;Mutexdef signer_serializeMutex;Mutexdef signer_signMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_CreateSignedEnvelopeWithTLSBinding752 = [1] of {int};
	run CreateSignedEnvelopeWithTLSBinding75(signer_invocationsMutex,signer_serializeMutex,signer_signMutex,child_CreateSignedEnvelopeWithTLSBinding752);
	child_CreateSignedEnvelopeWithTLSBinding752?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype CreateSignedEnvelopeWithTLSBinding75(Mutexdef signer_invocationsMutex;Mutexdef signer_serializeMutex;Mutexdef signer_signMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewSignatureHeader1452 = [1] of {int};
	

	if
	:: true -> 
		run NewSignatureHeader145(signer_invocationsMutex,signer_serializeMutex,signer_signMutex,child_NewSignatureHeader1452);
		child_NewSignatureHeader1452?0;
		

		if
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
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewSignatureHeader145(Mutexdef id_invocationsMutex;Mutexdef id_serializeMutex;Mutexdef id_signMutex;chan child) {
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

proctype receiver(chan c) {
c?0
}

