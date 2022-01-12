// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//core/ledger/kvledger/history/db_test.go#L435
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestName4350 = [1] of {int};
	run TestName435(child_TestName4350);
	run receiver(child_TestName4350)
stop_process:skip
}

proctype TestName435(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_cleanup870 = [1] of {int};
	chan child_Name1901 = [1] of {int};
	Mutexdef env_testHistoryDB_levelDB_db_mutex;
	Mutexdef env_testHistoryDBProvider_leveldbProvider_mux;
	Mutexdef env_testHistoryDBProvider_leveldbProvider_db_mutex;
	Mutexdef env_txmgr_oldBlockCommit;
	Mutexdef env_txmgr_commitRWLock;
	Mutexdef env_testBookkeepingEnv_TestProvider_dbProvider_mux;
	Mutexdef env_testBlockStorageEnv_provider_leveldbProvider_mux;
	run mutexMonitor(env_testBlockStorageEnv_provider_leveldbProvider_mux);
	run mutexMonitor(env_testBookkeepingEnv_TestProvider_dbProvider_mux);
	run mutexMonitor(env_txmgr_commitRWLock);
	run mutexMonitor(env_txmgr_oldBlockCommit);
	run mutexMonitor(env_testHistoryDBProvider_leveldbProvider_db_mutex);
	run mutexMonitor(env_testHistoryDBProvider_leveldbProvider_mux);
	run mutexMonitor(env_testHistoryDB_levelDB_db_mutex);
	run Name190(env_testHistoryDB_levelDB_db_mutex,child_Name1901);
	child_Name1901?0;
		defer1: skip;
	run cleanup87(env_testBlockStorageEnv_provider_leveldbProvider_mux,env_testBookkeepingEnv_TestProvider_dbProvider_mux,env_testHistoryDB_levelDB_db_mutex,env_testHistoryDBProvider_leveldbProvider_db_mutex,env_testHistoryDBProvider_leveldbProvider_mux,env_txmgr_commitRWLock,env_txmgr_oldBlockCommit,child_cleanup870);
	child_cleanup870?0;
	stop_process: skip;
	child!0
}
proctype cleanup87(Mutexdef env_testBlockStorageEnv_provider_leveldbProvider_mux;Mutexdef env_testBookkeepingEnv_TestProvider_dbProvider_mux;Mutexdef env_testHistoryDB_levelDB_db_mutex;Mutexdef env_testHistoryDBProvider_leveldbProvider_db_mutex;Mutexdef env_testHistoryDBProvider_leveldbProvider_mux;Mutexdef env_txmgr_commitRWLock;Mutexdef env_txmgr_oldBlockCommit;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close631 = [1] of {int};
	chan child_cleanup1250 = [1] of {int};
	run cleanup125(env_testBlockStorageEnv_provider_leveldbProvider_mux,child_cleanup1250);
	child_cleanup1250?0;
	run Close63(env_testHistoryDBProvider_leveldbProvider_db_mutex,env_testHistoryDBProvider_leveldbProvider_mux,child_Close631);
	child_Close631?0;
	stop_process: skip;
	child!0
}
proctype cleanup125(Mutexdef env_provider_leveldbProvider_mux;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_removeFSPath1300 = [1] of {int};
	run removeFSPath130(env_provider_leveldbProvider_mux,child_removeFSPath1300);
	child_removeFSPath1300?0;
	stop_process: skip;
	child!0
}
proctype removeFSPath130(Mutexdef env_provider_leveldbProvider_mux;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Close63(Mutexdef p_leveldbProvider_db_mutex;Mutexdef p_leveldbProvider_mux;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Name190(Mutexdef d_levelDB_db_mutex;chan child) {
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

