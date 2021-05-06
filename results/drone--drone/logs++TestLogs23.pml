
// https://github.com/drone/drone/blob/master/store/logs/logs_test.go#L23
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLogs230 = [1] of {int};
	run TestLogs23(child_TestLogs230)
stop_process:skip
}

proctype TestLogs23(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Disconnect611 = [1] of {int};
	chan child_Reset440 = [1] of {int};
	chan child_testLogsDelete1129 = [1] of {int};
	chan child_testLogsUpdate888 = [1] of {int};
	chan child_testLogsFind707 = [1] of {int};
	chan child_testLogsCreate606 = [1] of {int};
	chan child_New285 = [1] of {int};
	Mutexdef store_db_conn_Mapper_mutex;
	chan child_New254 = [1] of {int};
	chan child_New323 = [1] of {int};
	chan child_New252 = [1] of {int};
	Mutexdef conn_conn_Mapper_mutex;
	run mutexMonitor(conn_conn_Mapper_mutex);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run New25(conn_conn_Mapper_mutex,child_New252);
	child_New252?0;
	run New32(conn_conn_Mapper_mutex,child_New323);
	child_New323?0;
	run New25(conn_conn_Mapper_mutex,child_New254);
	child_New254?0;
	run mutexMonitor(store_db_conn_Mapper_mutex);
	run New28(conn_conn_Mapper_mutex,child_New285);
	child_New285?0;
	run testLogsCreate60(store_db_conn_Mapper_mutex,child_testLogsCreate606);
	child_testLogsCreate606?0;
	run testLogsFind70(store_db_conn_Mapper_mutex,child_testLogsFind707);
	child_testLogsFind707?0;
	run testLogsUpdate88(store_db_conn_Mapper_mutex,child_testLogsUpdate888);
	child_testLogsUpdate888?0;
	run testLogsDelete112(store_db_conn_Mapper_mutex,child_testLogsDelete1129);
	child_testLogsDelete1129?0;
	stop_process: skip;
		run Reset44(conn_conn_Mapper_mutex,child_Reset440);
	child_Reset440?0;
	run Disconnect61(conn_conn_Mapper_mutex,child_Disconnect611);
	child_Disconnect611?0;
	child!0
}
proctype Reset44(Mutexdef d_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Disconnect61(Mutexdef d_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype New25(Mutexdef db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testLogsCreate60(Mutexdef store_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testLogsFind70(Mutexdef store_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testLogsUpdate88(Mutexdef store_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testLogsDelete112(Mutexdef store_db_conn_Mapper_mutex;chan child) {
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

