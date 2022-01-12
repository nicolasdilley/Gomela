// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//core/ledger/confighistory/confighistorytest/confighistory.go#L21
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewMgr210 = [1] of {int};
	run NewMgr21(child_NewMgr210);
	run receiver(child_NewMgr210)
stop_process:skip
}

proctype NewMgr21(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewMgr430 = [1] of {int};
	Mutexdef mockCCInfoProvider_invocationsMutex;
	Mutexdef mockCCInfoProvider_updatedChaincodesMutex;
	Mutexdef mockCCInfoProvider_namespacesMutex;
	Mutexdef mockCCInfoProvider_implicitCollectionsMutex;
	Mutexdef mockCCInfoProvider_generateImplicitCollectionForOrgMutex;
	Mutexdef mockCCInfoProvider_collectionInfoMutex;
	Mutexdef mockCCInfoProvider_chaincodeInfoMutex;
	Mutexdef mockCCInfoProvider_allCollectionsConfigPkgMutex;
	Mutexdef mockCCInfoProvider_allChaincodesInfoMutex;
	run mutexMonitor(mockCCInfoProvider_allChaincodesInfoMutex);
	run mutexMonitor(mockCCInfoProvider_allCollectionsConfigPkgMutex);
	run mutexMonitor(mockCCInfoProvider_chaincodeInfoMutex);
	run mutexMonitor(mockCCInfoProvider_collectionInfoMutex);
	run mutexMonitor(mockCCInfoProvider_generateImplicitCollectionForOrgMutex);
	run mutexMonitor(mockCCInfoProvider_implicitCollectionsMutex);
	run mutexMonitor(mockCCInfoProvider_namespacesMutex);
	run mutexMonitor(mockCCInfoProvider_updatedChaincodesMutex);
	run mutexMonitor(mockCCInfoProvider_invocationsMutex);
	run NewMgr43(mockCCInfoProvider_allChaincodesInfoMutex,mockCCInfoProvider_allCollectionsConfigPkgMutex,mockCCInfoProvider_chaincodeInfoMutex,mockCCInfoProvider_collectionInfoMutex,mockCCInfoProvider_generateImplicitCollectionForOrgMutex,mockCCInfoProvider_implicitCollectionsMutex,mockCCInfoProvider_invocationsMutex,mockCCInfoProvider_namespacesMutex,mockCCInfoProvider_updatedChaincodesMutex,child_NewMgr430);
	child_NewMgr430?0;
	

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

