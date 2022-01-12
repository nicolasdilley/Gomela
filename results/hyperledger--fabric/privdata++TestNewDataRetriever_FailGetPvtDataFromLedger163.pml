// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//gossip/privdata/dataretriever_test.go#L163
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNewDataRetriever_FailGetPvtDataFromLedger1630 = [1] of {int};
	run TestNewDataRetriever_FailGetPvtDataFromLedger163(child_TestNewDataRetriever_FailGetPvtDataFromLedger1630);
	run receiver(child_TestNewDataRetriever_FailGetPvtDataFromLedger1630)
stop_process:skip
}

proctype TestNewDataRetriever_FailGetPvtDataFromLedger163(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_tearDown1820 = [1] of {int};
	chan child_NewDataRetriever421 = [1] of {int};
	Mutexdef store_store_db_db_mutex;
	run mutexMonitor(store_store_db_db_mutex);
	run NewDataRetriever42(store_store_db_db_mutex,child_NewDataRetriever421);
	child_NewDataRetriever421?0;
		defer1: skip;
	run tearDown182(store_store_db_db_mutex,child_tearDown1820);
	child_tearDown1820?0;
	stop_process: skip;
	child!0
}
proctype tearDown182(Mutexdef s_store_db_db_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype NewDataRetriever42(Mutexdef store_db_db_mutex;chan child) {
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

