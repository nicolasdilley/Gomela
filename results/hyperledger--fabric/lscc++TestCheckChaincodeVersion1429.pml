// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//core/scc/lscc/lscc_test.go#L1429
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCheckChaincodeVersion14290 = [1] of {int};
	run TestCheckChaincodeVersion1429(child_TestCheckChaincodeVersion14290);
	run receiver(child_TestCheckChaincodeVersion14290)
stop_process:skip
}

proctype TestCheckChaincodeVersion1429(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_isValidChaincodeVersion6489 = [1] of {int};
	chan child_isValidChaincodeVersion6488 = [1] of {int};
	chan child_isValidChaincodeVersion6487 = [1] of {int};
	chan child_isValidChaincodeVersion6486 = [1] of {int};
	chan child_isValidChaincodeVersion6485 = [1] of {int};
	chan child_isValidChaincodeVersion6484 = [1] of {int};
	chan child_isValidChaincodeVersion6483 = [1] of {int};
	chan child_isValidChaincodeVersion6482 = [1] of {int};
	chan child_isValidChaincodeVersion6481 = [1] of {int};
	chan child_isValidChaincodeVersion6480 = [1] of {int};
	Mutexdef lscc_PackageCache_Mutex;
	Mutexdef lscc_BuildRegistry_mutex;
	run mutexMonitor(lscc_BuildRegistry_mutex);
	run mutexMonitor(lscc_PackageCache_Mutex);
	run isValidChaincodeVersion648(lscc_BuildRegistry_mutex,lscc_PackageCache_Mutex,child_isValidChaincodeVersion6480);
	child_isValidChaincodeVersion6480?0;
	run isValidChaincodeVersion648(lscc_BuildRegistry_mutex,lscc_PackageCache_Mutex,child_isValidChaincodeVersion6481);
	child_isValidChaincodeVersion6481?0;
	run isValidChaincodeVersion648(lscc_BuildRegistry_mutex,lscc_PackageCache_Mutex,child_isValidChaincodeVersion6482);
	child_isValidChaincodeVersion6482?0;
	run isValidChaincodeVersion648(lscc_BuildRegistry_mutex,lscc_PackageCache_Mutex,child_isValidChaincodeVersion6483);
	child_isValidChaincodeVersion6483?0;
	run isValidChaincodeVersion648(lscc_BuildRegistry_mutex,lscc_PackageCache_Mutex,child_isValidChaincodeVersion6484);
	child_isValidChaincodeVersion6484?0;
	run isValidChaincodeVersion648(lscc_BuildRegistry_mutex,lscc_PackageCache_Mutex,child_isValidChaincodeVersion6485);
	child_isValidChaincodeVersion6485?0;
	run isValidChaincodeVersion648(lscc_BuildRegistry_mutex,lscc_PackageCache_Mutex,child_isValidChaincodeVersion6486);
	child_isValidChaincodeVersion6486?0;
	run isValidChaincodeVersion648(lscc_BuildRegistry_mutex,lscc_PackageCache_Mutex,child_isValidChaincodeVersion6487);
	child_isValidChaincodeVersion6487?0;
	run isValidChaincodeVersion648(lscc_BuildRegistry_mutex,lscc_PackageCache_Mutex,child_isValidChaincodeVersion6488);
	child_isValidChaincodeVersion6488?0;
	run isValidChaincodeVersion648(lscc_BuildRegistry_mutex,lscc_PackageCache_Mutex,child_isValidChaincodeVersion6489);
	child_isValidChaincodeVersion6489?0;
	stop_process: skip;
	child!0
}
proctype isValidChaincodeVersion648(Mutexdef lscc_BuildRegistry_mutex;Mutexdef lscc_PackageCache_Mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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

