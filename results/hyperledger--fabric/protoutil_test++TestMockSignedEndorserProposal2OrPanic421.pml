// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//protoutil/txutils_test.go#L421
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestMockSignedEndorserProposal2OrPanic4210 = [1] of {int};
	run TestMockSignedEndorserProposal2OrPanic421(child_TestMockSignedEndorserProposal2OrPanic4210);
	run receiver(child_TestMockSignedEndorserProposal2OrPanic4210)
stop_process:skip
}

proctype TestMockSignedEndorserProposal2OrPanic421(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_MockSignedEndorserProposal2OrPanic4041 = [1] of {int};
	chan child_SignReturns1350 = [1] of {int};
	Mutexdef signID_invocationsMutex;
	Mutexdef signID_signMutex;
	Mutexdef signID_serializeMutex;
	run mutexMonitor(signID_serializeMutex);
	run mutexMonitor(signID_signMutex);
	run mutexMonitor(signID_invocationsMutex);
	run SignReturns135(signID_invocationsMutex,signID_serializeMutex,signID_signMutex,child_SignReturns1350);
	child_SignReturns1350?0;
	run MockSignedEndorserProposal2OrPanic404(signID_invocationsMutex,signID_serializeMutex,signID_signMutex,child_MockSignedEndorserProposal2OrPanic4041);
	child_MockSignedEndorserProposal2OrPanic4041?0;
	stop_process: skip;
	child!0
}
proctype SignReturns135(Mutexdef fake_invocationsMutex;Mutexdef fake_serializeMutex;Mutexdef fake_signMutex;chan child) {
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
proctype MockSignedEndorserProposal2OrPanic404(Mutexdef signer_invocationsMutex;Mutexdef signer_serializeMutex;Mutexdef signer_signMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetSignedProposal3601 = [1] of {int};
	run GetSignedProposal360(signer_invocationsMutex,signer_serializeMutex,signer_signMutex,child_GetSignedProposal3601);
	child_GetSignedProposal3601?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetSignedProposal360(Mutexdef signer_invocationsMutex;Mutexdef signer_serializeMutex;Mutexdef signer_signMutex;chan child) {
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

