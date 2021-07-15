
// https://github.com/drone/drone/blob/master/store/secret/global/secret_test.go#L21
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSecret210 = [1] of {int};
	run TestSecret21(child_TestSecret210)
stop_process:skip
}

proctype TestSecret21(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Disconnect611 = [1] of {int};
	chan child_Reset440 = [1] of {int};
	chan child_testSecretCreate373 = [1] of {int};
	chan child_New182 = [1] of {int};
	Mutexdef store_db_conn_Mapper_mutex;
	Mutexdef conn_conn_Mapper_mutex;
	run mutexMonitor(conn_conn_Mapper_mutex);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(store_db_conn_Mapper_mutex);
	run New18(conn_conn_Mapper_mutex,child_New182);
	child_New182?0;
	run testSecretCreate37(store_db_conn_Mapper_mutex,child_testSecretCreate373);
	child_testSecretCreate373?0;
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
proctype New18(Mutexdef db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testSecretCreate37(Mutexdef store_db_conn_Mapper_mutex;chan child) {
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

