// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//core/ledger/kvledger/txmgmt/statedb/stateleveldb/stateleveldb_test.go#L113
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestValueAndMetadataWrites1130 = [1] of {int};
	run TestValueAndMetadataWrites113(child_TestValueAndMetadataWrites1130);
	run receiver(child_TestValueAndMetadataWrites1130)
stop_process:skip
}

proctype TestValueAndMetadataWrites113(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Cleanup370 = [1] of {int};
	chan child_TestValueAndMetadataWrites7621 = [1] of {int};
	Mutexdef env_DBProvider_dbProvider_mux;
	Mutexdef env_DBProvider_dbProvider_db_mutex;
	run mutexMonitor(env_DBProvider_dbProvider_db_mutex);
	run mutexMonitor(env_DBProvider_dbProvider_mux);
	run TestValueAndMetadataWrites762(env_DBProvider_dbProvider_db_mutex,env_DBProvider_dbProvider_mux,child_TestValueAndMetadataWrites7621);
	child_TestValueAndMetadataWrites7621?0;
		defer1: skip;
	run Cleanup37(env_DBProvider_dbProvider_db_mutex,env_DBProvider_dbProvider_mux,child_Cleanup370);
	child_Cleanup370?0;
	stop_process: skip;
	child!0
}
proctype Cleanup37(Mutexdef env_DBProvider_dbProvider_db_mutex;Mutexdef env_DBProvider_dbProvider_mux;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close720 = [1] of {int};
	run Close72(env_DBProvider_dbProvider_db_mutex,env_DBProvider_dbProvider_mux,child_Close720);
	child_Close720?0;
	stop_process: skip;
	child!0
}
proctype Close72(Mutexdef provider_dbProvider_db_mutex;Mutexdef provider_dbProvider_mux;chan child) {
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
