// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//protoutil/commonutils_test.go#L308
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSignOrPanic3080 = [1] of {int};
	run TestSignOrPanic308(child_TestSignOrPanic3080);
	run receiver(child_TestSignOrPanic3080)
stop_process:skip
}

proctype TestSignOrPanic308(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SignOrPanic1762 = [1] of {int};
	chan child_SignReturnsOnCall1451 = [1] of {int};
	chan child_SignReturnsOnCall1450 = [1] of {int};
	Mutexdef signer_invocationsMutex;
	Mutexdef signer_signMutex;
	Mutexdef signer_serializeMutex;
	run mutexMonitor(signer_serializeMutex);
	run mutexMonitor(signer_signMutex);
	run mutexMonitor(signer_invocationsMutex);
	run SignReturnsOnCall145(signer_invocationsMutex,signer_serializeMutex,signer_signMutex,child_SignReturnsOnCall1450);
	child_SignReturnsOnCall1450?0;
	run SignReturnsOnCall145(signer_invocationsMutex,signer_serializeMutex,signer_signMutex,child_SignReturnsOnCall1451);
	child_SignReturnsOnCall1451?0;
	run SignOrPanic176(signer_invocationsMutex,signer_serializeMutex,signer_signMutex,child_SignOrPanic1762);
	child_SignOrPanic1762?0;
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
proctype SignOrPanic176(Mutexdef signer_invocationsMutex;Mutexdef signer_serializeMutex;Mutexdef signer_signMutex;chan child) {
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

