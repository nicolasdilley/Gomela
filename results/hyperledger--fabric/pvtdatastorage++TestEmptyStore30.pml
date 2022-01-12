// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//core/ledger/pvtdatastorage/store_test.go#L30
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
	chan child_TestEmptyStore300 = [1] of {int};
	run TestEmptyStore30(child_TestEmptyStore300);
	run receiver(child_TestEmptyStore300)
stop_process:skip
}

proctype TestEmptyStore30(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Cleanup730 = [1] of {int};
	Mutexdef store_purgerLock;
	Mutexdef store_db_db_mutex;
	Wgdef store_db_db_db_closeW;
	Mutexdef store_db_db_db_compCommitLk;
	Mutexdef store_db_db_db_snapsMu;
	Mutexdef store_db_db_db_memMu;
	Mutexdef env_TestStore_purgerLock;
	Mutexdef env_TestStore_db_db_mutex;
	Mutexdef env_TestStoreProvider_dbProvider_mux;
	Mutexdef env_TestStoreProvider_dbProvider_db_mutex;
	run mutexMonitor(env_TestStoreProvider_dbProvider_db_mutex);
	run mutexMonitor(env_TestStoreProvider_dbProvider_mux);
	run mutexMonitor(env_TestStore_db_db_mutex);
	run mutexMonitor(env_TestStore_purgerLock);
	run mutexMonitor(store_db_db_db_memMu);
	run mutexMonitor(store_db_db_db_snapsMu);
	run mutexMonitor(store_db_db_db_compCommitLk);
	run wgMonitor(store_db_db_db_closeW);
	run mutexMonitor(store_db_db_mutex);
	run mutexMonitor(store_purgerLock);
		defer1: skip;
	run Cleanup73(env_TestStore_db_db_mutex,env_TestStore_purgerLock,env_TestStoreProvider_dbProvider_db_mutex,env_TestStoreProvider_dbProvider_mux,child_Cleanup730);
	child_Cleanup730?0;
	stop_process: skip;
	child!0
}
proctype Cleanup73(Mutexdef env_TestStore_db_db_mutex;Mutexdef env_TestStore_purgerLock;Mutexdef env_TestStoreProvider_dbProvider_db_mutex;Mutexdef env_TestStoreProvider_dbProvider_mux;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close1960 = [1] of {int};
	run Close196(env_TestStoreProvider_dbProvider_db_mutex,env_TestStoreProvider_dbProvider_mux,child_Close1960);
	child_Close1960?0;
	stop_process: skip;
	child!0
}
proctype Close196(Mutexdef p_dbProvider_db_mutex;Mutexdef p_dbProvider_mux;chan child) {
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

