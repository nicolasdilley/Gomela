// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//core/ledger/pvtdatastorage/store_created_from_snapshot_test.go#L312
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestStoreCreationErrorPath3120 = [1] of {int};
	run TestStoreCreationErrorPath312(child_TestStoreCreationErrorPath3120);
	run receiver(child_TestStoreCreationErrorPath3120)
stop_process:skip
}

proctype TestStoreCreationErrorPath312(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close1960 = [1] of {int};
	Mutexdef configHistoryMgr_MockCCInfoProvider_invocationsMutex;
	Mutexdef configHistoryMgr_MockCCInfoProvider_updatedChaincodesMutex;
	Mutexdef configHistoryMgr_MockCCInfoProvider_namespacesMutex;
	Mutexdef configHistoryMgr_MockCCInfoProvider_implicitCollectionsMutex;
	Mutexdef configHistoryMgr_MockCCInfoProvider_generateImplicitCollectionForOrgMutex;
	Mutexdef configHistoryMgr_MockCCInfoProvider_collectionInfoMutex;
	Mutexdef configHistoryMgr_MockCCInfoProvider_chaincodeInfoMutex;
	Mutexdef configHistoryMgr_MockCCInfoProvider_allCollectionsConfigPkgMutex;
	Mutexdef configHistoryMgr_MockCCInfoProvider_allChaincodesInfoMutex;
	Mutexdef p_dbProvider_mux;
	Mutexdef p_dbProvider_db_mutex;
	Wgdef p_dbProvider_db_db_closeW;
	Mutexdef p_dbProvider_db_db_compCommitLk;
	Mutexdef p_dbProvider_db_db_snapsMu;
	Mutexdef p_dbProvider_db_db_memMu;
	run mutexMonitor(p_dbProvider_db_db_memMu);
	run mutexMonitor(p_dbProvider_db_db_snapsMu);
	run mutexMonitor(p_dbProvider_db_db_compCommitLk);
	run wgMonitor(p_dbProvider_db_db_closeW);
	run mutexMonitor(p_dbProvider_db_mutex);
	run mutexMonitor(p_dbProvider_mux);
	run mutexMonitor(configHistoryMgr_MockCCInfoProvider_allChaincodesInfoMutex);
	run mutexMonitor(configHistoryMgr_MockCCInfoProvider_allCollectionsConfigPkgMutex);
	run mutexMonitor(configHistoryMgr_MockCCInfoProvider_chaincodeInfoMutex);
	run mutexMonitor(configHistoryMgr_MockCCInfoProvider_collectionInfoMutex);
	run mutexMonitor(configHistoryMgr_MockCCInfoProvider_generateImplicitCollectionForOrgMutex);
	run mutexMonitor(configHistoryMgr_MockCCInfoProvider_implicitCollectionsMutex);
	run mutexMonitor(configHistoryMgr_MockCCInfoProvider_namespacesMutex);
	run mutexMonitor(configHistoryMgr_MockCCInfoProvider_updatedChaincodesMutex);
	run mutexMonitor(configHistoryMgr_MockCCInfoProvider_invocationsMutex);
		defer1: skip;
	run Close196(p_dbProvider_db_db_closeW,p_dbProvider_db_db_compCommitLk,p_dbProvider_db_db_memMu,p_dbProvider_db_db_snapsMu,p_dbProvider_db_mutex,p_dbProvider_mux,child_Close1960);
	child_Close1960?0;
	stop_process: skip;
	child!0
}
proctype Close196(Wgdef p_dbProvider_db_db_closeW;Mutexdef p_dbProvider_db_db_compCommitLk;Mutexdef p_dbProvider_db_db_memMu;Mutexdef p_dbProvider_db_db_snapsMu;Mutexdef p_dbProvider_db_mutex;Mutexdef p_dbProvider_mux;chan child) {
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
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

