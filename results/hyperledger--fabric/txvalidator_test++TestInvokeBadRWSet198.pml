// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//core/committer/txvalidator/v20/validator_test.go#L198
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestInvokeBadRWSet1980 = [1] of {int};
	run TestInvokeBadRWSet198(child_TestInvokeBadRWSet1980);
	run receiver(child_TestInvokeBadRWSet1980)
stop_process:skip
}

proctype TestInvokeBadRWSet198(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef __invocationsMutex;
	Mutexdef __verifyMutex;
	Mutexdef __validateMutex;
	Mutexdef __serializeMutex;
	Mutexdef __satisfiesPrincipalMutex;
	Mutexdef __getOrganizationalUnitsMutex;
	Mutexdef __getMSPIdentifierMutex;
	Mutexdef __getIdentifierMutex;
	Mutexdef __expiresAtMutex;
	Mutexdef __anonymousMutex;
	run mutexMonitor(__anonymousMutex);
	run mutexMonitor(__expiresAtMutex);
	run mutexMonitor(__getIdentifierMutex);
	run mutexMonitor(__getMSPIdentifierMutex);
	run mutexMonitor(__getOrganizationalUnitsMutex);
	run mutexMonitor(__satisfiesPrincipalMutex);
	run mutexMonitor(__serializeMutex);
	run mutexMonitor(__validateMutex);
	run mutexMonitor(__verifyMutex);
	run mutexMonitor(__invocationsMutex);
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

