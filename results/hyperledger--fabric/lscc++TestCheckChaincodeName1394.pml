// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//core/scc/lscc/lscc_test.go#L1394
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCheckChaincodeName13940 = [1] of {int};
	run TestCheckChaincodeName1394(child_TestCheckChaincodeName13940);
	run receiver(child_TestCheckChaincodeName13940)
stop_process:skip
}

proctype TestCheckChaincodeName1394(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_isValidChaincodeName63711 = [1] of {int};
	chan child_isValidChaincodeName63710 = [1] of {int};
	chan child_isValidChaincodeName6379 = [1] of {int};
	chan child_isValidChaincodeName6378 = [1] of {int};
	chan child_isValidChaincodeName6377 = [1] of {int};
	chan child_isValidChaincodeName6376 = [1] of {int};
	chan child_isValidChaincodeName6375 = [1] of {int};
	chan child_isValidChaincodeName6374 = [1] of {int};
	chan child_isValidChaincodeName6373 = [1] of {int};
	chan child_isValidChaincodeName6372 = [1] of {int};
	chan child_isValidChaincodeName6371 = [1] of {int};
	chan child_isValidChaincodeName6370 = [1] of {int};
	Mutexdef lscc_PackageCache_Mutex;
	Mutexdef lscc_BuildRegistry_mutex;
	run mutexMonitor(lscc_BuildRegistry_mutex);
	run mutexMonitor(lscc_PackageCache_Mutex);
	run isValidChaincodeName637(lscc_BuildRegistry_mutex,lscc_PackageCache_Mutex,child_isValidChaincodeName6370);
	child_isValidChaincodeName6370?0;
	run isValidChaincodeName637(lscc_BuildRegistry_mutex,lscc_PackageCache_Mutex,child_isValidChaincodeName6371);
	child_isValidChaincodeName6371?0;
	run isValidChaincodeName637(lscc_BuildRegistry_mutex,lscc_PackageCache_Mutex,child_isValidChaincodeName6372);
	child_isValidChaincodeName6372?0;
	run isValidChaincodeName637(lscc_BuildRegistry_mutex,lscc_PackageCache_Mutex,child_isValidChaincodeName6373);
	child_isValidChaincodeName6373?0;
	run isValidChaincodeName637(lscc_BuildRegistry_mutex,lscc_PackageCache_Mutex,child_isValidChaincodeName6374);
	child_isValidChaincodeName6374?0;
	run isValidChaincodeName637(lscc_BuildRegistry_mutex,lscc_PackageCache_Mutex,child_isValidChaincodeName6375);
	child_isValidChaincodeName6375?0;
	run isValidChaincodeName637(lscc_BuildRegistry_mutex,lscc_PackageCache_Mutex,child_isValidChaincodeName6376);
	child_isValidChaincodeName6376?0;
	run isValidChaincodeName637(lscc_BuildRegistry_mutex,lscc_PackageCache_Mutex,child_isValidChaincodeName6377);
	child_isValidChaincodeName6377?0;
	run isValidChaincodeName637(lscc_BuildRegistry_mutex,lscc_PackageCache_Mutex,child_isValidChaincodeName6378);
	child_isValidChaincodeName6378?0;
	run isValidChaincodeName637(lscc_BuildRegistry_mutex,lscc_PackageCache_Mutex,child_isValidChaincodeName6379);
	child_isValidChaincodeName6379?0;
	run isValidChaincodeName637(lscc_BuildRegistry_mutex,lscc_PackageCache_Mutex,child_isValidChaincodeName63710);
	child_isValidChaincodeName63710?0;
	run isValidChaincodeName637(lscc_BuildRegistry_mutex,lscc_PackageCache_Mutex,child_isValidChaincodeName63711);
	child_isValidChaincodeName63711?0;
	stop_process: skip;
	child!0
}
proctype isValidChaincodeName637(Mutexdef lscc_BuildRegistry_mutex;Mutexdef lscc_PackageCache_Mutex;chan child) {
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

