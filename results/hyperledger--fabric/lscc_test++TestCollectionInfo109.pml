// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//core/scc/lscc/deployedcc_infoprovider_test.go#L109
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCollectionInfo1090 = [1] of {int};
	run TestCollectionInfo109(child_TestCollectionInfo1090);
	run receiver(child_TestCollectionInfo1090)
stop_process:skip
}

proctype TestCollectionInfo109(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AllCollectionsConfigPkg1264 = [1] of {int};
	chan child_AllCollectionsConfigPkg1263 = [1] of {int};
	chan child_CollectionInfo1312 = [1] of {int};
	chan child_CollectionInfo1311 = [1] of {int};
	chan child_CollectionInfo1310 = [1] of {int};
	Mutexdef mockQE_invocationsMutex;
	Mutexdef mockQE_getStateRangeScanIteratorWithPaginationMutex;
	Mutexdef mockQE_getStateRangeScanIteratorMutex;
	Mutexdef mockQE_getStateMultipleKeysMutex;
	Mutexdef mockQE_getStateMetadataMutex;
	Mutexdef mockQE_getStateMutex;
	Mutexdef mockQE_getPrivateDataRangeScanIteratorMutex;
	Mutexdef mockQE_getPrivateDataMultipleKeysMutex;
	Mutexdef mockQE_getPrivateDataMetadataByHashMutex;
	Mutexdef mockQE_getPrivateDataMetadataMutex;
	Mutexdef mockQE_getPrivateDataHashMutex;
	Mutexdef mockQE_getPrivateDataMutex;
	Mutexdef mockQE_executeQueryWithPaginationMutex;
	Mutexdef mockQE_executeQueryOnPrivateDataMutex;
	Mutexdef mockQE_executeQueryMutex;
	Mutexdef mockQE_doneMutex;
	run mutexMonitor(mockQE_doneMutex);
	run mutexMonitor(mockQE_executeQueryMutex);
	run mutexMonitor(mockQE_executeQueryOnPrivateDataMutex);
	run mutexMonitor(mockQE_executeQueryWithPaginationMutex);
	run mutexMonitor(mockQE_getPrivateDataMutex);
	run mutexMonitor(mockQE_getPrivateDataHashMutex);
	run mutexMonitor(mockQE_getPrivateDataMetadataMutex);
	run mutexMonitor(mockQE_getPrivateDataMetadataByHashMutex);
	run mutexMonitor(mockQE_getPrivateDataMultipleKeysMutex);
	run mutexMonitor(mockQE_getPrivateDataRangeScanIteratorMutex);
	run mutexMonitor(mockQE_getStateMutex);
	run mutexMonitor(mockQE_getStateMetadataMutex);
	run mutexMonitor(mockQE_getStateMultipleKeysMutex);
	run mutexMonitor(mockQE_getStateRangeScanIteratorMutex);
	run mutexMonitor(mockQE_getStateRangeScanIteratorWithPaginationMutex);
	run mutexMonitor(mockQE_invocationsMutex);
	run CollectionInfo131(mockQE_doneMutex,mockQE_executeQueryMutex,mockQE_executeQueryOnPrivateDataMutex,mockQE_executeQueryWithPaginationMutex,mockQE_getPrivateDataHashMutex,mockQE_getPrivateDataMetadataByHashMutex,mockQE_getPrivateDataMetadataMutex,mockQE_getPrivateDataMultipleKeysMutex,mockQE_getPrivateDataMutex,mockQE_getPrivateDataRangeScanIteratorMutex,mockQE_getStateMetadataMutex,mockQE_getStateMultipleKeysMutex,mockQE_getStateMutex,mockQE_getStateRangeScanIteratorMutex,mockQE_getStateRangeScanIteratorWithPaginationMutex,mockQE_invocationsMutex,child_CollectionInfo1310);
	child_CollectionInfo1310?0;
	run CollectionInfo131(mockQE_doneMutex,mockQE_executeQueryMutex,mockQE_executeQueryOnPrivateDataMutex,mockQE_executeQueryWithPaginationMutex,mockQE_getPrivateDataHashMutex,mockQE_getPrivateDataMetadataByHashMutex,mockQE_getPrivateDataMetadataMutex,mockQE_getPrivateDataMultipleKeysMutex,mockQE_getPrivateDataMutex,mockQE_getPrivateDataRangeScanIteratorMutex,mockQE_getStateMetadataMutex,mockQE_getStateMultipleKeysMutex,mockQE_getStateMutex,mockQE_getStateRangeScanIteratorMutex,mockQE_getStateRangeScanIteratorWithPaginationMutex,mockQE_invocationsMutex,child_CollectionInfo1311);
	child_CollectionInfo1311?0;
	run CollectionInfo131(mockQE_doneMutex,mockQE_executeQueryMutex,mockQE_executeQueryOnPrivateDataMutex,mockQE_executeQueryWithPaginationMutex,mockQE_getPrivateDataHashMutex,mockQE_getPrivateDataMetadataByHashMutex,mockQE_getPrivateDataMetadataMutex,mockQE_getPrivateDataMultipleKeysMutex,mockQE_getPrivateDataMutex,mockQE_getPrivateDataRangeScanIteratorMutex,mockQE_getStateMetadataMutex,mockQE_getStateMultipleKeysMutex,mockQE_getStateMutex,mockQE_getStateRangeScanIteratorMutex,mockQE_getStateRangeScanIteratorWithPaginationMutex,mockQE_invocationsMutex,child_CollectionInfo1312);
	child_CollectionInfo1312?0;
	run AllCollectionsConfigPkg126(mockQE_doneMutex,mockQE_executeQueryMutex,mockQE_executeQueryOnPrivateDataMutex,mockQE_executeQueryWithPaginationMutex,mockQE_getPrivateDataHashMutex,mockQE_getPrivateDataMetadataByHashMutex,mockQE_getPrivateDataMetadataMutex,mockQE_getPrivateDataMultipleKeysMutex,mockQE_getPrivateDataMutex,mockQE_getPrivateDataRangeScanIteratorMutex,mockQE_getStateMetadataMutex,mockQE_getStateMultipleKeysMutex,mockQE_getStateMutex,mockQE_getStateRangeScanIteratorMutex,mockQE_getStateRangeScanIteratorWithPaginationMutex,mockQE_invocationsMutex,child_AllCollectionsConfigPkg1263);
	child_AllCollectionsConfigPkg1263?0;
	run AllCollectionsConfigPkg126(mockQE_doneMutex,mockQE_executeQueryMutex,mockQE_executeQueryOnPrivateDataMutex,mockQE_executeQueryWithPaginationMutex,mockQE_getPrivateDataHashMutex,mockQE_getPrivateDataMetadataByHashMutex,mockQE_getPrivateDataMetadataMutex,mockQE_getPrivateDataMultipleKeysMutex,mockQE_getPrivateDataMutex,mockQE_getPrivateDataRangeScanIteratorMutex,mockQE_getStateMetadataMutex,mockQE_getStateMultipleKeysMutex,mockQE_getStateMutex,mockQE_getStateRangeScanIteratorMutex,mockQE_getStateRangeScanIteratorWithPaginationMutex,mockQE_invocationsMutex,child_AllCollectionsConfigPkg1264);
	child_AllCollectionsConfigPkg1264?0;
	stop_process: skip;
	child!0
}
proctype CollectionInfo131(Mutexdef qe_doneMutex;Mutexdef qe_executeQueryMutex;Mutexdef qe_executeQueryOnPrivateDataMutex;Mutexdef qe_executeQueryWithPaginationMutex;Mutexdef qe_getPrivateDataHashMutex;Mutexdef qe_getPrivateDataMetadataByHashMutex;Mutexdef qe_getPrivateDataMetadataMutex;Mutexdef qe_getPrivateDataMultipleKeysMutex;Mutexdef qe_getPrivateDataMutex;Mutexdef qe_getPrivateDataRangeScanIteratorMutex;Mutexdef qe_getStateMetadataMutex;Mutexdef qe_getStateMultipleKeysMutex;Mutexdef qe_getStateMutex;Mutexdef qe_getStateRangeScanIteratorMutex;Mutexdef qe_getStateRangeScanIteratorWithPaginationMutex;Mutexdef qe_invocationsMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fetchCollConfigPkg1450 = [1] of {int};
	int var_collConfigPkg_Config = -2; // opt var_collConfigPkg_Config
	run fetchCollConfigPkg145(qe_doneMutex,qe_executeQueryMutex,qe_executeQueryOnPrivateDataMutex,qe_executeQueryWithPaginationMutex,qe_getPrivateDataHashMutex,qe_getPrivateDataMetadataByHashMutex,qe_getPrivateDataMetadataMutex,qe_getPrivateDataMultipleKeysMutex,qe_getPrivateDataMutex,qe_getPrivateDataRangeScanIteratorMutex,qe_getStateMetadataMutex,qe_getStateMultipleKeysMutex,qe_getStateMutex,qe_getStateRangeScanIteratorMutex,qe_getStateRangeScanIteratorWithPaginationMutex,qe_invocationsMutex,child_fetchCollConfigPkg1450);
	child_fetchCollConfigPkg1450?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype fetchCollConfigPkg145(Mutexdef qe_doneMutex;Mutexdef qe_executeQueryMutex;Mutexdef qe_executeQueryOnPrivateDataMutex;Mutexdef qe_executeQueryWithPaginationMutex;Mutexdef qe_getPrivateDataHashMutex;Mutexdef qe_getPrivateDataMetadataByHashMutex;Mutexdef qe_getPrivateDataMetadataMutex;Mutexdef qe_getPrivateDataMultipleKeysMutex;Mutexdef qe_getPrivateDataMutex;Mutexdef qe_getPrivateDataRangeScanIteratorMutex;Mutexdef qe_getStateMetadataMutex;Mutexdef qe_getStateMultipleKeysMutex;Mutexdef qe_getStateMutex;Mutexdef qe_getStateRangeScanIteratorMutex;Mutexdef qe_getStateRangeScanIteratorWithPaginationMutex;Mutexdef qe_invocationsMutex;chan child) {
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
proctype AllCollectionsConfigPkg126(Mutexdef qe_doneMutex;Mutexdef qe_executeQueryMutex;Mutexdef qe_executeQueryOnPrivateDataMutex;Mutexdef qe_executeQueryWithPaginationMutex;Mutexdef qe_getPrivateDataHashMutex;Mutexdef qe_getPrivateDataMetadataByHashMutex;Mutexdef qe_getPrivateDataMetadataMutex;Mutexdef qe_getPrivateDataMultipleKeysMutex;Mutexdef qe_getPrivateDataMutex;Mutexdef qe_getPrivateDataRangeScanIteratorMutex;Mutexdef qe_getStateMetadataMutex;Mutexdef qe_getStateMultipleKeysMutex;Mutexdef qe_getStateMutex;Mutexdef qe_getStateRangeScanIteratorMutex;Mutexdef qe_getStateRangeScanIteratorWithPaginationMutex;Mutexdef qe_invocationsMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fetchCollConfigPkg1453 = [1] of {int};
	run fetchCollConfigPkg145(qe_doneMutex,qe_executeQueryMutex,qe_executeQueryOnPrivateDataMutex,qe_executeQueryWithPaginationMutex,qe_getPrivateDataHashMutex,qe_getPrivateDataMetadataByHashMutex,qe_getPrivateDataMetadataMutex,qe_getPrivateDataMultipleKeysMutex,qe_getPrivateDataMutex,qe_getPrivateDataRangeScanIteratorMutex,qe_getStateMetadataMutex,qe_getStateMultipleKeysMutex,qe_getStateMutex,qe_getStateRangeScanIteratorMutex,qe_getStateRangeScanIteratorWithPaginationMutex,qe_invocationsMutex,child_fetchCollConfigPkg1453);
	child_fetchCollConfigPkg1453?0;
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

