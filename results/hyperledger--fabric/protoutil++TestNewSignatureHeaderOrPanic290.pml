// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//protoutil/commonutils_test.go#L290
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNewSignatureHeaderOrPanic2900 = [1] of {int};
	run TestNewSignatureHeaderOrPanic290(child_TestNewSignatureHeaderOrPanic2900);
	run receiver(child_TestNewSignatureHeaderOrPanic2900)
stop_process:skip
}

proctype TestNewSignatureHeaderOrPanic290(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewSignatureHeaderOrPanic1622 = [1] of {int};
	chan child_SerializeReturnsOnCall771 = [1] of {int};
	chan child_SerializeReturnsOnCall770 = [1] of {int};
	Mutexdef id_invocationsMutex;
	Mutexdef id_signMutex;
	Mutexdef id_serializeMutex;
	run mutexMonitor(id_serializeMutex);
	run mutexMonitor(id_signMutex);
	run mutexMonitor(id_invocationsMutex);
	run SerializeReturnsOnCall77(id_invocationsMutex,id_serializeMutex,id_signMutex,child_SerializeReturnsOnCall770);
	child_SerializeReturnsOnCall770?0;
	run SerializeReturnsOnCall77(id_invocationsMutex,id_serializeMutex,id_signMutex,child_SerializeReturnsOnCall771);
	child_SerializeReturnsOnCall771?0;
	run NewSignatureHeaderOrPanic162(id_invocationsMutex,id_serializeMutex,id_signMutex,child_NewSignatureHeaderOrPanic1622);
	child_NewSignatureHeaderOrPanic1622?0;
	stop_process: skip;
	child!0
}
proctype SerializeReturnsOnCall77(Mutexdef fake_invocationsMutex;Mutexdef fake_serializeMutex;Mutexdef fake_signMutex;chan child) {
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
proctype NewSignatureHeaderOrPanic162(Mutexdef id_invocationsMutex;Mutexdef id_serializeMutex;Mutexdef id_signMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewSignatureHeader1452 = [1] of {int};
	run NewSignatureHeader145(id_invocationsMutex,id_serializeMutex,id_signMutex,child_NewSignatureHeader1452);
	child_NewSignatureHeader1452?0;
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

