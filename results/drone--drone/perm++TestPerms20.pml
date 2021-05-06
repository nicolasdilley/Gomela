
// https://github.com/drone/drone/blob/master/store/perm/perm_test.go#L20
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPerms200 = [1] of {int};
	run TestPerms20(child_TestPerms200)
stop_process:skip
}

proctype TestPerms20(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Disconnect611 = [1] of {int};
	chan child_Reset440 = [1] of {int};
	chan child_testPermDelete1349 = [1] of {int};
	chan child_testPermUpdate1098 = [1] of {int};
	chan child_testPermList857 = [1] of {int};
	chan child_testPermFind746 = [1] of {int};
	chan child_testPermCreate585 = [1] of {int};
	chan child_New254 = [1] of {int};
	Mutexdef store_db_conn_Mapper_mutex;
	chan child_New253 = [1] of {int};
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
	run New25(conn_conn_Mapper_mutex,child_New253);
	child_New253?0;
	run mutexMonitor(store_db_conn_Mapper_mutex);
	run New25(conn_conn_Mapper_mutex,child_New254);
	child_New254?0;
	run testPermCreate58(store_db_conn_Mapper_mutex,child_testPermCreate585);
	child_testPermCreate585?0;
	run testPermFind74(store_db_conn_Mapper_mutex,child_testPermFind746);
	child_testPermFind746?0;
	run testPermList85(store_db_conn_Mapper_mutex,child_testPermList857);
	child_testPermList857?0;
	run testPermUpdate109(store_db_conn_Mapper_mutex,child_testPermUpdate1098);
	child_testPermUpdate1098?0;
	run testPermDelete134(store_db_conn_Mapper_mutex,child_testPermDelete1349);
	child_testPermDelete1349?0;
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
proctype testPermCreate58(Mutexdef store_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testPermFind74(Mutexdef store_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testPermList85(Mutexdef store_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testPermUpdate109(Mutexdef store_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testPermDelete134(Mutexdef store_db_conn_Mapper_mutex;chan child) {
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

