// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//protoutil/txutils_test.go#L260
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCreateSignedTxStatus2600 = [1] of {int};
	run TestCreateSignedTxStatus260(child_TestCreateSignedTxStatus2600);
	run receiver(child_TestCreateSignedTxStatus2600)
stop_process:skip
}

proctype TestCreateSignedTxStatus260(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Serialize381 = [1] of {int};
	chan child_SerializeReturns670 = [1] of {int};
	Mutexdef signingID_invocationsMutex;
	Mutexdef signingID_signMutex;
	Mutexdef signingID_serializeMutex;
	int var_tests = -2; // opt var_tests
	run mutexMonitor(signingID_serializeMutex);
	run mutexMonitor(signingID_signMutex);
	run mutexMonitor(signingID_invocationsMutex);
	run SerializeReturns67(signingID_invocationsMutex,signingID_serializeMutex,signingID_signMutex,child_SerializeReturns670);
	child_SerializeReturns670?0;
	run Serialize38(signingID_invocationsMutex,signingID_serializeMutex,signingID_signMutex,child_Serialize381);
	child_Serialize381?0;
	stop_process: skip;
	child!0
}
proctype SerializeReturns67(Mutexdef fake_invocationsMutex;Mutexdef fake_serializeMutex;Mutexdef fake_signMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	fake_serializeMutex.Lock!false;
		defer1: skip;
	fake_serializeMutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Serialize38(Mutexdef fake_invocationsMutex;Mutexdef fake_serializeMutex;Mutexdef fake_signMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_recordInvocation1751 = [1] of {int};
	fake_serializeMutex.Lock!false;
	run recordInvocation175(fake_invocationsMutex,fake_serializeMutex,fake_signMutex,child_recordInvocation1751);
	child_recordInvocation1751?0;
	fake_serializeMutex.Unlock!false;
	

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
proctype recordInvocation175(Mutexdef fake_invocationsMutex;Mutexdef fake_serializeMutex;Mutexdef fake_signMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	fake_invocationsMutex.Lock!false;
		defer1: skip;
	fake_invocationsMutex.Unlock!false;
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

