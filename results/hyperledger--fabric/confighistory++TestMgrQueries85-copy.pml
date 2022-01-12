// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//core/ledger/confighistory/mgr_test.go#L85
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestMgrQueries850 = [1] of {int};
	run TestMgrQueries85(child_TestMgrQueries850);
	run receiver(child_TestMgrQueries850)
stop_process:skip
}

proctype TestMgrQueries85(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_testutilEquipMockCCInfoProviderToReturnDesiredCollConfig5931 = [1] of {int};
	chan child_testutilEquipMockCCInfoProviderToReturnDesiredCollConfig5932 = [1] of {int};
	chan child_testutilEquipMockCCInfoProviderToReturnDesiredCollConfig5933 = [1] of {int};
	chan child_testutilEquipMockCCInfoProviderToReturnDesiredCollConfig5934 = [1] of {int};
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
	int var_m = -2; // opt var_m
	int var_configCommittingBlockNums = -2; // opt var_configCommittingBlockNums
	int var_ledgerIds = -2; // opt var_ledgerIds
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
	:: var_ledgerIds-1 != -3 -> 
				for(i : 0.. var_ledgerIds-1) {
			for10: skip;
			

			if
			:: var_configCommittingBlockNums-1 != -3 -> 
								for(i : 0.. var_configCommittingBlockNums-1) {
					for11: skip;
					run testutilEquipMockCCInfoProviderToReturnDesiredCollConfig593(mockCCInfoProvider_allChaincodesInfoMutex,mockCCInfoProvider_allCollectionsConfigPkgMutex,mockCCInfoProvider_chaincodeInfoMutex,mockCCInfoProvider_collectionInfoMutex,mockCCInfoProvider_generateImplicitCollectionForOrgMutex,mockCCInfoProvider_implicitCollectionsMutex,mockCCInfoProvider_invocationsMutex,mockCCInfoProvider_namespacesMutex,mockCCInfoProvider_updatedChaincodesMutex,child_testutilEquipMockCCInfoProviderToReturnDesiredCollConfig5931);
					child_testutilEquipMockCCInfoProviderToReturnDesiredCollConfig5931?0;
					for11_end: skip
				};
				for11_exit: skip
			:: else -> 
				do
				:: true -> 
					for12: skip;
					run testutilEquipMockCCInfoProviderToReturnDesiredCollConfig593(mockCCInfoProvider_allChaincodesInfoMutex,mockCCInfoProvider_allCollectionsConfigPkgMutex,mockCCInfoProvider_chaincodeInfoMutex,mockCCInfoProvider_collectionInfoMutex,mockCCInfoProvider_generateImplicitCollectionForOrgMutex,mockCCInfoProvider_implicitCollectionsMutex,mockCCInfoProvider_invocationsMutex,mockCCInfoProvider_namespacesMutex,mockCCInfoProvider_updatedChaincodesMutex,child_testutilEquipMockCCInfoProviderToReturnDesiredCollConfig5932);
					child_testutilEquipMockCCInfoProviderToReturnDesiredCollConfig5932?0;
					for12_end: skip
				:: true -> 
					break
				od;
				for12_exit: skip
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for13: skip;
			

			if
			:: var_configCommittingBlockNums-1 != -3 -> 
								for(i : 0.. var_configCommittingBlockNums-1) {
					for14: skip;
					run testutilEquipMockCCInfoProviderToReturnDesiredCollConfig593(mockCCInfoProvider_allChaincodesInfoMutex,mockCCInfoProvider_allCollectionsConfigPkgMutex,mockCCInfoProvider_chaincodeInfoMutex,mockCCInfoProvider_collectionInfoMutex,mockCCInfoProvider_generateImplicitCollectionForOrgMutex,mockCCInfoProvider_implicitCollectionsMutex,mockCCInfoProvider_invocationsMutex,mockCCInfoProvider_namespacesMutex,mockCCInfoProvider_updatedChaincodesMutex,child_testutilEquipMockCCInfoProviderToReturnDesiredCollConfig5933);
					child_testutilEquipMockCCInfoProviderToReturnDesiredCollConfig5933?0;
					for14_end: skip
				};
				for14_exit: skip
			:: else -> 
				do
				:: true -> 
					for15: skip;
					run testutilEquipMockCCInfoProviderToReturnDesiredCollConfig593(mockCCInfoProvider_allChaincodesInfoMutex,mockCCInfoProvider_allCollectionsConfigPkgMutex,mockCCInfoProvider_chaincodeInfoMutex,mockCCInfoProvider_collectionInfoMutex,mockCCInfoProvider_generateImplicitCollectionForOrgMutex,mockCCInfoProvider_implicitCollectionsMutex,mockCCInfoProvider_invocationsMutex,mockCCInfoProvider_namespacesMutex,mockCCInfoProvider_updatedChaincodesMutex,child_testutilEquipMockCCInfoProviderToReturnDesiredCollConfig5934);
					child_testutilEquipMockCCInfoProviderToReturnDesiredCollConfig5934?0;
					for15_end: skip
				:: true -> 
					break
				od;
				for15_exit: skip
			fi;
			for13_end: skip
		:: true -> 
			break
		od;
		for13_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype NewMgr43(Mutexdef ccInfoProvider_allChaincodesInfoMutex;Mutexdef ccInfoProvider_allCollectionsConfigPkgMutex;Mutexdef ccInfoProvider_chaincodeInfoMutex;Mutexdef ccInfoProvider_collectionInfoMutex;Mutexdef ccInfoProvider_generateImplicitCollectionForOrgMutex;Mutexdef ccInfoProvider_implicitCollectionsMutex;Mutexdef ccInfoProvider_invocationsMutex;Mutexdef ccInfoProvider_namespacesMutex;Mutexdef ccInfoProvider_updatedChaincodesMutex;chan child) {
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
proctype testutilEquipMockCCInfoProviderToReturnDesiredCollConfig593(Mutexdef mockCCInfoProvider_allChaincodesInfoMutex;Mutexdef mockCCInfoProvider_allCollectionsConfigPkgMutex;Mutexdef mockCCInfoProvider_chaincodeInfoMutex;Mutexdef mockCCInfoProvider_collectionInfoMutex;Mutexdef mockCCInfoProvider_generateImplicitCollectionForOrgMutex;Mutexdef mockCCInfoProvider_implicitCollectionsMutex;Mutexdef mockCCInfoProvider_invocationsMutex;Mutexdef mockCCInfoProvider_namespacesMutex;Mutexdef mockCCInfoProvider_updatedChaincodesMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

