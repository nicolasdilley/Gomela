// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//orderer/common/cluster/replication_test.go#L326
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPullerConfigFromTopLevelConfig3260 = [1] of {int};
	run TestPullerConfigFromTopLevelConfig326(child_TestPullerConfigFromTopLevelConfig3260);
	run receiver(child_TestPullerConfigFromTopLevelConfig3260)
stop_process:skip
}

proctype TestPullerConfigFromTopLevelConfig326(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_PullerConfigFromTopLevelConfig420 = [1] of {int};
	Mutexdef signer_invocationsMutex;
	Mutexdef signer_signMutex;
	Mutexdef signer_serializeMutex;
	run mutexMonitor(signer_serializeMutex);
	run mutexMonitor(signer_signMutex);
	run mutexMonitor(signer_invocationsMutex);
	run PullerConfigFromTopLevelConfig42(signer_invocationsMutex,signer_serializeMutex,signer_signMutex,child_PullerConfigFromTopLevelConfig420);
	child_PullerConfigFromTopLevelConfig420?0;
	stop_process: skip;
	child!0
}
proctype PullerConfigFromTopLevelConfig42(Mutexdef signer_invocationsMutex;Mutexdef signer_serializeMutex;Mutexdef signer_signMutex;chan child) {
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

