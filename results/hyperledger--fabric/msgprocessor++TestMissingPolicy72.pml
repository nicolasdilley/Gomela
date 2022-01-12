// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//orderer/common/msgprocessor/sigfilter_test.go#L72
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestMissingPolicy720 = [1] of {int};
	run TestMissingPolicy72(child_TestMissingPolicy720);
	run receiver(child_TestMissingPolicy720)
stop_process:skip
}

proctype TestMissingPolicy72(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef mockResources_invocationsMutex;
	Mutexdef mockResources_validateNewMutex;
	Mutexdef mockResources_policyManagerMutex;
	Mutexdef mockResources_ordererConfigMutex;
	Mutexdef mockResources_mSPManagerMutex;
	Mutexdef mockResources_consortiumsConfigMutex;
	Mutexdef mockResources_configtxValidatorMutex;
	Mutexdef mockResources_channelConfigMutex;
	Mutexdef mockResources_applicationConfigMutex;
	run mutexMonitor(mockResources_applicationConfigMutex);
	run mutexMonitor(mockResources_channelConfigMutex);
	run mutexMonitor(mockResources_configtxValidatorMutex);
	run mutexMonitor(mockResources_consortiumsConfigMutex);
	run mutexMonitor(mockResources_mSPManagerMutex);
	run mutexMonitor(mockResources_ordererConfigMutex);
	run mutexMonitor(mockResources_policyManagerMutex);
	run mutexMonitor(mockResources_validateNewMutex);
	run mutexMonitor(mockResources_invocationsMutex);
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

